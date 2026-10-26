#' Return and plot single columns and rows (lines) of an image stack
#'
#' @param obj
#' An object coercible to a `SpatRaster` (see [as.SpatRaster]) containing the
#' image stack.
#'
#' @param coordinate
#' Numeric vector of length 2 giving the column and row index (1-based) of the
#' pixel at which the sections are taken. If `NA` (default), the centre of the
#' image is used.
#'
#' @param plot
#' Whether plots should be generated (`TRUE` by default).
#'
#' @param ylim
#' Optional y-axis limits.
#'
#' @param show.X.line
#' Whether to plot the section along the X-direction (a fixed row) (`TRUE` by
#' default).
#'
#' @param show.Y.line
#' Whether to plot the section along the Y-direction (a fixed column) (`TRUE` by
#' default).
#'
#' @param legend
#' Whether a legend should be added to the plot (`FALSE` by default).
#'
#' @param col
#' Vector of colours used to build a colour ramp for the individual records
#' (`c("red", "black")` by default).
#'
#' @return
#' TODO
#'
#' @examples
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' get_sections(file)
#'
#' @export
get_sections <- function(
  obj,
  coordinate = NA,
  plot = TRUE,
  ylim = NULL,
  show.X.line = TRUE,
  show.Y.line = TRUE,
  legend = FALSE,
  col = c("red", "black")
) {

  img <- as.SpatRaster(obj)
  n_records <- terra::nlyr(img)
  n_rows <- terra::nrow(img)
  n_cols <- terra::ncol(img)

  # If coordinate is not set, take the middle of the image
  if (is.na(coordinate)[1]){
    coordinate <- c(ceiling(n_cols / 2), ceiling(n_rows / 2))
  } else {
    # ToDo: Is the coordinate within image dimension? Stop if not.
  }

  # Output object
  secs <- list(X = img[coordinate[2], , ],
               Y = img[ ,coordinate[1], ],
               coordinate = coordinate)

  if(!plot) return(secs)

  cols <- colorRampPalette(col)(n_records)

  # X section
  if (show.X.line) {
    matplot(x = seq_len(nrow(secs$X)),
            y = secs$X,
            col = cols,
            ylim = ylim,
            type = "l", lty = 1,
            xlab = "Pixel no. in X-direction",
            ylab = "Signal")

    if (legend) {
      legend(legend = names(secs$X),
             "topright", col = cols,
             lty = 1, lwd = 1, bty = "n")
    }
  }

  # Y section
  if (show.Y.line) {
    matplot(x = seq_len(nrow(secs$Y)),
            y = secs$Y,
            col = cols,
            ylim = ylim,
            type = "l", lty = 1,
            xlab = "Pixel no. in Y-direction",
            ylab = "Signal")

    if (legend) {
      legend(legend =names(secs$Y),
             "topright", col = cols,
             lty = 1, lwd = 1, bty = "n")
    }
  }

  invisible(secs)
}
