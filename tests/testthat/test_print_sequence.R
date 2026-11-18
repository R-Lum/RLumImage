obj <- list(`27` = list(list(position = 27, recordNumber = 8, recordType = "RF",
                             detectionInterval = 5, detectionWavelength = 880,
                             maxMeasuredT = 70,
                             imageFiles = data.frame(file = "short_1.tif",
                                                     time = 1778254172,
                                                     channel = 1,
                                                     maxMeasuredT = 70,
                                                     row.names = 1L)),
                        list(position = 27, recordNumber = 16, recordType = "OSL",
                             detectionInterval = 5, detectionWavelength = 365,
                             maxMeasuredT = 80,
                             imageFiles = data.frame(file = "short_3.tif",
                                                     time = 1778254491,
                                                     channel = 1,
                                                     maxMeasuredT = 80,
                                                     row.names = 2L))))

test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(print_sequence(sandworm.file),
               "Input object must be of type list")
  expect_error(print_sequence(list(sandworm.file)),
               "$ operator is invalid for atomic vectors", fixed = TRUE) # TODO
})

test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(print_sequence(obj))
  expect_snapshot(print_sequence(obj, print.friendly = TRUE))
  expect_snapshot(print_sequence(c(obj, obj), print.friendly = TRUE))
})
