#' Plot spatially resolved luminescence images
#'
#' Displays a single- or multi-layer SpatRaster (or object coercible to one)
#' as a false-color image with a custom wavelength-based color ramp.
#'
#' @param obj
#' Image or stack of images (coercible to SpatRaster) to plot.
#'
#' @param title
#' Plot title(s), forwarded to terra::plot(). Accepts also vectors, then each
#' image in a sequence of image gets a specific title.
#'
#' @param label
#' Text label drawn in the bottom-left corner of the image (e.g. a file name).
#' works only for single images.
#'
#' @param range
#' Numeric vector of length 2 giving the color scale limits. If NA (default),
#' a range is estimated via get_image_scale().
#'
#' @param color.scale
#' Currently without effect; reserved for future use.
#'
#' @param wavelength
#' Wavelength (nm) used to generate the color ramp via wavelength_to_rgb().
#'
#' @param legend
#' If TRUE (default), draw a color legend. Only applied for single-layer images.
#'
#' @param axes
#' If TRUE (default), draw axes. Only applied for single-layer images.
#'
#' @param margin
#' Plot margin (all sides except right, if legend is drawn).
#'
#' @param max.layer
#' Maximum number of layers to plot for multi-layer images.
#'
#' @param contains.outlier
#' If TRUE, the estimated range accounts for outliers and out-of-range
#' values are shown in white.
#'
#' @param rois
#' Optional regions-of-interest to overlay on the image as circles. Accepts
#' either the named list returned by \code{select_grains()} or a
#' \code{data.frame} with (at least) the columns \code{x_coord}, \code{y_coord},
#' \code{radius_px} and \code{class} (and, optionally, \code{id}). Only used
#' for single-layer images; ignored (with a warning) for multi-layer stacks.
#'
#' @param roi.lwd
#' TODO
#'
#' @param roi.ids
#' Whether the ROI ids should be printed at the centre of each ROI overlay
#' (`FALSE` by default). Only applied together with `rois`.
#'
#' @param roi.cex
#' Scaling factor to control the font size for the ROI ids. Only applied
#' if `roi.ids = TRUE`.
#'
#' @param classes
#' Named character vector mapping ROI class labels to display colours, e.g.
#' \code{c("Quartz" = "yellow", "Other" = "magenta")}. Used only together with
#' \code{rois}. Defaults to the same five preset mineral classes used by
#' \code{select_grains()}. Classes present in \code{rois} but missing from
#' this vector are drawn in white and trigger a warning.
#'
#' @returns
#' Invisibly returns NULL; the image is plotted as a side effect.
#'
#' @export
plot_image <- function(
  obj,
  title = NA,
  label = NA,
  range = NA,
  color.scale = NA, # Without effect yet
  wavelength = NA,
  legend = TRUE, # Valid only for single layer images
  axes = TRUE, # Valid only for single layer images
  margin = 1.13,
  max.layer = 6,
  contains.outlier = FALSE,
  rois = NULL,
  roi.lwd = 1,
  roi.ids = FALSE,
  roi.cex = 1.1,
  classes = NULL
) {

  ## ------ Changelog ------
  ## 2026-08-14, DM, Claude Sonnet 5: Added 'rois', 'classes' and 'show.numbers' arguments to draw
  ##   ROI circle overlays (moved over from select_grains()'s renderPlot()).
  ## 2026-09-09, DM: Updated ROI overlay plotting to support new ROI object structure and not-circular ROIs

  ## ToDos:
  ## - Add 'color.scale'. Consider to remove 'wavelength' and handle color.scale
  ##   like wavelength if an integer value is set
  ## - Add 'layers' argument. Display warning if N_layers exceeds max.layer
  ## - Add zoom and shift arguments. Display zoom and shifting as small text
  ##   at the bottom of the image
  ## - If a list of pictures is provided, display N_max.layer of them but with the same
  ##   scaling and just one range
  ## - Enable label vectors or provide a better error handling
  ## - Define default ROI classes somewhere else and just load it here

  # Import image
  img <- as.SpatRaster(obj, warnings = FALSE, verbose = FALSE)

  # If image is a single-image file, display the file name
  if (any(is.na(label))
      && inherits(obj, "character")
      && length(obj) == 1)
    label <- basename(obj)

  # If no range is set, calculate one
  if (any(is.na(range)))
    range <- get_image_scale(img, contains.outlier = contains.outlier)

  # Create custom color ramp
  col_gradient <- sapply(
    seq(0, 1, length.out = 64),
    wavelength_to_rgb,
    wl = wavelength)

  if (contains.outlier) col_gradient[64] <- "white"

  custom_cols <- colorRampPalette(
    col_gradient,
    bias = 1.8)(64)


  # Clamp the raster (cutting values outside the contrast range)
  # BUT WHY? The range value can be assigned directly. However, then all values
  # outside the range get the same background color, no matter if they are above
  # or below the scaling limits
  img <- terra::clamp(img,
                      lower = range[1],
                      upper = range[2],
                      values = TRUE)

  # Use the user arguments only in case of a single layer image
  # Otherwise,
  img_axes <- img_legend <- FALSE
  if (terra::nlyr(img) == 1) {
    img_axes <- axes
    img_legend <- legend}

  # Set plotting margins
  margin_right <- margin
  if (img_legend) margin_right <- 4 + margin

  # Plot with stretch
  terra::plot(
    img,
    stretch = "lin",
    col = custom_cols,
    legend = img_legend,
    background = custom_cols[1], # Ensure the background is black
    axes = img_axes,
    range = range,
    main = title,
    maxnl = max.layer,
    mar=c(margin, margin, margin, margin_right)
  )

  # If input object was a file path, display the file name
  if (!any(is.null(label)) && !any(is.na(label))) {

    # Get the extent to position the text
    e <- terra::ext(img)
    x_pos <- e$xmin + (e$xmax - e$xmin) * 0.05   # 5% from left
    y_pos <- e$ymin + (e$ymax - e$ymin) * 0.05   # 5% from bottom

    terra::text(
      x = x_pos, y = y_pos,
      labels = label,
      col = "white", cex = 0.8, font = 2,   # font=2 is bold
      adj = c(0, 0))                        # left-bottom aligned
  }

  # Leave here if no ROIs are given
  if (length(rois) < 1) return(invisible(NULL))

  if (terra::nlyr(img) != 1) {
    warning("'rois' overlay is only supported for single-layer images; ",
            "ignoring 'rois'.")
    return(invisible(NULL))
  }

  # ── ROI overlay ──────────────────────────────────────────────────────────

  # Default mineral classes and their display colours, matching
  # select_grains()'s defaults
  if (is.null(classes)) {
    classes <- .default_mineral_classes()
  }

  # Pixel size in spatial units, needed to scale pixel-radius circles
  # to the coordinate system
  xres <- terra::xres(img)
  yres <- terra::yres(img)

  i <- 0
  for (roi in rois) {
    i <- i + 1

    # Set ROI color
    clr <- as.character(classes[roi$class])

    if (is.null(clr)) clr <- "white" # Default value

    # Decide the drawing function based on the ROI shape
    if(roi$shape == "circle"){

      x <- roi$overlay$x
      y <- roi$overlay$y
      r <- roi$overlay$r

      # Ensure the necessary data is stored in the ROI object
      if (is.null(x) || is.null(y) || is.null(r)) {
        warning("[plot_image()] ROI overlay data missing. ROI was not drawn.")
        next # Jump to next ROI
      }

      # Number of polygons to the draw circle
      polygon_n <- 4 + r^2
      if (polygon_n > 300) polygon_n <- 300
      polygon_t <- seq(0, 2 * pi, length.out = polygon_n)

      # Convert pixel radius to spatial units separately for x and y,
      # because the pixel aspect ratio may differ from 1:1
      r_x <- r * xres
      r_y <- r * yres

      # Draw the ROI boundary as a (possibly elliptical) circle
      # (base graphics, not terra::lines/terra::text, since we're
      # drawing on top of the already-rendered terra::plot device)
      graphics::lines(x + r_x * cos(polygon_t),
                      y + r_y * sin(polygon_t),
                      col = clr,
                      lwd = roi.lwd)

      # Optionally print the ROI ID number at the circle centre
      if (roi.ids)
        graphics::text(x, y, labels = as.character(i),
                       col = clr, cex = roi.cex, font = 2)

   } else if (roi$shape == "rectangle") {

      dx_px <- roi$overlay$dx
      dy_px <- roi$overlay$dy

      if (is.null(dx_px) || is.null(dy_px)) {
        warning("[plot_image()] Rectangle ROI dimensions missing. ROI was not drawn.")
        next
      }

      x_min <- terra::xFromCol(img, roi$col_min)
      y_min <- terra::yFromRow(img, roi$row_min)
      x_max <- terra::xFromCol(img, roi$col_min + dx_px)
      y_max <- terra::yFromRow(img, roi$row_min + dy_px)

      graphics::lines(c(x_min, x_max, x_max, x_min, x_min),
                      c(y_min, y_min, y_max, y_max, y_min),
                      col = clr, lwd = roi.lwd)

      if (roi.ids) {
        graphics::text((x_min + x_max) / 2, (y_min + y_max) / 2,
                       labels = as.character(i),
                       col = clr, cex = roi.cex, font = 2)
      }
    }
  }
}
