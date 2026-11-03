#' Apply ROIs to an image stack
#'
#' @description
#' Extract mean values within regions of interest (ROIs) across an image stack.
#' The extracted curves are returned as [Luminescence::RLum.Data.Curve-class]
#' records stored in an [RLumImage::RLum.Analysis.ROI-class] object together
#' with the ROI definitions they were extracted from.
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
#' @param xlab
#' X-axis label. If `NA` (default), it is constructed automatically.
#'
#' @param ylab
#' Y-axis label. If `NA` (default), it is constructed automatically.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A named list of [RLumImage::RLum.Analysis.ROI-class] objects, one for each
#' element in `rois`. The extracted mean signal series are stored as
#' [Luminescence::RLum.Data.Curve-class] objects in the `@records` slot (one
#' for each image in `obj` in the order provided). The corresponding ROI
#' definition is stored in the `@roi` slot, while the ROI's mineral class
#' is stored in `info$class`.
#'
#' @seealso
#' [RLumImage::RLum.Analysis.ROI-class], [Luminescence::RLum.Data.Curve-class]
#'
#' @examples
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' img_1lyr <- as.SpatRaster(file, verbose = FALSE)
#' rois <- find_grains(img_1lyr, radius = 6, grain.density = 0.005,
#'                     verbose = FALSE, plot = FALSE)
#' apply_rois(img_1lyr, rois)
#'
#' @export
apply_rois <- function(
  obj,
  rois,
  record.type = NA,
  x.interval = 1,
  x.unit = "image",
  xlab = NA, # "Time [s]"
  ylab = NA, # "Avg. signal [cts/ch]"
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

  ## Allocate a list to store the curves generated for each ROI
  roi.curves <- vector(mode = "list", length = length(rois))

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

      # recordType slot has to be a single character
      if (length(record.type) != 1 || is.na(record.type))
        record.type <- NA_character_

      ## curve generated by applying the current ROI to the current image
      roi.curves[[idx]][[img_idx]] <- Luminescence::set_RLum(
        class = "RLum.Data.Curve",
        recordType = record.type,
        curveType = "measured",
        data = cbind(x = x.interval * seq_along(roi_means),
                     y = roi_means),
        info = list(detectionInterval = x.interval,
                    curveDescriptor = paste0(c(xlab, ylab), collapse = ";"),
                    source_obj = objname)
        )
    }
  }

  # Collect the curves generated from each ROI in an RLum.Analysis.ROI object
  out <- lapply(seq_along(rois), function(idx) {
    roi <- rois[[idx]]
    Luminescence::set_RLum(
                      class = "RLum.Analysis.ROI",
                      records = roi.curves[[idx]],
                      originator = "apply_rois", # set manually because of lapply()
                      info = list(class = roi$class),
                      roi = roi
                  )
  })
  names(out) <- names(rois)

  return(out)
}
