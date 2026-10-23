rois <- list(ROI_1 = list(shape = "circle",
                          class = "Unclassified",
                          overlay = list(x = 391, y = 201, r = 6)),
             ROI_2 = list(shape = "rectangle",
                          class = "Intentional error",
                          row_min = 274, col_min = 212,
                          overlay = list(dx = 8, dy = 10)))

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_warning(plot_image(img_1lyr,
                            rois = list(ROI_1 = list(shape = "circle"))),
                 "ROI overlay data missing")
  expect_warning(plot_image(img_2lyr,
                            rois = list(ROI_1 = list(shape = "circle"))),
                 "'rois' overlay is only supported for single-layer images")
  expect_warning(plot_image(img_1lyr,
                            rois = list(ROI_1 = list(shape = "rectangle"))),
                 "Rectangle ROI dimensions missing")
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("default",
                              expect_null(plot_image(sandworm.file)))
  vdiffr::expect_doppelganger("contains.outlier",
                              plot_image(img_2lyr,
                                         contains.outlier = TRUE))
  vdiffr::expect_doppelganger("rois",
                              plot_image(img_1lyr, rois = rois,
                                         roi.ids = TRUE))
  expect_warning(
  vdiffr::expect_doppelganger("issue 9",
                              plot_image(img_1lyr, rois = rois,
                                         classes = list(Unclassified = "red"))),
  "Some mineral classes ('Intentional error') are missing from",
  fixed = TRUE)
  })
})
