## Methods for S3 generics

#' @export
print.RLumImage.Alignment <- function(x, ...) {
  cat("[RLumImage.Alignment]")
  iterations <- x$optim$counts[["function"]]
  msg <- switch(as.character(x$optim$convergence),
                "0" = sprintf("successful after %d iterations", iterations),
                "1" = sprintf("failed: iteration limit (%d) reached", iterations),
                sprintf("failed with stats::optim() error code %d: %s",
                        x$optim$convergence, x$optim$message))
  cat("\n\t Image alignment", msg)
  cat("\n\t dx:", round(x$dx, 4))
  cat("\n\t dy:", round(x$dy, 4))
  cat("\n\t angle:", round(x$angle, 2), "\u00b0") # \u00b0 is °
  cat("\n")
}

#' @export
print.RLumImage.ROI <- function(x, ...) {
  cat("[RLumImage.ROI]")
  cat("\n\t shape:", x$shape)
  cat("\n\t bounding box:", sprintf("%d x %d", ncol(x$mask), nrow(x$mask)),
      "px at", sprintf("(%d, %d)", x$col_min, x$row_min))
  cat("\n\t number of curves:", length(x$curves))
  cat("\n\t mineral class:", x$class)
  cat("\n\t additional info elements:", length(x$info))
  cat("\n")
}
