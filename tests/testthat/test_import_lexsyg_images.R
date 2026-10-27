xsyg <- test_path("_data/2026-05-08_Combined_RF-OSL_02_short.xsyg")

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(import_lexsyg_images("not-existing.xsyg"),
               "XSYG file does not exist")
  expect_error(import_lexsyg_images(xsyg, folder = tempdir()),
               "Folder does not contain any TIFF images")
  expect_error(import_lexsyg_images(xsyg, folder = test_path("_data/tiff-tests"),
                                    verbose = FALSE),
               "No TIFF file could be matched to any XSYG record")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_warning(import_lexsyg_images(c(xsyg, xsyg), verbose = FALSE),
                 "Multiple heating records found, keeping")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  scrub_current_date <- function(output) {
    gsub("(Images were recorded between .* and) .*", "\\1", output)
  }

  expect_snapshot(import_lexsyg_images(xsyg),
                  transform = scrub_current_date)
})
