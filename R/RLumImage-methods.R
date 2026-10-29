## Methods for S3 generics

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
