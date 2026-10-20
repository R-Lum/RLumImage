roi <- set_roi(mask = matrix(rep(TRUE, 25), ncol = 5),
               col_min = 42, row_min = 67, info = list(hello = "world"))

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(set_roi(roi = NULL),
               "If no 'roi' is set, the arguments 'mask', 'col_min' and 'row_min' are mandatory")
  expect_error(set_roi(mask = 1:3, col_min = 3, row_min = 2),
               "'mask' must be a logical matrix")
  expect_error(set_roi(mask = matrix(TRUE), col_min = NA, row_min = 2),
               "'col_min' must be a non-negative integer")
  expect_error(set_roi(mask = matrix(TRUE), col_min = 2, row_min = NA),
               "'row_min' must be a non-negative integer")
  expect_error(set_roi(roi, mask = 2),
               "Changing 'mask', 'col_min', 'row_min' or 'shape' in an existing")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_error()

})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(set_roi(mask = matrix(rep(TRUE, 16), ncol = 4),
                          col_min = 42,
                          row_min = 67))
  expect_snapshot(set_roi(roi,
                          add.curve = data.frame(x = 1:10, y = (12:3)^1.5),
                          add.info = c(other = "info"),
                          class = "arbitrary"))
})
