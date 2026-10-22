test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(rotate_image(sandworm.file, method = "error"),
               "Resampling method should be either 'near' or 'bilinear'")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(rotate_image(sandworm.file, 90),
                "Rotate image 90° clockwise")
  expect_output(rotate_image(sandworm.file, -45,
                             method = "bilinear", round = TRUE),
                "Rotate image 45° counter-clockwise")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(rotate_image(matrix(1:9, ncol = 3), 90))
  expect_snapshot(rotate_image(array(1:27, dim = c(3, 3, 3)), -180))
})
