out.file <- tempfile()
rois.applied <- apply_rois(img_1lyr, rois.sandworm, verbose = FALSE)

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(write_rf_table(list()),
               "'rois' must be a list of 'RLumImage.ROI' objects")
  expect_error(expect_output(write_rf_table(rois.sandworm, out.file),
                             "Select 0 from 38 regions of interests"),
               "No entry of the 'rois' list matches the filter arguments")
})
