test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(shift_image(sandworm.file, method = "error", verbose = FALSE),
               'should be one of "near", "bilinear", "cubic", "cubicspline",')
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(shift_image(sandworm.file, 90, 0),
                "Shift image 46080 pixel to the right and 0 pixel upwards")
  expect_output(shift_image(sandworm.file, 0, 10),
                "Shift image 0 pixel to the right and 5120 pixel upwards")
  expect_output(shift_image(sandworm.file, -10, -10),
                "Shift image 5120 pixel to the left and 5120 pixel downwards")
  expect_output(shift_image(c(sandworm.file, sandworm.file), 1, -1),
                "Shift 2 images 512 pixel to the right and 512 pixel downwards")
})
