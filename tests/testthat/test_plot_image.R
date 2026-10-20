img <- as.SpatRaster(sandworm.file, verbose = FALSE)

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("default",
                              expect_null(plot_image(sandworm.file)))
  vdiffr::expect_doppelganger("contains.outlier",
                              plot_image(img,
                                         contains.outlier = TRUE))
  })
})
