test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(running_median(sandworm.file, verbose = FALSE),
               "Number of images is smaller than window size")
  expect_error()
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_error(expect_warning( # TODO
  expect_output(running_median(c(img_2lyr, img_1lyr), window.size = 2),
                "Number of images is not a multiple of the window size"),
  "'x' is NULL so the result will be NULL"),
  "replacement has length zero")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(running_median(sandworm.file, window.size = 1))
})
