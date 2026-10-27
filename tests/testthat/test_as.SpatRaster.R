test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(as.SpatRaster(list()),
               "Input list does not contain path to image file")
  expect_error(as.SpatRaster(1:3),
               "Numeric vectors need a length of at least 4 to be converted")
  expect_error(as.SpatRaster("not-existing.tif"),
               "Image file does not exist")
  expect_error(as.SpatRaster(iris),
               "Image argument invalid. Must be either an array, a matrix")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(res <- as.SpatRaster(sandworm.file),
                "Load image file sandworm_rf_median.tif into system memory")
  expect_s4_class(res,
                  "SpatRaster")
  expect_identical(as.SpatRaster(img_2lyr),
                   img_2lyr)

  ## warnings
  img_warn <- test_path("_data/tiff-tests/rast_unknown_extent.tif")
  expect_warning(as.SpatRaster(img_warn, warning = TRUE, verbose = FALSE),
                 "[rast] unknown extent", fixed = TRUE)
  expect_silent(as.SpatRaster(img_warn, warning = FALSE, verbose = FALSE))

  ## more coverage
  expect_silent(as.SpatRaster(sandworm.file, warning = TRUE, noflip = FALSE,
                              verbose = FALSE))
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(as.SpatRaster(sandworm.file))
  expect_snapshot(as.SpatRaster(1:13))
  expect_snapshot(as.SpatRaster(matrix(1:4, nrow = 2)))
})
