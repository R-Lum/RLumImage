SW <- function(expr) {
  capture.output(suppressMessages(suppressWarnings(expr)))
}

expect_snapshot_xlum <- function(xlum, ...) {
  expect_snapshot(cat(as.character(xlum)), ...)
}

## frequently used inputs
sandworm.file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
img_1lyr <- as.SpatRaster(sandworm.file, verbose = FALSE)
img_2lyr <- as.SpatRaster(c(img_1lyr, img_1lyr * 2), verbose = FALSE)
rois.sandworm <- find_grains(img_1lyr, radius = 9, grain.density = 0.0055,
                             verbose = FALSE, plot = FALSE)
