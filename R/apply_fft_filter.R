#' Applies a Fast Fourier Transform (FFT) filter to one or multiple grey-scale
#' images.
#'
#' The filter operates on the spatial frequency domain and can act as a
#' short-pass (high-pass), a long-pass (low-pass), or a band-pass filter,
#' depending on which of `shortpass` / `longpass` are given. Each layer of a
#' multi-layer stack is filtered independently. Filter edges on the frequency
#' mask are smoothed with a cosine taper.
#'
#' FFT filters can be used to extract or remove features in images based on
#' their spatial size. For example, signal cross-talk can be removed by
#' applying a short-pass filter with a cut-off value sufficiently larger than
#' the grain diameters (recommended are ~2x the average diameter).
#'
#' However, FFT filters have two issues:
#' 1. They can add *ripples*, image artefacts induced by the loss of the phase
#' information in the Fourier back-transformation of the image. This effect
#' can be reduced by selecting a suitable `transition` value.
#' 2. They do not smooth out image noise like median filter or Savitzky-Golay
#' filter do. Instead, the signal-to-noise ratio of an image might be worse
#' after a FFT filter.
#'
#' A short-pass or band-pass filter removes the zero-frequency (DC) term,
#' i.e. the mean / offset of the image. The original layer mean can be added
#' back after filtering by setting `preserve.offset = TRUE`, so that absolute
#' signal levels are retained (relevant for dosimetry / RL data). A pure
#' long-pass keeps the DC term and is therefore unaffected.
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param shortpass Numeric (pixels) or `NA`.
#' Structures *shorter* than this period are kept (high-pass); structures
#' longer than it are suppressed. If `NA`, no high-frequency / short-structure
#' limit is applied and only the `longpass` cut-off matters.
#'
#' @param longpass Numeric (pixels) or `NA`.
#' Structures *longer* than this period are kept (low-pass); structures shorter
#' than it are suppressed. If `NA`, no low-frequency / long-structure limit is
#' applied and only the `shortpass` cut-off matters.
#' Providing both `shortpass` and `longpass` builds a band-pass that keeps
#' periods between `longpass` and `shortpass`; this requires `shortpass > longpass`.
#'
#' @param transition Numeric (fractional) or `NA`.
#' Relative width of the cosine-tapered transition between the stop and pass
#' bands at each cut-off frequency. Thus, this smooths the filter edges and
#' reduces the appearance of *ripples*. A hard cut-off is applied if set to
#' `NA` or 0.
#'
#' @param preserve.offset
#' Whether the original layer mean should be added back after filtering (`TRUE`
#' by default). See details.
#'
#' @param plot
#' Whether to plot the filtered images with [plot_image] (`TRUE` by default).
#'
#' @param plot.extended
#' Whether to plot additional diagnostic images: the FFT magnitude spectrum of
#' the last layer, the frequency mask, and the unfiltered - filtered difference
#' (`FALSE` by default). It is ignored if `plot = FALSE`.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A `terra::SpatRaster` with the same dimensions, number of layers and
#'  extent as the input.
#'
#' @examples
#' # Band-pass keeping structures between 3 and 50 px in an image stack
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' f <- apply_fft_filter(file, shortpass = 50, longpass = 3, plot = FALSE)
#'
#' @export
apply_fft_filter <- function(
  obj,
  shortpass = NA,
  longpass = NA,
  transition = 1,
  preserve.offset = TRUE,
  plot = TRUE,
  plot.extended = FALSE,
  verbose = TRUE
) {

  ## Changelog
  ## 2026-09-01, DM & DeepSeek v4-flash: Initial implementation.
  ##
  ## ToDo:
  ## - Refer example image to specific test image in a package subfolder
  ## - The 'preserve.offset' issue is solved differently in ImageJ. There the middle of
  ##   the frequency mask is '1' -> thus the f = 0 value is kept. However, this somehow does
  ##   not work here, see outcommented line 192
  ## - In case this method establishes as default method for cross-talk removal, the performance need
  ##   to be improved. This can be done by migrating the algorithms in stats::fft() and  fftshift2d()
  ##   into a function for terra::tapp()

  # Coerce input to a SpatRaster
  img <- as.SpatRaster(obj, verbose = verbose)

  # Validate filter cut-offs
  if (is.na(shortpass) && is.na(longpass))
    stop("[apply_fft_filter()]: at least one of 'shortpass'/'longpass' must be given.")

  if (!is.na(shortpass) && !is.na(longpass) && shortpass < longpass)
    stop("[apply_fft_filter()]: 'longpass' must be smaller than 'shortpass'.")

  if (!is.na(shortpass) && shortpass <= 0)
    stop("[apply_fft_filter()]: 'shortpass' must be positive (in pixels).")

  if (!is.na(longpass) && longpass <= 0)
    stop("[apply_fft_filter()]: 'longpass' must be positive (in pixels).")

  if (is.na(transition)) transition <- 0
  if (transition < 0)
    stop("[apply_fft_filter()]: 'transition' must be zero or larger.")

  # Message text for plots and console texts
  if (is.na(shortpass) && !is.na(longpass)) {
    msg_text <- paste("FFT long-pass", longpass, "px")
  } else if (!is.na(shortpass) && is.na(longpass)) {
    msg_text <- paste("FFT short-pass", shortpass, "px")
  } else {
    msg_text <- paste("FFT band-pass", longpass, "-", shortpass, "px")
  }

  if (verbose) cat("Apply", msg_text, "\n")

  nrows <- terra::nrow(img)
  ncols <- terra::ncol(img)
  nlyrs <- terra::nlyr(img)

  # -------------------- Helper functions --------------------

  # Cosine taper on a frequency grid.
  # Returns 0 outside the transition band, 1 inside the (full) pass band,
  # with smooth cosine ramps over the leading/trailing edge.
  # 'rev = TRUE' gives a band-stop style taper (1 -> 0 across the band).
  taper_cosine <- function(freq, structure_length, transition, rev = FALSE) {

    # Convert length (px) into frequency (1/px)
    filter <- 1 / structure_length

    # for smooth mask edges
    f_start <- filter - filter * transition
    f_end <- filter + filter * transition

    t <- numeric(length(freq))
    mid  <- (f_start + f_end) / 2
    # 0 outside, sweeping the cosine through the band
    t[freq <= f_start] <- 0
    t[freq >= f_end]   <- 1
    inside <- freq > f_start & freq < f_end
    t[inside] <- 0.5 * (1 + sin(pi * (freq[inside] - mid) / (f_end - f_start)))
    if (rev) t <- 1 - t
    t
  }

  # 2D fftshift for a matrix: swaps the first and second half along both
  # dimensions so the DC (zero-frequency) term moves from the corner to the
  # centre. Applying it twice returns the original (symmetric case), so it is
  # used for both the forward and the inverse direction.
  fftshift2d <- function(x) {
    nr <- nrow(x)
    nc <- ncol(x)
    # shift rows
    x <- rbind(x[(floor(nr / 2) + 1L):nr, , drop = FALSE],
               x[seq_len(floor(nr / 2)), , drop = FALSE])
    # shift columns
    x <- cbind(x[, (floor(nc / 2) + 1L):nc, drop = FALSE],
               x[, seq_len(floor(nc / 2)), drop = FALSE])
    x
  }

  # ------------------------------------------------------------

  # Build the radial frequency grid (cycles per pixel

  # The Fourier spectrum from stats::fft() has the DC term at the corner
  # (index 1,1). We fft-shift the spectrum so the DC term sits at the centre,
  # matching the frequency grid below (fx, fy in -0.5..0.5 cycles/px), where
  # the spatial frequency index k maps to (k - 1 - floor(N/2)) / N cycles/px.
  fx <- (seq_len(ncols) - 1L - floor(ncols / 2)) / ncols
  fy <- (seq_len(nrows) - 1L - floor(nrows / 2)) / nrows
  freq2d <- sqrt(outer(fy^2, fx^2, "+"))         # radial frequency grid

  # Default the short-pass and long-pass to 1
  sp_mask <- lp_mask <- 1

  # Build short-pass mask
  if (!is.na(shortpass))
    sp_mask <- taper_cosine(freq2d, shortpass, transition)

  # Build long-pass mask
  if (!is.na(longpass))
    lp_mask <- taper_cosine(freq2d, longpass, transition, rev = TRUE)

  # Combine both masks for creating a band-pass
  mask <- sp_mask * lp_mask

  # mask[floor(length(mask) / 2) + 1] <- 1

  # Copy stack
  out <- img

  # Process each layer separately
  for (i in seq_len(nlyrs)) {

    # Convert spatRaster to a matrix
    mat <- terra::as.matrix(img[[i]], wide = TRUE)

    # Replace NA values with the layer median (FFT needs complete data)
    if (anyNA(mat))
      mat[is.na(mat)] <- stats::median(mat, na.rm = TRUE)

    layer_mean <- 0
    # If a short-pass filter is used, the zero-frequency data point in the inverse matrix
    # is also filtered out. This data-point represents the offset of the image.
    # Thus, we have to reconstruct it manually
    if (preserve.offset && !is.na(shortpass)) layer_mean <- mean(mat)

    # Fast Fourier transformation of the image
    inverse <- stats::fft(mat)

    # move DC term to the centre (matches the mask)
    inverse <- fftshift2d(inverse)

    # Apply the frequency mask
    inverse <- inverse * mask

    # shift back before the inverse transform
    inverse <- fftshift2d(inverse)

    # Back-transformation, restore the absolute signal level
    mat <- Re(stats::fft(inverse, inverse = TRUE)) / (nrows * ncols) + layer_mean

    out[[i]] <- terra::rast(mat)
  }

  if (plot) {
    plot_image(out, label = msg_text)

    if (plot.extended) {

      if (nlyrs > 1) {
        if (verbose) cat("Only last image layer is used for the extended plots.\n")
      }

      # FFT spectra are complex; plot their magnitude (a real value)
      inverse <- fftshift2d(stats::fft(mat))
      plot_image(Mod(inverse), label = msg_text, title = "Inverse image")

      # Mask is stored as a flat vector -> reshape to the image grid first
      plot_image(matrix(mask, nrow = nrows, ncol = ncols),
                 label = msg_text, range = c(0,1), title = "Frequency mask")

      inverse_filtered <- inverse * mask
      plot_image(Mod(inverse_filtered), label = msg_text, title = "Filtered inverse image")

      # Difference
      plot_image_difference(img[[1]], out[[1]],
                            label = msg_text,
                            title = "Difference unfiltered - filtered")
    }
  }

  return(out)
}
