#' Apply ROIs to an image stack
#'
#' Extract mean values within circular regions of interest (ROIs) across
#' an image stack and optionally plot the time series.
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param rois
#' A named list of ROI objects, each with fields `mask` (a logical matrix
#' defining the ROI shape), `row_min` and `col_min` (the top-left corner of
#' the ROI bounding box in the image), and `class`. This is the format returned
#' by [find_grains] and [select_grains].
#'
#' @param record.type
#' Placeholder for future functionality (not currently used).
#'
#' @param x.interval
#' Time spacing between frames (1 by default).
#'
#' @param x.unit
#' X-axis unit, e.g. `"s"` or `"Gy"`, to be used in the automatic construction
#' of axis labels.
#'
#' @param plot
#' Whether to plot the time series (`TRUE` by default).
#'
#' @param xlab
#' X-axis label. If `NA` (default), it is constructed automatically.
#'
#' @param ylab
#' Y-axis label. If `NA` (default), it is constructed automatically.
#'
#' @param legend
#' Whether a legend should be added to the plot (`TRUE` by default).
#' TODO: This is currently not functional.
#'
#' @param col
#' Colour specification for [matplot] lines. If `NULL`, default colours are
#' used.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A named list of ROI objects in the same format as the input `rois`, each
#' extended with a `curves` list holding the extracted mean signal series
#' (`x`, `y`, `recordType`, `detectionInterval`, `curveDescriptor`, and
#' `source_obj`).
#'
#' @examples
#' # TODO
#'
#' @export
apply_rois <- function(
  obj,
  rois,
  record.type = NA,
  x.interval = 1,
  plot = TRUE,
  xlab = NA, # "Time [s]"
  ylab = NA, # "Avg. signal [cts/ch]"
  x.unit = "image",
  legend = TRUE,
  col = NULL,
  verbose = TRUE
) {
  ## ToDo's:
  ## - (!) If input obj is a list of records, apply this function for each record.
  ## - (!) Add 'class' selection argument (one or multi-element vector)
  ## - (!) Revise plotting: Sometimes nothing is plotted. Why?
  ## - Accept RLumImage sequence object (like given back from import_lexsyg_images()) as input obj
  ## - Use meta data from input obj to define NA argument if possible, especially 'record.type'
  ## - Auto-color plot lines according to the grain class
  ## - As legend, show the classes and their colors. Put "... (N = 13)" the number of ROIs in that class to the legend text
  ## - Currently, if you apply apply_rois() on the same image stack twice, you get two identical curve entries.
  ##   Later, when the image stacks carry meta-data and an object-ID this should not happen, but the curve entry
  ##   should be overwritten automatically (maybe with a console message)

  imgs <- as.SpatRaster(obj, verbose = verbose)
  nrows <- terra::nrow(imgs)
  ncols <- terra::ncol(imgs)
  nlyrs <- terra::nlyr(imgs)

  # Set x-axis and y-axis labels in accordance to the time unit
  if (is.na(ylab)) {

    ylab_interval <- ""
    if (x.interval != 1)
      ylab_interval <- paste0(formatC(x.interval), " ")

    ylab <- paste0("Signal [avg cts / ", ylab_interval, x.unit,"]")
  }
  if (is.na(xlab)) {
    xlab <- paste0("Time [", x.unit, "]")
    if (tolower(x.unit) == "gy")
      xlab <- paste0("Dose [Gy]")
  }

  x_axis <- x.interval * c(1:nlyrs)

  # Just extend the input ROI file
  out <- rois
  y_mat <- matrix(nrow = nlyrs, ncol = 0) # For plotting

  for (roi_name in names(rois)) {

    roi <- rois[[roi_name]]

    # Define the bounds of the ROI
    row_min <- roi$row_min
    row_max <- roi$row_min + nrow(roi$mask) - 1
    col_min <- roi$col_min
    col_max <- roi$col_min + ncol(roi$mask) - 1

    # Ensure the ROI is within the image bounds
    if (row_min < 1 || row_max > nrows || col_min < 1 || col_max > ncols) {
      stop("[apply_rois()] ROI extends beyond image boundaries")
    }

    # Get the row and column indices for the ROI bounding box
    row_indices <- row_min:row_max
    col_indices <- col_min:col_max

    # Apply the mask to get only pixels within the ROI shape
    roi_pixels <- imgs[row_indices, col_indices, ][roi$mask, , drop = FALSE]

    # Calculate mean values for each layer
    roi_means <- as.numeric(colMeans(roi_pixels, na.rm = TRUE))

    curve <- list(
      x = x_axis,
      y = roi_means,
      recordType = record.type,
      detectionInterval = x.interval,
      curveDescriptor = paste0(c(xlab, ylab), collapse = ";"),
      source_obj = deparse(substitute(obj))
    )

    i <- length(out[[roi_name]]$curves) + 1
    out[[roi_name]]$curves[[i]] <- curve

    if (plot) y_mat <- cbind(y_mat, roi_means)
  }


  ### Optional plotting ###
  if (plot) {

    if (is.null(col)) col <- seq_along(out)

    matplot(x = x_axis,
            y = y_mat,
            type = "l",
            ylab = ylab, xlab = xlab,
            col = col,
            main = "Single-grain curves")

    # ToDo: Legend drawing needs overwork, thus omitted for the moment
    # if (legend) {
    #   legend("topright",
    #          legend = names(rois),
    #          cex =  0.8,
    #          col = col,
    #          lty = 1)
    # }
  }

  return(out)
}
