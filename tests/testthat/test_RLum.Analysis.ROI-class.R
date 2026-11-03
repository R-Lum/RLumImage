test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(set_RLum("RLum.Analysis.ROI", roi = list(1)),
               "@roi must be a single object of class 'RLumImage.ROI'")
  expect_error(set_RLum("RLum.Analysis.ROI", roi = rois.sandworm),
               "@roi must be a single object of class 'RLumImage.ROI'")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(set_RLum("RLum.Analysis.ROI"))
  expect_snapshot(set_RLum("RLum.Analysis.ROI",
                           records = set_RLum("RLum.Analysis"),
                           roi = rois.sandworm[[1]]))
})
