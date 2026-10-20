test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(get_sequence(sandworm.file),
               "Input object must be of type list")
  expect_error(get_sequence(list(sandworm.file)),
               "$ operator is invalid for atomic vectors", fixed = TRUE) # TODO
})
