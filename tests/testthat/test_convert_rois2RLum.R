roi <- set_roi(mask = matrix(rep(TRUE, 25), ncol = 5),
               col_min = 42, row_min = 67,
               curves = list(list(x = 1:10, y = 20:11)),
               info = list(hello = "world"))
roi.err <- list(err = set_roi(mask = matrix(rep(TRUE, 25), ncol = 5),
                              col_min = 42, row_min = 67,
                              curves = list(x = 1:10, y = 20:11)))

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(convert_rois2RLum(sandworm.file),
               "'rois' must be a non-empty named list")
  expect_error(convert_rois2RLum(set_roi(mask = matrix(rep(TRUE, 16), ncol = 4),
                                         col_min = 42, row_min = 67)),
               " operator is invalid for atomic vectors", fixed = TRUE) # TODO
  expect_error(convert_rois2RLum(roi.err),
               "Curve entry of ROI 'err' is malformed")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_snapshot(convert_rois2RLum(list(first = roi)))
  expect_snapshot(convert_rois2RLum(rois.sandworm))
})
