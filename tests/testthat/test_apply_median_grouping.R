test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_median_grouping(sandworm.file, verbose = FALSE),
               "Number of images is smaller than window size")
  expect_error()
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_error(expect_warning( # TODO
  expect_output(apply_median_grouping(c(img_2lyr, img_1lyr), window.size = 2),
                "Number of images is not a multiple of the window size"),
  "'x' is NULL so the result will be NULL"),
  "replacement has length zero")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(apply_median_grouping(sandworm.file, window.size = 1))
})
