test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(rescale_image(sandworm.file, scale = -2),
               "'scale' must be a single positive numeric value")
  expect_error(rescale_image(sandworm.file, method = "error"),
               "Interpolation method must be either 'bilinear' or 'near'")
  expect_error(rescale_image(sandworm.file, center = "error"),
               "'center' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, center = 0.2),
               "'center' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, center = rep(0.2, 3)),
               "'center' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, center = c(0.2, 3)),
               "'center' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, layer = c(0.2, 3),
                             verbose = FALSE),
               "layer' must be a vector of valid layer indices between 1 and 1")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(rescale_image(sandworm.file, scale = 0.9, fill = 1),
                "Rescale 1 images to 90 %")
  expect_output(rescale_image(img_2lyr, layer = 1:2, fill = 0),
                "Rescale 2 images to 100 %")
})
