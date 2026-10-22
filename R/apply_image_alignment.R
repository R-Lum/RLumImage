#' Apply image alignment results from align_images() on a stack of images
#'
#' Shifts and rotates an image stack according to the dx, dy and angle
#' parameters estimated by align_images().
#'
#' @param obj
#' Image stack (coercible to SpatRaster) to align.
#'
#' @param alignment
#' An object of class `RLumImage.Alignment` as returned by [align_images].
#'
#' @param method
#' Resampling method forwarded to [shift_image] and [rotate_image], one of
#' `"near"` (default) or `"bilinear"`. `"near"` is faster and might better
#' preserve intensity values.
#'
#' @param force.alignment
#' If TRUE (default), apply the alignment parameters even if align_images()
#' did not report a successful convergence (with a warning).
#'
#' @param verbose
#' If TRUE (default), print progress/status messages.
#'
#' @returns
#' Aligned image stack (SpatRaster), or NULL if alignment was unsuccessful
#' and force.alignment = FALSE.
#'
#' @examples
#' # TODO
#'
#' @export
apply_image_alignment <- function(
  obj,
  alignment,
  method = c("near", "bilinear"),
  force.alignment = TRUE,
  verbose = TRUE
) {

  if (!inherits(alignment, "RLumImage.Alignment"))
    stop("[apply_image_alignment()]: 'alignment' must be an object returned by align_images().")

  if (!alignment$success){

    if (force.alignment) {
      warning("[apply_image_alignment()] Image alignment parameters were applied to input stack although the image alignment loop was quitted prematurely. Please check the results.\n")
    }else{
      if (verbose) cat("Image alignment was not successful, NULL returned.\n")
      return(NULL)
    }
  }

  img <- as.SpatRaster(obj, verbose = verbose)
  if (!method[1] %in% c("near", "bilinear"))
    stop("[apply_image_alignment()] Resampling method should be either 'near' or 'bilinear'.")

  out <- shift_image(img,
                     dx = alignment$dx,
                     dy = alignment$dy,
                     method = method,
                     verbose = verbose)

  out <- rotate_image(out,
                      angle = alignment$angle,
                      method = method,
                      verbose = verbose)

  return(out)
}
