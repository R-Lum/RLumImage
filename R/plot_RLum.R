#' @title Plot function for an `RLum.Analysis.ROI` S4 class object
#'
#' @description
#' The function provides a standardised plot output for curve data of an
#' [RLumImage::RLum.Analysis.ROI-class] object.
#'
#' @param object
#' An [RLumImage::RLum.Analysis.ROI-class] object.
#'
#' @param main
#' Plot title.
#'
#' @param x.unit
#' X-axis unit, e.g. `"s"` or `"Gy"`, to be used in the automatic construction
#' of axis labels. Ignored if both `xlab` and `ylab` are not `NA`.
#'
#' @param xlab,ylab
#' Axis labels. If `NA` (default), they are constructed automatically.
#'
#' @param ... further arguments and graphical parameters will be passed to
#' [Luminescence::plot_RLum].
#' Supported arguments: `mtext`, `log`, `lwd`, `lty` `type`, `pch`,
#' `col`, `cex`, `norm` (see [Luminescence::plot_RLum,RLum.Data.Curve-method]),
#' `sub`, `xlim`, `ylim`; for `combine = TRUE` also: `legend`, `legend.text`,
#' `legend.pos` (typical values plus 'outside'), `legend.col`, `smooth`.
#'
#' @return
#' Returns `NULL` invisibly; the image is plotted as a side effect.
#'
#' @section Function version: 0.1.0
#'
#' @author
#' Marco Colombo, Institute of Geography, Heidelberg University (Germany)\cr
#'
#' @seealso
#' [Luminescence::plot_RLum,RLum.Analysis-method]
#'
#' @examples
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' img_1lyr <- as.SpatRaster(file, verbose = FALSE)
#' rois <- find_grains(img_1lyr, radius = 9, grain.density = 0.005,
#'                     verbose = FALSE, plot = FALSE)
#' obj <- apply_rois(c(img_1lyr, img_1lyr), rois)
#' plot_RLum(obj)
#'
#' @export
setMethod("plot_RLum", "RLum.Analysis.ROI",
function(
  object,
  main = "Single-grain curves",
  x.unit = "image",
  xlab = NA,
  ylab = NA,
  ...
) {

  if (length(object@records) == 0 || nrow(object@records[[1]]) < 2) {
    message("[plot_RLum()] Nothing to plot")
    return(invisible(NULL))
  }

  ## look at the info from the first curve, they should all be identical
  curve <- object@records[[1]]
  x.interval <- diff(curve@data[, 1])[1]

  # Set x-axis and y-axis labels in accordance to the time unit
  if (is.na(ylab)) {
    ylab <- sprintf("Signal [avg cts / %s]",
                    paste(c(if (x.interval != 1) formatC(x.interval), x.unit),
                          collapse = " "))
  }
  if (is.na(xlab)) {
    xlab <- if (tolower(x.unit) == "gy") "Dose [Gy]"
            else sprintf("Time [%s]", x.unit)
  }

  ## call the Luminescence plot_RLum.Analysis() method
  methods::callNextMethod(object, main = main, xlab = xlab, ylab = ylab,
                          combine = length(object@records) > 1, ...)
})
