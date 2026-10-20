#' Rescales (zoom) an image or image stack while maintaining its dimensions
#'
#' Scales the image content by `scale` relative to `center` and warps it back
#' onto the original grid so the output keeps the same extent and resolution.
#'
#' @param obj Image or image stack or file path. See `as.SpatRaster` for allowed objects.
#'
#' @param scale Zoom factor (> 1 zooms in, < 1 zooms out; default: 1).
#'
#' @param center
#' Scaling centre as a fraction of the extent (x, y), each in \[0, 1\]
#'   (default: c(0.5, 0.5)).
#'
#' @param layer Integer vector of layer indices to rescale; NA rescales all layers
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
#' # TODO
#'
#' @export
rescale_image <- function(obj,
                          scale = 1,
                          center = c(0.5, 0.5),
                          layer = NA,
                          fill = NA,
                          method = "bilinear",
                          verbose = TRUE) {

  ## Changelog
  ## 2026-02-02, DM: First fully functional version, created with the help of ChatGPT 5
  ## 2026-06-07, DM: Simplify to using only spatRaster objects
  ## 2026-10-07, DeepSeek v4: Implemented the 'layer' argument (NA = all layers, like shift_image)
  ##
  ## ToDos
  ## - do result rounding (or not?)

  if (!is.numeric(scale) || length(scale) != 1 || scale <= 0)
    stop("[rescale_image()] 'scale' must be a single positive numeric value.")

  if (!(method %in% c("bilinear", "near")))
    stop("[rescale_image()] Interpolation method must be either 'bilinear' or 'near'.")

  if (!is.numeric(center) || length(center) != 2 || any(center < 0) || any(center > 1))
    stop("[rescale_image()] 'center' must be a numeric vector of length 2 with values between 0 and 1.")

  # Check whether input is a SpatRaster
  img <- as.SpatRaster(obj, verbose = verbose)

  nlays <- terra::nlyr(img)

  # Validate layer indices (NA means rescale all layers)
  if (!(length(layer) == 1 && is.na(layer)) &&
      (!is.numeric(layer) || any(is.na(layer)) || any(layer < 1) || any(layer > nlays)))
    stop("[rescale_image()] 'layer' must be a vector of valid layer indices between 1 and ", nlays, ".")

  if (verbose) cat("Rescale", nlays,"images to", scale * 100,"% ... ")

  ref_ext <- terra::ext(img)
  cx <- (ref_ext[1] + ref_ext[2]) * center[1]
  cy <- (ref_ext[3] + ref_ext[4]) * center[2]


  # Scaled source extent (relative to center)
  src_ext <- terra::ext(
    cx + (ref_ext[1] - cx) * scale,
    cx + (ref_ext[2] - cx) * scale,
    cy + (ref_ext[3] - cy) * scale,
    cy + (ref_ext[4] - cy) * scale
  )

  # Create a virtual scaled source raster
  src <- img
  terra::ext(src) <- src_ext

  if (length(layer) == 1 && is.na(layer)) {

    # Rescale all layers at once
    out <- terra::resample(src, img, method = method)

    # Apply fill value if requested
    if (!is.na(fill))
      out[is.na(out)] <- fill

    names(out) <- names(img)

  } else {

    # Work on a copy to preserve the unselected layers
    out <- img

    # Rescale only the selected layers
    src_sub <- src[[layer]]
    rescaled <- terra::resample(src_sub, img, method = method)

    # Apply fill value if requested
    if (!is.na(fill))
      rescaled[is.na(rescaled)] <- fill

    names(rescaled) <- names(img)[layer]
    out[[layer]] <- rescaled
  }

  if (verbose) cat("DONE\n")
  return(out)

}
