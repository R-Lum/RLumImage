obj <- apply_rois(c(img_1lyr, img_1lyr), rois.sandworm)[[1]]

test_that("check functionality", {
  testthat::skip_on_cran()

  obj1 <- obj
  obj1@records[[1]]@data <- obj1@records[[1]]@data[1, , drop = FALSE]
  expect_message(expect_null(plot_RLum(obj1)),
                 "Nothing to plot")

  obj1@records <- list()
  expect_message(expect_null(plot_RLum(obj1)),
                 "Nothing to plot")
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("default",
                              expect_null(plot_RLum(obj)))
  vdiffr::expect_doppelganger("x.unit s",
                              expect_null(plot_RLum(obj, x.unit = "s")))
  vdiffr::expect_doppelganger("x.unit gy",
                              expect_null(plot_RLum(obj, x.unit = "gy")))
  })
})
