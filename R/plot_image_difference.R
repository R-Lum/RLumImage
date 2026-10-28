#' Function for creating a difference image
#'
#' @description
#' Computes and plots the pixel-wise difference between two images
#' (`objA` - `objB`) using [plot_image].
#'
#' @param objA
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack; the minuend of the difference.
#'
#' @param objB
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack; the subtrahend of the difference.
#'
#' @param range
#' Numeric vector of length 2 giving the colour scale limits. If `NA` (default),
#' a symmetric range is estimated from the difference image via [get_signal_range].
#'
#' @param cor.label
#' Whether the Pearson correlation coefficient between objA and objB should
#' be reported in the image label (`TRUE` by default).
#'
#' @param plot
#' Enable/disable plot output. Useful if only the SpatRaster object is needed.
#'
#' @param ...
#' Arguments passed to [plot_image] (with the exclusion of `wavelength`,
#' `max.layer` and `contains.outlier`).
#'
#' @return
#' Returns invisibly the difference image as SpatRaster object; the difference
#' image is plotted as a side effect.
#'
#' @export
plot_image_difference <- function(
  objA,
  objB,
  range = NA,
  cor.label = TRUE,
  plot = TRUE,
  ...
) {

  imgA <- as.SpatRaster(objA, verbose = FALSE)
  imgB <- as.SpatRaster(objB, verbose = FALSE)

  # Ensure one-layer images
  if (terra::nlyr(imgA) > 1)
    imgA <- terra::median(imgA, na.rm = TRUE)

  if (terra::nlyr(imgB) > 1)
    imgB <- terra::median(imgB, na.rm = TRUE)

  img_diff <- imgA - imgB

  if (is.na(range)) {
    # Get a reasonable upper limit for the image range ...
    diff_range <- get_signal_range(abs(img_diff),
                                contains.outlier = TRUE,
                                verbose = FALSE)

    # ... and use it also as lower limit
    range <- c(-diff_range[2], diff_range[2])
  }

  label <- list(...)$label %||% NA
  if (!nzchar(label))
    label <- NA

  if (cor.label) {
    # Calculate correlation coefficient
    v1 <- terra::values(imgA)
    v2 <- terra::values(imgB)
    cc <- stats::cor(v1, v2, method = "pearson",
                     use = "pairwise.complete.obs")

    # Formatting
    cc <- sprintf("%.4f", cc)
    label <- if (is.na(label)) cc else paste0(label, " (", cc, ")")
  }

  if (plot) {
    ## arguments to pass to plot_image()
    args <- modifyList(list(
        margin = 1.3
    ), list(...))
    args$obj <- img_diff
    args$range <- range
    args$label <- label

    ## ensure we don't pass arguments that wouldn't work as intended
    args$wavelength <- args$max.layer <- args$contains.outlier <- NULL

    do.call(plot_image, args)
  }
  names(img_diff) <- paste0("Diff_img",
                            if (is.na(label)) "" else paste0("_", label))
  invisible(img_diff)
}
