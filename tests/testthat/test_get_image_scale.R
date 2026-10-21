test_that("snapshot tests", {
  testthat::skip_on_cran()

  set.seed(1)
  expect_snapshot(get_image_scale(img_1lyr))
  expect_snapshot(get_image_scale(img_2lyr, contains.outlier = TRUE,
                                  verbose = TRUE))
})
