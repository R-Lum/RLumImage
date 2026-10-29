test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_rois(sandworm.file, verbose = FALSE),
               'argument "rois" is missing, with no default')
  expect_error(apply_rois(sandworm.file, rois = 90, verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
  expect_error(apply_rois(sandworm.file, rois = list(iris), verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_silent(apply_rois(sandworm.file, rois.sandworm, verbose = FALSE))
  expect_silent(apply_rois(sandworm.file, rois.sandworm, verbose = FALSE,
                           x.interval = 2, x.unit = "gy"))
})
