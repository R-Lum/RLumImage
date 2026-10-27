#' Automatically detects single grains (local signal maxima) in an image.
#'
#' @description
#' The function iteratively finds the pixel of maximum signal in an FFT
#' filtered copy of the image, defines a circular region of interest (ROI)
#' around it, and removes it before searching for the next maximum. Grains are
#' only kept if their mean signal within the ROI exceeds the estimated local
#' background by the given `threshold`. This avoids detecting FFT filter
#' ripples as grains.
#'
#' The detection threshold can either be given directly (`threshold`) or be
#' derived from a target `grain.density` (the fraction of pixels expected to be
#' part of grains). The returned ROIs are sorted by their mean `average` signal
#' in descending order.
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack. If it contains multiple layers, a representative median image
#' is created first.
#'
#' @param radius
#' Radius in pixels of the circular ROI placed around each detected signal
#' maximum.
#'
#' @param threshold Numeric (cts/px) or `NA`.
#' Minimum mean signal within a ROI, relative to the estimated local background,
#' for it to count as a grain. Either `threshold` or `grain.density` must be
#' given.
#'
#' @param grain.density
#' Fraction of pixels expected to belong to grains. If `NA`, the threshold is
#' derived from this density as the corresponding quantile of the FFT filtered
#' image. Either `threshold` or `grain.density` must be given.
#'
#' @param fft.filter
#' Numeric vector of length 3 (shortpass, longpass, transition), with shortpass
#' and longpass given as multiples of `radius`. It is passed to [apply_fft_filter]
#' to build the search image.
#'
#' @param allow.overlap
#' Whether the detected ROIs can overlap. If `FALSE` (default), the ROI is
#' removed from the search image after detection and set to `NA`, preventing
#' overlapping grains. Setting `TRUE` is not recommended.
#'
#' @param default.class
#' Mineral class assigned to all detected ROIs (`"Unclassified"` by default).
#'
#' @param plot
#' Whether to plot the filtered images with [plot_image] (`TRUE` by default).
#'
#' @param plot.extended
#' Whether to plot additional diagnostic images: the FFT filtered image, the
#' ROI residual image, and combinations thereof (`FALSE` by default). It is
#' ignored if `plot = FALSE`.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A named list of ROIs in the same format as [apply_rois] and [select_grains],
#' sorted by mean average signal in descending order. Returns an empty list if
#' no grains are found.
#'
#' @examples
#' \dontrun{ # TODO
#' # Detect grains in a single image, threshold given directly
#' grains <- find_grains(image, r = 6, threshold = 15)
#'
#' # Estimate the threshold from a target grain density
#' grains <- find_grains(image, r = 6, grain.density = 0.001)
#' }
#'
#' @export
find_grains <- function(
  obj,
  radius = 6,
  threshold = NA,
  grain.density = NA,
  fft.filter = c(4, 1, 1),
  allow.overlap = FALSE, # Not recommended
  default.class = "Unclassified",
  plot = TRUE,
  plot.extended = FALSE, # Plots also FFT-filtered images
  verbose = TRUE
) {

  ## ------ Changelog ------
  ## 2026-09-07, DM: Original version

  ## ToDos:
  ## - Somehow, the performance was better when a specific ROI mask was created for
  ##   each maximum inside the loop (I have no idea why, that's counter-intuitive)
  ## - Check if function crashes in case of empty ROIs
  ## - Mitigate the ROI list creation into an external function
  ## - Perform a cosmic-ray removal before the first processing step
  ## - Consider post-identification refinement of the exact ROI position. With other words:
  ##   'wobble' the ROI to maximize coverage of a grain. See line 186
  ## - Refine the 'grain.density'. approach
  ## - Find an algorithm which gives sufficient results when both 'grain.density' and
  ##   'threshold' are NA
  ## - Add some progress bar or counter which does not spam into rendered documents (see line 232)

  # Remember the name of the input object for the ROI info slot
  source_obj <- deparse(substitute(obj))

  if (is.na(threshold) && is.na(grain.density))
    stop("[find_grains()] Either 'threshold' or 'grain.density' must be defined.")

  if (!is.na(threshold) && !is.na(grain.density))
    warning("[find_grains()] Both 'threshold' and 'grain.density' are defined. Only 'threshold' will be used.")

  if (!is.na(grain.density)){

    if (grain.density <= 0 || grain.density > 1)
      stop("[find_grains()] 'grain.density' must be larger than 0 and must not exceed 1.")

    # We reduce the grain density value because otherwise we would get too many ROIs.
    # We simply assume, arbitrarily, that only about 1/4 of a grain exceeds the threshold.
    grain_density <- grain.density * 0.25
  }

  img <- as.SpatRaster(obj, verbose = verbose)

  # Ensure one-layer images
  if (terra::nlyr(img) > 1) {
    if (verbose) cat("Image has multiple layers: Create one representative median image.\n")
    img <- terra::median(img, na.rm = TRUE)
  }

  fill_value <- NA
  if (allow.overlap) fill_value <- 0

  nrows <- terra::nrow(img)
  ncols <- terra::ncol(img)

  # Convert image to a matrix (needed later)
  values <- terra::as.matrix(img, wide = TRUE)

  # Set 20 % quantile of pixel intensity as estimated background (also needed later)
  est_background <- quantile(values, probs = 0.2, na.rm = TRUE)

  # -------------- Build pixel mask ---------------
  # How does a ROI look like? Here, it is a circle
  # Build a matrix which later is used a mask for all operations

  m <- floor(radius + 1) # Middle point
  d <- m + floor(radius) # Edge length

  # Calculate the distances of each cell to the middle point (later, the maximum)
  grid_rows <- rep(1:d, each = d)
  grid_cols <- rep(1:d, times = d)
  distances_sq <- (grid_rows - m)^2 + (grid_cols - m)^2

  # Now create a 2-D TRUE/FALSE matrix
  circular_roi_mask <- matrix(distances_sq <= radius^2, ncol = d)

  if (verbose) cat("Created circular ROI mask with edge length",
                   d, "containing", sum(circular_roi_mask), "pixels.\n")

  # -------------- Prepare search image --------------

  # FFT filter
  shortpass <- fft.filter[1] * radius
  longpass <- fft.filter[2] * radius
  transition <- fft.filter[3]
  img_peaks <- apply_fft_filter(
    img,
    shortpass = shortpass,
    longpass = longpass,
    transition = transition,
    preserve.offset = FALSE,
    plot = FALSE,
    verbose = verbose)

  # Convert to a matrix
  peaks <- terra::as.matrix(img_peaks, wide = TRUE)

  # Estimate threshold from dynamic range of FFT filtered image
  if (is.na(threshold)) {

    # The grain density set by the user determines the threshold value
    threshold <- quantile(peaks, probs = 1 - grain_density, na.rm = TRUE)

    if(verbose) cat("Calculate threshold for ", 100 * grain.density,
                    "% grain density:",  formatC(threshold), " px/cts.\n")
  }else{

    if (threshold < quantile(peaks, probs = 0.25, na.rm = TRUE))
      warning("[find_grains()] Threshold is very low for this image. Grain finding might take longer and return more ROIs than expected.")

    if (threshold > max(peaks, na.rm = TRUE))
      warning("[find_grains()] Threshold is too large for this image. No ROI will be returned.")

    if(verbose) cat("Use an intensity threshold of",  threshold, "px/cts.\n")
  }

  # -------------- ROI search --------------
  xymax <- data.frame(NULL) # contains 'x', 'y' and 'max'
  N <- 0 # number of iterations

  peak_max <- max(peaks, na.rm = TRUE) # First maximum
  while (peak_max >= threshold) {

    roi_is_valid <- TRUE
    px_values <- NULL

    # Where is the maximum?
    # coord[1] = row; coord[2] = col
    coords <- which(peaks == peak_max, arr.ind = TRUE)[1,]


    # Define the bounds of the circular region
    row_min <- coords[1] - radius
    row_max <- coords[1] + radius
    col_min <- coords[2] - radius
    col_max <- coords[2] + radius

    if (row_min < 1
        || row_max > nrows
        || col_min < 1
        || col_max > ncols) {
      roi_is_valid <- FALSE
    } else {

      ### ToDo: Add wobbling here by using something like: optim(peaks_avg)

      row_indices <- row_min:row_max
      col_indices <- col_min:col_max

      # Apply the circular mask to get only pixels within the circle
      px_values <- values[row_indices, col_indices][circular_roi_mask]

      # Check for any NA values in the circular regions of both, the input image
      # and the FFT image. Be aware, for the FFT filter it was necessary to fill NA's there
      if (any(is.na(px_values))
          || any(is.na(peaks[row_indices, col_indices][circular_roi_mask]))) {
        roi_is_valid <- FALSE
      }
    }

    if (roi_is_valid) {

      # Calculate mean value from pixels within the circular ROI
      avg_values <- mean(px_values, na.rm = TRUE)

      # Ensure that the threshold criteria is also met in the real image
      # to avoid the detection of FFT ripples as grains
      if (avg_values - est_background >= threshold){

        xymax <- rbind(xymax,
                       data.frame(x = coords[2],
                                  y = coords[1],
                                  col_min = col_min,
                                  row_min = row_min,
                                  average = avg_values,
                                  fft_max = peak_max))
        # if (verbose) cat("\r", nrow(xymax))
      }

      # Now take the roi out of the image using the circular mask
      peaks[row_indices, col_indices][circular_roi_mask] <- fill_value

    }else{

      # Attenuate this maximum to ensure it is not selected again
      peaks[coords[1], coords[2]] <- min(floor(peak_max / 2), threshold)
    }

    N <- N + 1
    peak_max <- max(peaks, na.rm = TRUE)
  }

  if (verbose) cat(nrow(xymax), "grains found in", N, "iterations.\n")

  # Sort by average in descending order (largest first)
  if (nrow(xymax) > 0)
    xymax <- xymax[order(-xymax$average), ]

  # Build the return list
  result <- vector("list", nrow(xymax))
  for (i in seq_len(nrow(xymax))) {

    result[[i]] <- set_roi(
      mask    = circular_roi_mask,
      col_min = xymax$col_min[i],
      row_min = xymax$row_min[i],
      shape   = "circle",
      class   = default.class,
      overlay = list(x = terra::xFromCol(img, xymax$x[i]),
                     y = terra::yFromRow(img, xymax$y[i]),
                     r = radius),
      info    = list(source_function = "find_grains",
                     source_obj = source_obj,
                     source_ncols = ncols,
                     source_nrows = nrows,
                     average = xymax$average[i],
                     fft_max = xymax$fft_max[i])
    )
  }

  # Naming is not important and it might be better to remove it in final R package
  if (length(result) > 0)
    names(result) <- paste0("ROI_", seq_len(nrow(xymax)))

  # Plotting
  if (plot) {

    msg_text <- paste0("radius = ", radius, ", threshold = ", formatC(threshold))
    if (plot.extended) {

      fft_label <- paste0("Band-pass ", longpass, " - ", shortpass,
                          " px (transition = ", transition, ")")

      plot_image(img, label = "original",
                 title = "Input image")

      plot_image(img_peaks, label = fft_label,
                 title = "FFT filtered image")

      plot_image(img_peaks, rois = result, label = fft_label,
                 title = "FFT filtered image")

      plot_image(peaks, label = msg_text,
                 title = "FFT ROI residual image")

      plot_image(peaks, rois = result, label = msg_text,
                 title = "FFT ROI residual image")
    }

    plot_image(img, rois = result, roi.ids = FALSE,
               label = msg_text)
  }

  return(result)
}
