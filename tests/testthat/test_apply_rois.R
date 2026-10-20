rois <- find_grains(sandworm.file, r = 9, grain.density = 0.07,
                    verbose = FALSE, plot = FALSE)

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_rois(sandworm.file, verbose = FALSE),
               'argument "rois" is missing, with no default')
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_equal(apply_rois(sandworm.file, 90, verbose = FALSE),
               90)
  expect_silent(apply_rois(sandworm.file, rois, verbose = FALSE))
})
