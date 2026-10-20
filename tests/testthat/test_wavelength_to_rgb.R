test_that("check functionality", {
  testthat::skip_on_cran()

  expect_equal(wavelength_to_rgb(NA),
               "#E6E6E6")
  expect_equal(wavelength_to_rgb("error"),
               "#E6E6E6")
  expect_equal(wavelength_to_rgb(360),
               "#FF27FF")
  expect_equal(wavelength_to_rgb(420),
               "#5500FF")
  expect_equal(wavelength_to_rgb(480),
               "#00CCFF")
  expect_equal(wavelength_to_rgb(500),
               "#00FF80")
  expect_equal(wavelength_to_rgb(540),
               "#6DFF00")
  expect_equal(wavelength_to_rgb(600),
               "#FFB100")
  expect_equal(wavelength_to_rgb(700),
               "#FF2A34")
  expect_equal(wavelength_to_rgb(800),
               "#F66680")
})
