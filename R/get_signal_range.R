#' Returns a meaningful image scale for plotting
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param contains.outlier
#' Whether the estimated range should account for outliers.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' The estimated signal value limits.
#'
#' @examples
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' get_signal_range(file)
#'
#' @export
get_signal_range <- function(
  obj,
  contains.outlier = FALSE,
  verbose = FALSE
) {
  img_all <- as.SpatRaster(obj)
  img <- terra::median(img_all)

  # ToDo's
  # - Revise and rename to 'get_image_range' or 'get_dynamic_range'
  # - use a better approach to guess the background than
  # - for contains.outlier = TRUE, use Pych statistics

  # Use quantiles to set contrast limits
  contrast_quantiles <- if (contains.outlier) c(0.1, 0.99) else c(0.2, 0.9999)

  # Get pixel values as numeric vector
  # Don't use all pixel values to speed up calculation
  n_pixels <- terra::ncell(img)
  n_sample <- n_pixels
  if (n_pixels > 42000)
    n_sample <- floor(36000 + n_pixels * 0.13)

  vals <- terra::spatSample(img, size = n_sample,
                            method = "random", na.rm = TRUE)[[1]]

  range <- stats::quantile(vals, probs = contrast_quantiles, na.rm = TRUE)

  # Ensure rounded return values
  range <- c(floor(range[1]), ceiling(range[2]))

  if (verbose) cat("Reasonable signal value limits for plotting are:",
                   range[1], "-", range[2], "\n")

  return(range)
}
