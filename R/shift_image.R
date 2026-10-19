#' Shifts an image or image stack while maintaining dimension
#'
#' @param obj Image or image stack or file path. See `as.SpatRaster` for allowed objects.
#'
#' @param dx Fractional shift relative to image dimensions in direction of the x-axis.
#' For example dx = 0.5 shifts by 50% of the image width
#'
#' @param dy Fractional shift relative to image dimensions in direction of the y-axis.
#' For example dy = 0.5 shifts by 50% of the image height
#'
#' @param layer Integer vector of layer indices to shift; NA shifts all layers
#'   (default: NA).
#'
#' @param fill Fill value for the empty areas created by zooming out (default: NA).
#'
#' @param method Interpolation method for estimating the new cell values, forwarded
#'   to `terra::resample` ('bilinear' or 'near'; default: 'bilinear').
#'
#' @param verbose Print progress messages.
#'
#' @returns
#' A `terra::SpatRaster` with the same dimensions as the input, with the
#' selected layer(s) shifted by the given fractional offsets.
#'
#' @examples
shift_image <- function(obj,
                        dx = 0,
                        dy = 0,
                        layer = NA,
                        fill = NA,
                        method = "bilinear",
                        verbose = TRUE){

  ## Changelog
  ## 2026-10-07, DM, DeepSeek v4: Cleaned up code and documentation

  img <- as.SpatRaster(obj, verbose = verbose)
  nlyrs <- terra::nlyr(img)

  # Convert fractional offsets to map units
  # Total extent width/height = number of pixels * pixel size
  shift_x <- dx * terra::ncol(img) * terra::xres(img)
  shift_y <- dy * terra::nrow(img) * terra::yres(img)

  # Console output
  if (verbose) {

    # Directions?
    x_dir <- "right"
    if (shift_x < 0)  x_dir <- "left"
    y_dir <- "upwards"
    if (shift_y < 0)  y_dir <- "downwards"

    text <- "Shift"
    if (nlyrs == 1) {
      text <- paste(text, "image")
    } else if (is.na(layer)) {
      text <- paste(text, nlyrs, "images")
    } else {
      text <- paste(text, length(layer), "of", nlyrs, "images")
    }

    text <- paste(text, round(abs(shift_x), 1), "pixel to the", x_dir, "and")
    text <- paste(text, round(abs(shift_y), 1), "pixel", y_dir)
    cat(paste0(text, ".\n"))
  }

  # Validate layer indices (NA means shift all layers)
  if (length(layer) == 1 && is.na(layer)) {

    out <- terra::shift(img, dx = shift_x, dy = shift_y)
    out <- terra::resample(out, img, method = method)
    out[is.na(out)] <- fill
    return(out)
  }

  if (!is.numeric(layer) || any(is.na(layer)) || any(layer < 1) || any(layer > nlyrs))
    stop("[shift_image()] 'layer' must be a vector of valid layer indices between 1 and ", nlyrs, ".")

  # Work on a copy to preserve unshifted layers
  out <- img

  # Shift only the selected layers
  shifted <- terra::shift(img[[layer]], dx = shift_x, dy = shift_y)
  shifted <- terra::resample(shifted, img, method = method)
  shifted[is.na(shifted)] <- fill

  out[[layer]] <- shifted
  return(out)
}
