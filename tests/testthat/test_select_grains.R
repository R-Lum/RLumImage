test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(select_grains(img_1lyr, rois = list(iris), verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
})
