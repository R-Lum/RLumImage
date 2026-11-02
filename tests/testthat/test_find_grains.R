test_that("check functionality", {
  testthat::skip_on_cran()

  expect_error(find_grains(sandworm.file),
               "Either 'threshold' or 'grain.density' must be defined")
  expect_warning(find_grains(sandworm.file, threshold = 10, grain.density = 0.1,
                             verbose = FALSE),
                 "Both 'threshold' and 'grain.density' are defined. Only 'threshold' will be used")
  expect_error(find_grains(sandworm.file, grain.density = 0, verbose = FALSE),
               "'grain.density' must be larger than 0 and must not exceed 1")
  expect_error(find_grains(sandworm.file, grain.density = 1.1, verbose = FALSE),
               "'grain.density' must be larger than 0 and must not exceed 1")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_warning(find_grains(img_1lyr, threshold = 1000,
                             allow.overlap = TRUE, verbose = FALSE),
                 "Threshold is too large for this image")
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(find_grains(sandworm.file, threshold = 200, plot = FALSE))
  expect_snapshot(find_grains(sandworm.file, grain.density = 0.005, plot = FALSE))
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("threshold",
                              find_grains(sandworm.file, threshold = 500))
  vdiffr::expect_doppelganger("grain.density",
                              find_grains(sandworm.file, grain.density = 0.01))
  vdiffr::expect_doppelganger("plot.extended",
                              find_grains(sandworm.file, threshold = 250,
                                          plot.extended = TRUE))
  vdiffr::expect_doppelganger("layers",
                              find_grains(img_2lyr, threshold = 850))
  })
})

test_that("regression tests", {
  testthat::skip_on_cran()

  ## issue 18
  res <- find_grains(img_1lyr, threshold = 100, plot = FALSE, verbose = FALSE)
  expect_equal(res[[1]]$info$source_function,
               "find_grains")
})
