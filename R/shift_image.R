#' Shifts an image or image stack while maintaining dimension
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param dx,dy
#' Fractional shift relative to image dimensions in direction of the x-axis or
#' the y-axis. For example dx = 0.5 shifts to the right by 50% of the image
#' width.
#'
#' @param layer
#' Indices of layer to shift. If `NA` (default), all layers are shifted.
#'
#' @param fill
#' Value used to fill the empty areas created by shifting (`NA` by default).
#'
#' @param method
#' Interpolation method for estimating the new cell values, one of `"near"`
#' (default) or `"bilinear"`.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A `terra::SpatRaster` with the same dimensions as the input, with the
#' selected layers shifted by the given fractional offsets.
#'
#' @examples
#' # shift the image 256 pixel to the right and downwards
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' shift_image(file, 0.5, -0.5)
#'
#' @export
shift_image <- function(
  obj,
  dx = 0,
  dy = 0,
  layer = NA,
  fill = NA,
  method = c("near", "bilinear"),
  verbose = TRUE
) {

  ## Changelog
  ## 2026-10-07, DM, DeepSeek v4: Cleaned up code and documentation

  img <- as.SpatRaster(obj, verbose = verbose)
  nlyrs <- terra::nlyr(img)

  if (!method[1] %in% c("near", "bilinear"))
    stop("[shift_image()] Interpolation method should be either 'near' or 'bilinear'.")
  method <- match.arg(method)

  # Convert fractional offsets to map units
  # Total extent width/height = number of pixels * pixel size
  shift_x <- dx * terra::ncol(img) * terra::xres(img)
  shift_y <- dy * terra::nrow(img) * terra::yres(img)

  # Validate layer indices
  shift_all <- isTRUE(is.na(layer))
  if (shift_all)
    layer <- seq_len(nlyrs)
  if (!is.numeric(layer) || any(is.na(layer)) || any(layer < 1) || any(layer > nlyrs))
    stop("[shift_image()] 'layer' must be a vector of valid layer indices between 1 and ", nlyrs, ".")

  # Console output
  if (verbose) {
    if (nlyrs == 1) {
      what <- "image"
    } else if (shift_all) {
      what <- paste(nlyrs, "images")
    } else {
      what <- paste(length(layer), "of", nlyrs, "images")
    }

    x_dir <- if (shift_x < 0) "left" else "right"
    y_dir <- if (shift_y < 0) "downwards" else "upwards"
    cat(sprintf("Shift %s %g pixel to the %s and %g pixel %s.\n",
                what, round(abs(shift_x), 1), x_dir, round(abs(shift_y), 1), y_dir))
  }

  if (shift_all) {
    out <- terra::shift(img, dx = shift_x, dy = shift_y)
    out <- terra::resample(out, img, method = method)
    out[is.na(out)] <- fill
    return(out)
  }

  # Work on a copy to preserve unshifted layers
  out <- img

  # Shift only the selected layers
  shifted <- terra::shift(img[[layer]], dx = shift_x, dy = shift_y)
  shifted <- terra::resample(shifted, img, method = method)
  shifted[is.na(shifted)] <- fill

  out[[layer]] <- shifted
  return(out)
}
