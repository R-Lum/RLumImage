#' 
#' Script for processing and analysing quartz CW-OSL SAR test data
#'
#' This script will be enlarged with later commits
#'

# Set file path to test data
xsyg_path <- system.file("extdata/cw_osl_test_data/2026-10-27_MiniOSL-SAR-FB2A-pos68.xsyg",
                         package = "RLumImage")

# Import lexsyg research measurement
sequence <- import_lexsyg_images(xsyg_path)

# Plot images of first CW-OSL step
plot_image(sequence[["68"]][[1]], title = paste("OSL image", 1:20), max.layer = 20)

# Plot image of camera photo shot
plot_image(sequence[["68"]][[2]], title = "Photo")
