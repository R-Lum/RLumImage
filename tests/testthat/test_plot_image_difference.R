test_that("check functionality", {
  testthat::skip_on_cran()

  ## more coverage
  expect_silent(plot_image_difference(img_2lyr, img_2lyr))
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("default",
                              plot_image_difference(img_1lyr, img_1lyr))
  })
})
