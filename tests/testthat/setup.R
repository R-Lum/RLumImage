SW <- function(expr) {
  capture.output(suppressMessages(suppressWarnings(expr)))
}

## the ... can be used to set the tolerance
expect_snapshot_RLum <- function(object, ..., expect_snapshot_output = FALSE) {
  set.seed(list(...)$seed %||% 1)
  if (expect_snapshot_output)
    expect_snapshot_output(ignore <- object)
  if (inherits(object, "list")) {
    for (idx in seq_along(object))
      expect_snapshot_RLum(object[[idx]], ...)
    return()
  }
  object@.uid <- NA_character_
  object@.pid <- NA_character_
  if ("records" %in% slotNames(object)) {
    for (idx in seq_along(object@records)) {
      object@records[[idx]]@.uid <- NA_character_
      object@records[[idx]]@.pid <- NA_character_
    }
  }
  expect_snapshot_value(object, style = "json2", ...)
}

## frequently used inputs
sandworm.file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
img_1lyr <- as.SpatRaster(sandworm.file, verbose = FALSE)
img_2lyr <- as.SpatRaster(c(img_1lyr, img_1lyr * 2), verbose = FALSE)
rois.sandworm <- find_grains(img_1lyr, radius = 9, grain.density = 0.0055,
                             verbose = FALSE, plot = FALSE)
