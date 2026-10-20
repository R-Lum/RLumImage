test_that("input validation", {
  testthat::skip_on_cran()

  expect_error(get_time_difference("error"),
               "File not found or modification time unavailable")
  expect_error(get_time_difference(sandworm.file),
               "Could not find coordinates for the city")
})

test_that("check functionality", {
  testthat::skip_on_cran()

  SW({
  expect_equal(get_time_difference(sandworm.file, "Heidelberg", "Germany"),
               0)
  })
})
