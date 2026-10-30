#' Apply ROIs to an image stack
#'
#' @description
#' Extract mean values within circular regions of interest (ROIs) across
#' an image stack and optionally plot the time series.
#'
#' If `obj` is a list of images, each image is processed separately and one
#' curve per image is appended to the `curves` list of every ROI, in the order
#' of the images.
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) or a list of
#' them. All images in the list must have the same dimensions.
#'
#' @param rois
#' A named list of `RLumImage.ROI` objects as returned by [find_grains] and
#' [select_grains].
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
#' A named list of `RLumImage.ROI` objects, each extended with a `curves`
#' list (of length equal to the number of images in `obj`) holding the
#' extracted mean signal series (`x`, `y`, `recordType`, `detectionInterval`,
#' `curveDescriptor`, and `source_obj`).
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
  ## - (!) Add 'class' selection argument (one or multi-element vector)
  ## - (!) Revise plotting: Sometimes nothing is plotted. Why?
  ## - Accept RLumImage sequence object (like given back from import_lexsyg_images()) as input obj
  ## - Use meta data from input obj to define NA argument if possible, especially 'record.type'
  ## - Auto-color plot lines according to the grain class
  ## - As legend, show the classes and their colors. Put "... (N = 13)" the number of ROIs in that class to the legend text
  ## - Currently, if you apply apply_rois() on the same image stack twice, you get two identical curve entries.
  ##   Later, when the image stacks carry meta-data and an object-ID this should not happen, but the curve entry
  ##   should be overwritten automatically (maybe with a console message)
  if (!(.is.coercible(obj) || inherits(obj, "list") && length(obj) > 0 &&
        all(vapply(obj, .is.coercible, logical(1))))) {
    stop("[apply_rois()] 'obj' must be an object coercible to a 'SpatRaster' or a list of them")
  }

  objname <- deparse(substitute(obj))
  if (!inherits(obj, "list"))
    obj <- list(obj)

  valid.rois <- vapply(rois, inherits, "RLumImage.ROI", FUN.VALUE = logical(1))
  if (length(rois) == 0 || !all(valid.rois))
    stop("[apply_rois()] 'rois' must be a list of 'RLumImage.ROI' objects")

  ## Assume all images have the same dimensions
  imgs <- as.SpatRaster(obj[[1]], verbose = verbose)
  nrows <- terra::nrow(imgs)
  ncols <- terra::ncol(imgs)

  # Set x-axis and y-axis labels in accordance to the time unit
  if (is.na(ylab)) {
    ylab <- sprintf("Signal [avg cts / %s]",
                    paste(c(if (x.interval != 1) formatC(x.interval), x.unit),
                          collapse = " "))
  }
  if (is.na(xlab)) {
    xlab <- if (tolower(x.unit) == "gy") "Dose [Gy]"
            else sprintf("Time [%s]", x.unit)
  }

  # Precompute the ROI bounding boxes
  roi_indices <- lapply(rois, function(roi) {

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
    list(row = row_min:row_max, col = col_min:col_max)
  })

  # Just extend the input ROI file
  out <- rois
  y_by_roi <- if (plot) vector("list", length(rois)) else NULL

  # Loop over all images
  for (img_idx in seq_along(obj)) {

    if (img_idx > 1)
      imgs <- as.SpatRaster(obj[[img_idx]], verbose = verbose)

    if (terra::nrow(imgs) != nrows || terra::ncol(imgs) != ncols)
      stop("[apply_rois()] All images must have the same dimensions.")

    for (idx in seq_along(rois)) {

      # Apply the mask to get only pixels within the ROI shape
      row_indices <- roi_indices[[idx]]$row
      col_indices <- roi_indices[[idx]]$col
      roi_pixels <- imgs[row_indices, col_indices, ][rois[[idx]]$mask, , drop = FALSE]

      # Calculate mean values for each layer
      roi_means <- as.numeric(colMeans(roi_pixels, na.rm = TRUE))

      curve <- list(
          x = x.interval * seq_along(roi_means),
          y = roi_means,
          recordType = record.type,
          detectionInterval = x.interval,
          curveDescriptor = paste0(c(xlab, ylab), collapse = ";"),
          source_obj = objname
      )

      # Append curve to existing ones
      i <- length(out[[idx]]$curves) + 1
      out[[idx]]$curves[[i]] <- curve

      if (plot) y_by_roi[[idx]] <- c(y_by_roi[[idx]], list(roi_means))
    }
  }

  ### Optional plotting ###
  if (plot) {

    ys <- unlist(y_by_roi, recursive = FALSE)
    max_nlyrs <- max(vapply(ys, length, numeric(1)))
    x_axis <- x.interval * seq_len(max_nlyrs)
    y_mat <- do.call(cbind, lapply(ys, function(y) {
      c(y, rep(NA_real_, max_nlyrs - length(y)))
    }))

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
