#' Interactively select grains (regions of interest) in a luminescence image stack
#'
#' @description
#' Opens an interactive \pkg{shiny} app that lets the user place circular
#' regions of interest (ROIs) on a reference image derived from a
#' luminescence image stack, assign a mineral class to each ROI, and - after
#' closing the app - return the resulting per-grain ROIs in the format used
#' by [set_roi] and [apply_rois].
#'
#' The image stack is combined into a single reference image (pixel-wise
#' mean) for display and for mapping mouse clicks to raster coordinates.
#' ROIs can be placed manually by clicking on the image, or detected
#' automatically via [find_grains] (which replaces the current ROI set).
#' The mineral class and the ROI radius are set before placement; ROI ids
#' follow the order in which the grains are placed or, after sorting,
#' the top-to-bottom, left-to-right order.
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param rois
#' A list of ROI objects (as returned by a previous call to [select_grains])
#' used to pre-populate the session with existing ROIs.
#'
#' @param classes
#' Named character vector (or list) mapping mineral class labels to display
#' colours, e.g. `c(Quartz = "yellow", Other = "magenta")`. Used for the class
#' selector, the ROI overlay in [plot_image] and the colour swatches in the ROI
#' table. Defaults to five preset mineral classes.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A list of `RLumImage.ROI` objects, one per grain. Each ROI holds a circular
#' `mask`, its position (`col_min`, `row_min`) and `shape`, the assigned mineral
#' `class`, `info` (with `source` and the mean signal `average`) and an
#' `overlay` describing the circle for plotting.
#'
#' @examples
#' \dontrun{
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#'
#' # Select grains in a multi-layer image stack
#' rois <- select_grains(file)
#'
#' # Resume a previous session and add more ROIs
#' rois2 <- select_grains(file, rois = rois)
#' }
#'
#' @export
select_grains <- function(
  obj,
  rois = list(),
  classes = NULL,
  verbose = TRUE
) {

  ## ------ Changelog ------
  ## 2026-09-14, DM: Reworked to store ROIs in the set_roi() list structure
  ##   instead of a flat data.frame; removed the CSV export option.

  ## ToDo's
  ## - Is it possible to start the app in fullscreen automatically in RStudio?
  ## - Make more use of the info text fields at the top (for example: dynamic informations)
  ## - Update the value in the "Threshold" box after performing "find grains"
  ## - Allow coloured and multispectral images
  ## - Reduce reaction time / improve performance. Ideas:
  ##    o Do not re-plot the whole image, just plot the ROI overlay (re-use the overlay code from plot_image.R)
  ##    o Create the ROI mask only when the radius is set, then use the same pre-defined for all ROIs
  ##    o Do not create the data.frame for the ROI table on the right side from scratch each time. Just append the new ROI


  # ── Default mineral classes and their display colours ─────────────────────
  if (is.null(classes)) {
    classes <- .default_mineral_classes()
  }

  # Remember the name of the input object for the ROI info slot
  source_obj <- deparse(substitute(obj))

  # ── 1. Prepare the image stack ────────────────────────────────────────────

  # Convert the input object to a terra SpatRaster (multi-layer image stack)
  img_stack <- as.SpatRaster(obj, verbose = verbose)

  # Derive a single-layer reference image for display and click-coordinate
  # mapping. For multi-layer stacks the pixel-wise mean is used; for
  # single-layer input the layer itself serves directly as the reference.
  if (terra::nlyr(img_stack) > 1L) {

    # TODO: Combine images depending on their record type
    ref_img <- terra::app(img_stack, fun = mean, na.rm = TRUE)
    if (verbose) cat("Created median image from input image stack.\n")
  } else {
    ref_img <- img_stack
  }
  names(ref_img) <- "reference"

  # Determine a sensible display range for the brightness slider
  img_scale        <- get_signal_range(ref_img, contains.outlier = FALSE)
  img_scale_margin <- ceiling(diff(img_scale) / 2)

  nrows_img <- terra::nrow(img_stack)
  ncols_img <- terra::ncol(img_stack)
  default_radius <- ceiling(nrows_img / 100)


  # ── 2. Helper functions ───────────────────────────────────────────────────
  # All helpers are defined inside select_grains() so they share its
  # environment and can access img_stack, ref_img, etc.


  # Build a circular ROI object (set_roi() format) from click parameters. The
  # mask is built from the given (possibly fractional) radius.
  # The ROI bounding box must fit within the image; otherwise NULL is returned
  # and the click is ignored.
  make_roi <- function(row_px, col_px,
                       radius, class_label,
                       x_coord, y_coord) {

    col_min <- col_px - radius
    col_max <- col_px + radius
    row_min <- row_px - radius
    row_max <- row_px + radius

    # Ignore clicks whose ROI circle would extend beyond the image extent
    if (col_min < 1 || col_max > ncols_img ||
        row_min < 1 || row_max > nrows_img)
      return(NULL)

    # Create ROI mask
    m <- floor(radius + 1) # Middle point
    d <- m + floor(radius) # Edge length

    # Calculate the distances of each cell to the middle point (later, the maximum)
    grid_rows <- rep(1:d, each = d)
    grid_cols <- rep(1:d, times = d)
    distances_sq <- (grid_rows - m)^2 + (grid_cols - m)^2

    # Now create a 2-D TRUE/FALSE matrix
    mask <- matrix(distances_sq <= radius^2, ncol = d)

    average <- mean(ref_img[col_min:col_max, row_min:row_max][mask],
                    na.rm = TRUE)

    if (verbose) cat("ROI set by user (r =", radius,
                     "px, A =", sum(mask), "px, \u00b5 =", formatC(average), "cts/px)\n") # \u00b5 is µ

    set_roi(
      mask    = mask,
      col_min = col_min,
      row_min = row_min,
      shape   = "circle",
      class   = class_label,
      info    = list(
        source_function = "select_grains",
        source_obj = source_obj,
        source_ncols = ncols_img,
        source_nrows = nrows_img,
        average = average),
      overlay = list(
        x = x_coord,
        y = y_coord,
        r = radius)
    )
  }

  # Compact table for the DT widget, built on demand from the ROI list
  roi_table <- function(roi_list) {

    if (length(roi_list) == 0L) return(data.frame())
    data.frame(
      id = seq_along(roi_list),
      class = vapply(roi_list, function(r) r$class, character(1)),
   #   area = vapply(roi_list, function(r) sum(r$mask), numeric(1)),
      avg_signal = vapply(roi_list, function(r) r$info$average, numeric(1)),
      stringsAsFactors = FALSE
    )
  }

  # Reassign sequential ids after sorting
  renumber <- function(roi_list) {
    for (i in seq_along(roi_list)) roi_list[[i]]$info$id <- i
    roi_list
  }


  # ── 3. Pre-populate from a previous call if supplied ──────────────────────
  # rois is expected to be a list of ROI objects (set_roi() format), as
  # returned by a previous select_grains() call.
  valid.rois <- vapply(rois, inherits, "RLumImage.ROI", FUN.VALUE = logical(1))
  if (!all(valid.rois))
    stop("'rois' must be a list of 'RLumImage.ROI' objects")
  init_rois <- rois


  # ── 4. UI definition ──────────────────────────────────────────────────────
  ui <- shiny::fluidPage(

   # shiny::titlePanel("Grain selection"),

    # Custom CSS: reduce font size and row height in the DT table so that
    # more ROIs are visible at once without scrolling
    shiny::tags$style(shiny::HTML("
      #roi_table table.dataTable { font-size: 0.7em; }
      #roi_table table.dataTable tbody tr td,
      #roi_table table.dataTable thead tr th {
        padding-top: 2px !important;
        padding-bottom: 2px !important;
        line-height: 1.2;
      }
      /* Pin the image plot to the top of its column instead of being
         vertically centred against the taller row */
      #img_plot {
        display: block !important;
        margin-top: 0 !important;
        vertical-align: top;
      }
    ")),

    shiny::sidebarLayout(

      # ── Left sidebar: all user controls ───────────────────────────────────
      shiny::sidebarPanel(
        width = 2,

        # Brightness / contrast slider for the reference image
        shiny::sliderInput("scale", "Display range:",
                           min   = img_scale[1L] - img_scale_margin,
                           max   = img_scale[2L] + img_scale_margin,
                           value = img_scale),

        shiny::checkboxInput("show_labels", "Show ROI numbers",
                             value = TRUE),
        shiny::br(),

        # Mineral class selector; the colour value is used for the ROI overlay
        shiny::selectInput("roi_color", "Grain class:",
                           choices  = classes,
                           selected = classes[1L]),

        shiny::numericInput("radius", "Radius (pixels):",
                            value = default_radius,
                            min = 0,
                            max = floor(min(nrows_img, ncols_img) / 2),
                            step = 1L),

        # Automatic grain detection via find_grains()
        shiny::tags$b("Automatic grain detection"),

        shiny::numericInput("fg_threshold", "Threshold [cts/px]:",
                            value = NA, step = 1),

        shiny::numericInput("fg_grain_density", "Grain density:",
                            value = 0.10,
                            step = 0.01,
                            min = 0,
                            max = 1),

        shiny::actionButton("find_grains_btn", "Find grains",
                            icon  = shiny::icon("wand-magic-sparkles"),
                            class = "btn-primary btn-sm",
                            style = "width:100%;"),
        shiny::tags$p(
          style = "font-size:0.85em; color:#777; margin-top:4px;",
          "WARNING: Previous ROIs are deleted."
        ),

        shiny::hr(),

        # ROI editing buttons
        shiny::actionButton("undo_btn", "Undo last ROI",
                            icon  = shiny::icon("rotate-left"),
                            class = "btn-warning btn-sm",
                            style = "width:100%;"),
        shiny::br(), shiny::br(),
        shiny::actionButton("clear_sel_btn", "Clear selected ROIs",
                            icon  = shiny::icon("circle-minus"),
                            class = "btn-warning btn-sm",
                            style = "width:100%;"),
        shiny::br(), shiny::br(),
        shiny::actionButton("clear_btn", "Clear all ROIs",
                            icon  = shiny::icon("trash"),
                            class = "btn-danger btn-sm",
                            style = "width:100%;"),
        shiny::br(), shiny::br(),
        shiny::actionButton("sort_btn", "Sort ROIs top-down",
                            icon  = shiny::icon("arrow-down-a-z"),
                            class = "btn-info btn-sm",
                            style = "width:100%;"),

        shiny::hr(),

        # Closes the app and returns the ROI list to the calling R session
        shiny::actionButton("done_btn", "Done",
                            icon  = shiny::icon("circle-check"),
                            class = "btn-success btn-block",
                            style = "width:100%;")
      ),

      # ── Main panel: reference image (left) + ROI table (right) ────────────
      shiny::mainPanel(
        width = 9,

        shiny::fluidRow(

          shiny::tags$p(
            shiny::tags$b("Layers:"), terra::nlyr(img_stack), " | ",
            shiny::tags$b("Dimensions:"),
            terra::nrow(img_stack), "\u00d7", terra::ncol(img_stack), "px"
          ),
          shiny::tags$p(
            shiny::icon("circle-info"),
            "Click anywhere on the image to select a grain or set 'Threshold' or",
            "'Grain density' and click 'Find grains' to detect automatically.",
            "Click \u201cDone\u201d to close and return results."
          ),

          # Reference image with ROI circle overlays; click events are captured
          shiny::column(
            width = 9,
            shiny::plotOutput("img_plot", click = "img_click",   height = "800px")
          ),

          # Compact ROI table for quick inspection and multi-row selection
          shiny::column(
            width = 3,
            DT::DTOutput("roi_table")
          )
        )
      )
    )
  )


  # ── 5. Server logic ───────────────────────────────────────────────────────
  server <- function(input, output, session) {

    # Central reactive value: a list of ROI objects (set_roi() format).
    # Every observer either reads from or writes to this value, triggering
    # reactive re-rendering whenever it is consumed.
    rois <- shiny::reactiveVal(init_rois)


    # ── 5a. Reference image with ROI circle overlays ─────────────────────────
    # ROI overlay drawing lives in plot_image() (rois/classes/show.numbers
    # arguments); this just forwards the current reactive state.
    output$img_plot <- shiny::renderPlot({

      roi_obj <- rois()
      if (length(roi_obj) == 0L) roi_obj <- NULL

      plot_image(ref_img,
                 range            = input$scale,
                 contains.outlier = FALSE,
                 rois             = roi_obj,
                 classes          = classes,
                 roi.ids          = input$show_labels)
    })


    # ── 5b. Image click → place a new ROI ────────────────────────────────────
    shiny::observeEvent(input$img_click, {
      cl <- input$img_click
      shiny::req(cl)   # guard against spurious NULL events

      x <- cl$x
      y <- cl$y

      # Convert click coordinates (spatial units) to pixel column / row
      col_px <- terra::colFromX(ref_img, x)
      row_px <- terra::rowFromY(ref_img, y)

      # Ignore clicks that fall outside the raster extent
      if (is.na(col_px) || is.na(row_px)) return()

      cur <- rois()

      new_roi <- make_roi(
        row_px      = row_px,
        col_px      = col_px,
        radius      = input$radius,
        class_label = names(which(classes == input$roi_color))[1L],
        x_coord     = round(x, 6L),
        y_coord     = round(y, 6L)
      )

      # make_roi() returns NULL when the ROI would extend beyond the image
      if (is.null(new_roi)) return()

      rois(c(cur, list(new_roi)))
    })


    # ── 5c. Automatic grain detection via find_grains() ───────────────────────
    shiny::observeEvent(input$find_grains_btn, {

      # find_grains() needs at least one of 'threshold' or 'grain.density'
      if (is.na(input$fg_threshold) && is.na(input$fg_grain_density)) {
        shiny::showNotification(
          "Set a 'Threshold' or a 'Grain density' before detecting grains.",
          type = "error")
        return()
      }

      # Delete current ROI list
      rois(list())
      if (verbose) cat("Delete previous ROI list.\n")

      found <- find_grains(
        obj           = ref_img,
        radius        = input$radius,
        threshold     = input$fg_threshold,
        grain.density = input$fg_grain_density,
        default.class = names(which(classes == input$roi_color)),
        plot          = FALSE,
        verbose       = verbose
      )

      if (length(found) == 0L) {
        shiny::showNotification("No grains found with the given parameters.", type = "message")
      } else  {
        shiny::showNotification(paste("Found", length(found), "grains."), type = "message")
      }

      rois(found)
    })

    # ── 5d. Undo / clear buttons ──────────────────────────────────────────────

    # Remove only the most recently placed ROI
    shiny::observeEvent(input$undo_btn, {
      cur <- rois()
      if (length(cur) > 0L) rois(cur[-length(cur)])
      if (verbose) cat("Last ROI deleted by user.\n")
    })

    # Remove all ROIs at once, resetting to an empty canvas
    shiny::observeEvent(input$clear_btn, {
      rois(list())
      if (verbose) cat("All ROIs deleted by user.\n")
    })


    # ── 5e. Remove only the rows selected in the DT table ────────────────────
    shiny::observeEvent(input$clear_sel_btn, {
      sel <- input$roi_table_rows_selected   # integer vector of selected rows
      if (length(sel) == 0L) return()
      rois(rois()[-sel])
      if (verbose) cat("ROIs", paste(sel, collapse = ", "), "deleted by user.\n")
    })


    # ── 5f. Sort ROIs top-to-bottom, left-to-right; reassign sequential IDs ──
    shiny::observeEvent(input$sort_btn, {
      cur <- rois()
      if (length(cur) < 2L) return()
      # Primary sort: descending y (top of image first); secondary: ascending x
      ord <- order(
        -vapply(cur, function(r) r$overlay$y, numeric(1)),
         vapply(cur, function(r) r$overlay$x, numeric(1))
      )
      rois(renumber(cur[ord]))
      if (verbose) cat("ROIs sorted top-to-down by user.\n")
    })


    # ── 5g. Render the compact ROI table (right panel) ────────────────────────
    output$roi_table <- DT::renderDT({
      tab <- roi_table(rois())

      # Show a placeholder message when no ROIs have been placed yet
      if (nrow(tab) == 0L) {
        return(DT::datatable(
          data.frame(status = "No ROIs placed yet."),
          options  = list(dom = "t"),
          rownames = FALSE
        ))
      }

      # Build an inline HTML colour swatch for each row in the class column
      swatch <- paste0(
        '<span style="display:inline-block;width:10px;height:10px;background:',
        classes[tab$class],
        ';border:1px solid #666;margin-right:4px;vertical-align:middle;"></span>',
        tab$class
      )

      DT::datatable(
        data.frame(
          id         = tab$id,
          class      = swatch,
       #   area       = tab$area,
          avg_signal = round(tab$avg_signal, 1L),
          stringsAsFactors = FALSE
        ),
        escape    = FALSE,       # allow the HTML swatch to render
        selection = "multiple",  # enable multi-row selection for bulk delete
        options   = list(pageLength = nrow(tab), dom = "t"),
        rownames  = FALSE,
        colnames  = c("", "Class", "Average")
        #colnames  = c("No.", "Class", "Area [px]" , "Average [cts/px]")
      )
    })


    # ── 5h. "Done" button: return the ROI list and close the app ─────────────
    shiny::observeEvent(input$done_btn, {
      shiny::stopApp(rois())
    })

    # Fallback: also return results when the user closes the browser tab
    # without clicking "Done". isolate() is required to read a reactive value
    # outside a reactive context (inside the session-ended callback).
    session$onSessionEnded(function() {
      shiny::stopApp(shiny::isolate(rois()))
    })
  }


  # ── 6. Launch the app (blocking call) and return the ROI list ────────────
  # runApp() blocks until stopApp() is called, then returns whatever value
  # was passed to stopApp() — here the list of ROI objects (set_roi() format).
  shiny::runApp(shiny::shinyApp(ui, server))
}
