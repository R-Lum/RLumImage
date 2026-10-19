#' Return and plot single columns and rows (lines) of an image stack
#'
#' @param obj
#' @param coordinate
#' @param range
#' @param plot
#' @param show.X.line
#' @param show.Y.line
#' @param legend
#' @param colors
#'
#' @returns
#' @export
#'
#' @examples
get_sections <- function(obj,
                         coordinate = NA, # XY
                         range = NA,
                         plot = TRUE,
                         show.X.line = TRUE,
                         show.Y.line = TRUE,
                         legend = FALSE,
                         colors = c("red", "black")
                         ){

  img <- as.SpatRaster(obj)
  n_records <- terra::nlyr(img)
  n_rows <- terra::nrow(img)
  n_cols <- terra::ncol(img)

  if (any(is.na(range))) range <- NULL

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

  cols <- colorRampPalette(colors)(n_records)

  # X section
  if (show.X.line) {
    matplot(x = 1:nrow(secs$X),
            y = secs$X,
            col = cols,
            ylim = range,
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
    matplot(x = 1:nrow(secs$Y),
            y = secs$Y,
            col = cols,
            ylim = range,
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
