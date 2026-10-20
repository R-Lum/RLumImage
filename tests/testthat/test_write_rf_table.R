test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(write_rf_table(list()),
               "'rois' is empty")
})
