#' Creates a grouped median image stack from an input stack
#'
#' @param obj
#' @param window.size
#' @param verbose
#'
#' @returns
#' @export
#'
#' @examples
running_median <- function(obj,
                           window.size = 5,
                           verbose = TRUE){

  ## ToDo's:
  ## - "running_median" is a misleading function name, rename it to "median_grouping" or
  ##   something similar in RLumImage
  ## - If the input (and output) objects contain any meta data on the detection interval,
  ##   don't forget to update the that meta data on the output object

  stack <- as.SpatRaster(obj, verbose = verbose)

  n_layers    <- terra::nlyr(stack)
  n_output    <- floor(n_layers / window.size)
  if (verbose) cat("Input images:", n_layers, "\n")

  if (n_layers < window.size)
    stop("[running_median()] Number of images is smaller than window size.")

  if (n_layers %% window.size != 0) {
    msg <- "Number of images is not a multiple of the window size. Any excess images are disregarded."
    ifelse(verbose, cat(msg, "\n"), warning(msg))
  }

  # Define the grouping index, for example:
  # window = 5  →  groups 1–8  (rep(1:8, each = 5))
  #  → group_index = c(1,1,1,1,1, 2,2,2,2,2, ..., 8,8,8,8,8)
  group_index <- rep(seq_len(n_output), each = window.size)


  # Compute the median for each group with tapp()
  # tapp() applies a function to *subsets* of layers
  # defined by the index vector – exactly what we need.
  result <- terra::tapp(
    x     = stack,
    index = group_index,
    fun   = median,
    na.rm = TRUE
  )

  # Give the output bands meaningful names
  layer_starts <- seq(1, window.size * n_output, by = window.size)
  layer_ends   <- layer_starts + window.size - 1
  names(result) <- paste0("median_", sprintf("%02d", layer_starts),
                          "_", sprintf("%02d", layer_ends))

  if (verbose) cat("Output images:", nlyr(result), "\n")

  return(result)
}
