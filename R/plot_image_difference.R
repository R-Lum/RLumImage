#' Function for creating a difference image
#'
#' Computes and plots the pixel-wise difference between two images
#' (objA - objB) using plot_image().
#'
#' @param objA
#' First image (coercible to SpatRaster); minuend of the difference.
#'
#' @param objB
#' Second image (coercible to SpatRaster); subtrahend of the difference.
#'
#' @param range
#' Numeric vector of length 2 giving the color scale limits. If NA (default),
#' a symmetric range is estimated from the difference image via get_image_scale().
#'
#' @param title
#' Plot title, forwarded to plot_image().
#'
#' @param label
#' Text label drawn on the image, forwarded to plot_image().
#'
#' @param label.cor
#' Writes the Pearson correlation coefficient between objA and objB as images label.
#' Is put in parentheses if 'label' is not NA.
#'
#' @param color.scale
#' Manually set color scale, forwarded to plot_image(). If not set, grey scale is used.
#'
#' @param margin
#' Plot margin, forwarded to plot_image().
#'
#' @param plot
#' Enable/disable plot output. Useful if only the SpatRaster object is needed.
#'
#' @returns
#' Returns invisibly the difference image as SpatRaster object.
plot_image_difference <- function(objA,
                                  objB,
                                  range = NA,
                                  title = NA,
                                  label = NA,
                                  label.cor = TRUE,
                                  color.scale = NA,
                                  margin = 1.3,
                                  plot = TRUE){

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

  if (label.cor) {
    # Calculate correlation coefficient
    v1 <- terra::values(imgA)
    v2 <- terra::values(imgB)
    ok <- !is.na(v1) & !is.na(v2)
    cc <- cor(v1[ok], v2[ok], method = "pearson")

    # Formatting
    cc <- round(cc, 4)
    if (is.na(label)) {
      label <- cc
    }else{
      label <- paste0(label, " (", cc, ")")
    }
  }

  if (plot) {
    plot_image(img_diff,
               range = range,
               title = title,
               label = label,
               color.scale = color.scale,
               margin = margin)
  }
  names(img_diff) <- paste0("Diff_img", ifelse(is.na(label), "", paste0("_", label)))
  invisible(img_diff)
}
