align.ok <- structure(list(dx = 1, dy = -1, angle = 5, success = TRUE),
                      class = "RLumImage.Alignment")
align.fail <- align.ok
align.fail$success <- FALSE

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(apply_image_alignment(sandworm.file, alignment = 2),
               "'alignment' must be an object returned by align_images")
  expect_error(apply_image_alignment(sandworm.file, alignment = align.ok,
                                     method = "error", verbose = FALSE),
               "Resampling method should be either 'near' or 'bilinear'")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  SW({
  res <- apply_image_alignment(sandworm.file, align.ok)
  })
  expect_s4_class(res,
                  "SpatRaster")

  expect_warning(apply_image_alignment(sandworm.file, align.fail,
                                       force.alignment = TRUE, verbose = FALSE),
      "Image alignment parameters were applied to input stack although")
  expect_output(expect_null(apply_image_alignment(sandworm.file, align.fail,
                                                  force.alignment = FALSE)),
                "Image alignment was not successful, NULL returned")
})
