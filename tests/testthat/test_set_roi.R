roi <- set_roi(mask = matrix(rep(TRUE, 25), ncol = 5),
               col_min = 42, row_min = 67,
               info = list(hello = "world"),
               overlay = list(dx = 5, dy = 5),
               curves = list(curve1 = data.frame(x = 1:2, y = c(11.3, 13.2))))

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

  expect_equal(set_roi(roi),
               roi)

  ## info
  expect_warning(new <- set_roi(roi, info = list(added = "added")),
                 "Old 'info' contains entries which are not in new 'info'")
  expect_equal(new$info$added,
               "added")
  expect_null(new$info$hello)

  ## overlay
  expect_warning(expect_warning(
      new <- set_roi(roi, overlay = list(added = "added")),
      "Old 'overlay' contains entries which are not in new 'overlay'"),
      "Changing the overlay might lead to erroneous plots")
  expect_equal(new$overlay$added,
               "added")
  expect_null(new$overlay$dx)

  ## curves
  expect_warning(new <- set_roi(roi, curves = list(added = "added")),
                 "Old 'curves' contains entries which are not in new 'curves'")
  expect_equal(new$curves$added,
               "added")
  expect_null(new$curves$curve)
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(set_roi(mask = matrix(rep(TRUE, 16), ncol = 4),
                          col_min = 42,
                          row_min = 67))
  expect_snapshot(set_roi(roi,
                          add.curve = data.frame(x = 1:10, y = (12:3)^1.5),
                          add.info = c(other = "info"),
                          source.image = sandworm.file,
                          class = "arbitrary"))
})
