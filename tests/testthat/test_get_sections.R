test_that("snapshot tests", {
  testthat::skip_on_cran()

  expect_snapshot(get_sections(sandworm.file, plot = FALSE))
})

test_that("graphical snapshot tests", {
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("vdiffr")

  set.seed(1)
  SW({
  vdiffr::expect_doppelganger("default",
                              get_sections(sandworm.file))
  vdiffr::expect_doppelganger("legend",
                              get_sections(sandworm.file,
                                           legend = TRUE))
  })
})
