#' Converts an array, a matrix or an image file (usually a TIFF file) to a terra::SpatRaster object
#'
#' @param obj
#' A `SpatRaster` or an object coercible to one, i.e. a file path, a matrix,
#' a 3-dimensional array, a numeric vector (of length 4 at least), or a nested
#' list as returned by [import_lexsyg_images].
#'
#' @param noflip
#' Whether no coordinate system transformation should happen (`TRUE` by
#' default).
#'
#' @param warnings
#' Whether warnings produced by [terra::rast] should be reported (`FALSE` by
#' default).
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A `SpatRaster` object.
#'
#' @examples
#' file <- system.file("extdata/sandworm_rf_median.tif", package = "RLumImage")
#' obj <- as.SpatRaster(file)
#'
#' @export
as.SpatRaster <- function(
  obj,
  noflip = TRUE,
  warnings = FALSE,
  verbose = TRUE
) {

  ## ToDo:
  ## - Accept also Luminescence::RLumImage objects
  ## - Accept also XLUM files
  ## - Accept also a list of spatRaster, arrays or tif files

  # Object is already a SpatRaster object
  if (inherits(obj, "SpatRaster")) return(obj)

  # import_lexsyg_images() returns a sequence list. Do also accept this
  if (inherits(obj, "list")) {

    if ("imageFiles" %in% names(obj)) {
      obj <- obj$imageFiles$file
    }else{
      stop("[as.SpatRaster()]: Input list does not contain path to image file.")
    }
  }

  # Object is a matrix or an array
  if (is.matrix(obj) || (is.array(obj) && length(dim(obj)) == 3)){
    if (verbose) cat("Convert array into terra::spatRaster image.\n")
    return(terra::rast(obj, crs = ""))
  }

  # Object is a numeric vector
  if (is.numeric(obj)) {

    if (length(obj) < 4)
      stop("[as.SpatRaster()]: Numeric vectors need a length of at least 4 to be converted.")

    if (verbose) cat("Convert numeric vector into single-layer square-shaped terra::spatRaster image.\n")

    # Convert to matrix
    edge_len <- floor(sqrt(length(obj)))
    arr <- array(obj, dim = c(edge_len, edge_len))

    return(terra::rast(arr, crs = ""))
  }

  # Object is a file path
  if (inherits(obj, "character")) {

    if (any(!file.exists(obj)))
      stop("[as.SpatRaster()]: Image file does not exist.")

    if (verbose) cat("Load image file", basename(obj), "into system memory.\n")

    if (!warnings)
      return(suppressWarnings(terra::rast(obj, noflip = noflip)))

    return(terra::rast(obj, noflip = noflip))
  }

  stop("[as.SpatRaster()]: Image argument invalid. Must be either an array, a matrix, a numeric vector, a terra::SpatRaster object or a file path")
}
