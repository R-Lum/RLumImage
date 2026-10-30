rois.applied <- apply_rois(img_1lyr, rois.sandworm,
                          plot = FALSE, verbose = FALSE)
fail1 <- list(structure(list(row_min = 0), class = "RLumImage.ROI"))
fail2 <- list(structure(list(col_min = 0), class = "RLumImage.ROI"))
fail3 <- list(structure(list(row_min = 1000, mask = matrix(TRUE)), class = "RLumImage.ROI"))
fail4 <- list(structure(list(col_min = 1000, mask = matrix(TRUE)), class = "RLumImage.ROI"))

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_rois(list(), verbose = FALSE),
               "'obj' must be an object coercible to a 'SpatRaster' or a list of them")
  expect_error(apply_rois(iris, verbose = FALSE),
               "'obj' must be an object coercible to a 'SpatRaster' or a list of them")
  expect_error(apply_rois(sandworm.file, verbose = FALSE),
               'argument "rois" is missing, with no default')
  expect_error(apply_rois(sandworm.file, rois = 90, verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
  expect_error(apply_rois(sandworm.file, rois = list(), verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
  expect_error(apply_rois(sandworm.file, rois = list(iris), verbose = FALSE),
               "'rois' must be a list of 'RLumImage.ROI' objects")
  expect_error(apply_rois(list(img_1lyr, terra::aggregate(img_1lyr, 2)),
                          rois.sandworm, plot = FALSE, verbose = FALSE),
               "All images must have the same dimensions")
  expect_error(apply_rois(img_1lyr, rois = fail1, verbose = FALSE),
               "ROI extends beyond image boundaries")
  expect_error(apply_rois(img_1lyr, rois = fail2, verbose = FALSE),
               "ROI extends beyond image boundaries")
  expect_error(apply_rois(img_1lyr, rois = fail3, verbose = FALSE),
               "ROI extends beyond image boundaries")
  expect_error(apply_rois(img_1lyr, rois = fail4, verbose = FALSE),
               "ROI extends beyond image boundaries")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  expect_length(rois.sandworm[[1]]$curves,
                0)
  expect_length(rois.applied[[1]]$curves,
                1)

  ## add curve to an existing one
  res <- apply_rois(img_1lyr, rois.applied, plot = FALSE, verbose = FALSE)
  expect_length(res[[1]]$curves,
                2)
  res2 <- apply_rois(list(img_1lyr, img_1lyr), rois.sandworm,
                     plot = FALSE, verbose = FALSE)
  expect_length(res2[[1]]$curves,
                2)
  expect_length(res2,
                length(res))

  ## images may have different numbers of layers
  res3 <- apply_rois(list(img_2lyr, img_1lyr), rois.sandworm[1],
                     plot = FALSE, verbose = FALSE)
  expect_equal(vapply(res3[[1]]$curves, function(x) length(x$x), numeric(1)),
               c(2, 1))
  expect_equal(vapply(res3[[1]]$curves, function(x) length(x$y), numeric(1)),
               c(2, 1))
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  SW({
  expect_snapshot_value(apply_rois(img_2lyr, rois.applied,
                                   plot = FALSE),
                        style = "json2")
  expect_snapshot_value(apply_rois(list(img_1lyr, img_2lyr), rois.applied,
                                   plot = FALSE),
                        style = "json2")
  })
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  SW({
  vdiffr::expect_doppelganger("applied",
                              apply_rois(img_2lyr, rois.applied))
  vdiffr::expect_doppelganger("interval unit",
                              apply_rois(img_2lyr, rois.sandworm,
                                         x.interval = 2, x.unit = "gy"))
  })
})
