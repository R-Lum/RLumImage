test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(rotate_image(sandworm.file, method = "error"),
               "Resampling method must be either 'bilinear' or 'near'")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(rotate_image(sandworm.file, 90),
                "Rotate image 90° clockwise")
  expect_output(rotate_image(sandworm.file, -45, method = "bilinear"),
                "Rotate image 45° counter-clockwise")
})
