test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_median_grouping(sandworm.file, verbose = FALSE),
               "Number of images is smaller than window size")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_output(apply_median_grouping(c(img_2lyr, img_1lyr), window.size = 2),
                "Number of images is not a multiple of the window size")
  expect_warning(apply_median_grouping(c(img_2lyr, img_1lyr), window.size = 2,
                                       verbose = FALSE),
                "Number of images is not a multiple of the window size")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(apply_median_grouping(sandworm.file, window.size = 1))
})
