#' Function for creating a difference image
#'
#' Computes and plots the pixel-wise difference between two images
#' (objA - objB) using [plot_image].
#'
#' @param objA
#' First image (coercible to SpatRaster); minuend of the difference.
#'
#' @param objB
#' Second image (coercible to SpatRaster); subtrahend of the difference.
#'
#' @param range
#' Numeric vector of length 2 giving the color scale limits. If `NA` (default),
#' a symmetric range is estimated from the difference image via [get_image_scale].
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
#' @returns
#' Returns invisibly the difference image as SpatRaster object.
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
    diff_range <- get_image_scale(abs(img_diff),
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
    ok <- !is.na(v1) & !is.na(v2)
    cc <- stats::cor(v1[ok], v2[ok], method = "pearson")

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
