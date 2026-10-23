test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(rescale_image(sandworm.file, scale = -2),
               "'scale' must be a single positive numeric value")
  expect_error(rescale_image(sandworm.file, method = "error"),
               "Interpolation method must be either 'bilinear' or 'near'")
  expect_error(rescale_image(sandworm.file, centre = "error"),
               "'centre' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, centre = 0.2),
               "'centre' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, centre = rep(0.2, 3)),
               "'centre' must be a numeric vector of length 2 with values between 0 and 1")
  expect_error(rescale_image(sandworm.file, centre = c(0.2, 3)),
               "'centre' must be a numeric vector of length 2 with values between 0 and 1")
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
  expect_output(rescale_image(c(img_2lyr, img_2lyr), layer = 2:3, fill = 0),
                "Rescale 4 images to 100 %")
})
