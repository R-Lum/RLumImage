test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(shift_image(sandworm.file, method = "error", verbose = FALSE),
               "Interpolation method should be either 'near' or 'bilinear'")
  expect_error(shift_image(img_2lyr, layer = 3, verbose = FALSE),
               "'layer' must be a vector of valid layer indices between 1 and 2")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(shift_image(sandworm.file, 90, 0),
                "Shift image 46080 pixel to the right and 0 pixel upwards")
  expect_output(shift_image(sandworm.file, 0, 10),
                "Shift image 0 pixel to the right and 5120 pixel upwards")
  expect_output(shift_image(img_1lyr, -10, -10),
                "Shift image 5120 pixel to the left and 5120 pixel downwards")
  expect_output(shift_image(img_2lyr, 0.115, -1),
                "Shift 2 images 58.9 pixel to the right and 512 pixel downwards")
  expect_output(shift_image(img_2lyr, layer = 2),
                "Shift 1 of 2 images 0 pixel to the right and 0 pixel upwards")
})
