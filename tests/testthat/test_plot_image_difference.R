test_that("check functionality", {
  testthat::skip_on_cran()

  ## name label
  set.seed(1)
  expect_named(plot_image_difference(img_1lyr, img_1lyr, plot = FALSE),
               "Diff_img_1.0000")
  expect_named(plot_image_difference(img_1lyr, img_1lyr, label = "", plot = FALSE),
               "Diff_img_1.0000")
  expect_named(plot_image_difference(img_1lyr, img_1lyr, cor.label = FALSE,
                                     plot = FALSE),
               "Diff_img")

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
