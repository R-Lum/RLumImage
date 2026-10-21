test_that("check functionality", {
  testthat::skip_on_cran()

  expect_error(apply_fft_filter(sandworm.file, verbose = FALSE),
               "at least one of 'shortpass'/'longpass' must be given")
  expect_error(apply_fft_filter(sandworm.file, shortpass = 0, verbose = FALSE),
               "'shortpass' must be positive")
  expect_error(apply_fft_filter(sandworm.file, longpass = 0, verbose = FALSE),
               "'longpass' must be positive")
  expect_error(apply_fft_filter(sandworm.file, shortpass = 10, longpass = 100,
                                verbose = FALSE),
               "'longpass' must be smaller than 'shortpass'")
  expect_error(apply_fft_filter(sandworm.file, shortpass = 10, transition = -1,
                                verbose = FALSE),
               "'transition' must be zero or larger")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_output(apply_fft_filter(sandworm.file, shortpass = 15, plot = FALSE),
                "Apply FFT short-pass 15 px")
  expect_output(apply_fft_filter(sandworm.file, longpass = 20, plot = FALSE),
                "Apply FFT long-pass 20 px")
  expect_output(apply_fft_filter(sandworm.file, shortpass = 40, longpass = 20,
                                 transition = NA, plot = FALSE),
                "Apply FFT band-pass 20 - 40 px")
  expect_output(apply_fft_filter(img_2lyr, shortpass = 10, plot.extended = TRUE),
                "Only last image layer is used for the extended plots")
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("shortpass",
                              apply_fft_filter(sandworm.file, shortpass = 50))
  vdiffr::expect_doppelganger("plot.extended",
                              apply_fft_filter(sandworm.file,
                                               shortpass = 20,
                                               longpass = 5,
                                               plot.extended = TRUE))
  })
})
