test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(running_median(sandworm.file),
               "Number of images is smaller than window size")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(running_median(sandworm.file, window.size = 1))
})
