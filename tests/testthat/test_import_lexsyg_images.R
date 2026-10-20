xsyg <- test_path("_data/2026-05-08_Combined_RF-OSL_02_short.xsyg")

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(import_lexsyg_images("not-existing.xsyg"),
               "XSYG file does not exist")
  expect_error(import_lexsyg_images(xsyg, verbose = FALSE),
               "No TIFF file could be matched to any XSYG record")
})
