#' Automatically align two single-layer SpatRaster images
#'
#' Estimates the horizontal shift, vertical shift and rotation angle that
#' best aligns 'moving' onto 'fixed', using image correlation as the
#' similarity metric and optim() for the parameter search.
#'
#' @param fixed
#' Reference SpatRaster (single layer)
#'
#' @param moving
#' SpatRaster to be aligned to 'fixed' (single layer)
#'
#' @param method
#' Optimization method, forwarded to optim() (e.g. "L-BFGS-B", "Nelder-Mead")
#'
#' @param max.rotation
#' Maximum absolute rotation (in degrees) allowed during the search. Used as
#' the lower/upper bound for the rotation parameter.
#'
#' @param max.shift
#' Maximum allowed shift, expressed as a fraction of image width/height.
#' Used to calculate the lower/upper bounds for dx and dy.
#'
#' @param optimization.roi
#' Fractional size of the region-of-interest (ROI) used during optimization.
#' Default 0.8 means a centered crop of 80% of the original image width/height
#' is used in the similarity function. Values < 1 reduce computation time and
#' robustness to edge artifacts; 1.0 uses the full image.
#'
#' @param plot
#' If TRUE (default), plot two difference images: 'fixed' minus 'moving'
#' (before alignment), and 'fixed' minus 'aligned' (after alignment, where
#' 'aligned' is 'moving' with the estimated shift/rotation applied).
#'
#' @param verbose
#' Print progress messages.
#'
#' @returns
#' An object of class `RLumImage.Alignment`, containing the result of [optim]
#' and the estimated parameters (dx, dy, angle).
#'
#' @examples
#' # TODO
#'
#' @export
align_images <- function(fixed,
                         moving,
                         method = "L-BFGS-B", # "Nelder-Mead" ...
                         max.rotation = 45, # degree
                         max.shift = 0.2, # fractional
                         optimization.roi = 0.8, # fractional
                         plot = TRUE,
                         verbose = TRUE) {

  ## ToDo:
  ## - Add R² and total-residual² values to output object
  ## - Add cor_before and cor_after to output object
  ## - Optional plotting of R² to the "After" plot
  ## - Switch to algorithm which does not need constrains, but test if robustness is equal

  if ((optimization.roi / 2.999) < max.shift)
    stop("[align_images()]: 'optimization.roi' must be at least 3x as large as 'max.shift'.")

  img_fix <- as.SpatRaster(fixed, verbose = verbose)
  img_mov <- as.SpatRaster(moving, verbose = verbose)

  if (!identical(dim(img_fix)[1:2], dim(img_mov)[1:2]))
    stop("[align_images()]: 'fixed' and 'moving' must have the same dimensions.")

  # Ensure one-layer images
  if (terra::nlyr(img_fix) > 1) {
    if (verbose) cat("Image 'fixed' has multiple layers: Create one representative median image.\n")
    img_fix <- terra::median(img_fix, na.rm = TRUE)
  }
  if (terra::nlyr(img_mov) > 1) {
    if (verbose) cat("Image 'moving' has multiple layers: Create one representative median image.\n")
    img_mov <- terra::median(img_mov, na.rm = TRUE)
  }

  ncols <- terra::ncol(img_fix)
  nrows <- terra::nrow(img_fix)
  xresolution <- terra::xres(img_fix)
  yresolution <- terra::yres(img_fix)

  # Precompute conversion factors: fractional shift -> map units
  # Used to convert opt$par back to fractional for shift_image() after optimisation
  conversion_dx <- ncols * xresolution
  conversion_dy <- nrows * yresolution

  # Define ROI (region of interest) for optimization if specified
  roi_fix <- img_fix
  roi_mov <- img_mov

  if (optimization.roi < 1) {

    # Calculate centered crop dimensions
    crop_width <- round(ncols * optimization.roi)
    crop_height <- round(nrows * optimization.roi)

    # Center the crop
    col_start <- (ncols - crop_width) / 2
    row_start <- (nrows - crop_height) / 2

    # Create reduced SpatExtent
    x_min_crop <- terra::xmin(img_fix) + col_start * xresolution
    x_max_crop <- x_min_crop + crop_width * xresolution
    y_max_crop <- terra::ymax(img_fix) - row_start * yresolution
    y_min_crop <- y_max_crop - crop_height * yresolution
    roi_ext <- terra::ext(x_min_crop, x_max_crop, y_min_crop, y_max_crop)

    # Crop both images
    roi_fix <- terra::crop(img_fix, roi_ext)
    roi_mov <- terra::crop(img_mov, roi_ext)
  }

  # similarity function: correlation between overlapping cells
  sim_fun <- function(par) {
    dx <- par[1]; dy <- par[2]; ang <- par[3]

    # dx/dy are in map units — pass directly to terra::shift()
    test <- terra::shift(roi_mov, dx, dy)

    # "bilinear" is mandatory although it slows down the iterations by ~20%
    # but it prevents premature converging by "near"-induced plateaus
    test <- rotate_image(test, ang, method = "bilinear", verbose = FALSE)

    # resample onto fixed's grid so cells line up
    test <- terra::resample(test, roi_fix, method = "bilinear")

    v1 <- terra::values(roi_fix)
    v2 <- terra::values(test)
    ok <- !is.na(v1) & !is.na(v2)
    if (sum(ok) < 10) return(1)  # penalize no-overlap

    -stats::cor(v1[ok], v2[ok], method = "pearson")  # negative because optim() minimizes
  }

  # Bounds for shift in map units, keeping all three parameters on a similar scale
  dx.bound <- ceiling(ncols * max.shift)
  dy.bound <- ceiling(nrows * max.shift)

  ### Optimization call ###
  opt <- stats::optim(par = c(0, 0, 0),
               fn = sim_fun,
               method = method,
               lower = c(-dx.bound, -dy.bound, -max.rotation),
               upper = c( dx.bound,  dy.bound,  max.rotation))

  # Create output structure
  result <- list()
  result$success <- opt$convergence == 0
  result$dx <- opt$par[1] / conversion_dx
  result$dy <- opt$par[2] / conversion_dy
  result$angle <- opt$par[3]
  result$optim <- opt

  # Console output
  if (verbose) {
    iterations <- opt$counts[["function"]]
    msg <- switch(as.character(opt$convergence),
                  "0" = paste("Image alignment successful after",
                              iterations, "iterations"),
                  "1" = paste("Image alignment failed: Iteration maximum of",
                              iterations, "reached"),
                  paste("Image alignment failed with stats::optim() error code",
                        paste0(opt$convergence, ":"), opt$message))

    cat(msg, ".\n", sep = "")
    cat(" dx =", round(result$dx, 4), "\n")
    cat(" dy =", round(result$dy, 4), "\n")
    cat(" angle =", paste0(round(result$angle, 2), "\u00b0\n")) # \u00b0 is °
  }

  # Create difference images
  result$before <- img_fix - img_mov

  aligned <- shift_image(img_mov, dx = result$dx, dy = result$dy, verbose = FALSE)
  aligned <- rotate_image(aligned, result$angle, verbose = FALSE)
  #aligned <- terra::resample(aligned, img_fix, method = "bilinear")
  result$after <- img_fix - aligned

  if (plot) {
    diff_range <- get_image_scale(
      abs(result$before),
      contains.outlier = TRUE)

    plot_image(c(result$before, result$after),
               range = c(-diff_range[2], diff_range[2]),
               title = c("Before", "After"))
  }

  ## return
  structure(result,
            class = "RLumImage.Alignment")
}
