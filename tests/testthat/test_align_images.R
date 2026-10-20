test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(align_images(sandworm.file, verbose = FALSE),
               'argument "moving" is missing, with no default')
  expect_error(align_images(matrix(1:8), matrix(1:4), verbose = FALSE),
               "'fixed' and 'moving' must have the same dimension")
  expect_error(align_images(sandworm.file, sandworm.file, max.shift = 0.5),
               "'optimization.roi' must be at least 3x as large as 'max.shift'")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  SW({
  expect_output(align_images(sandworm.file, sandworm.file),
                "Image alignment successful after 2 iterations")
  })
})
