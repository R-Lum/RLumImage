#' Rotate an image or a stack of images
#'
#' @param obj
#' Input object. Must either be a 2D matrix, a 3D array or a terra::spatRaster object.
#'
#' @param angle
#' Clockwise rotation angle in degree.
#'
#' @param center
#' Center of rotation in relative values.
#'
#' @param method
#' Resampling method, one of `"near"` (default) or `"bilinear"`. Nearest
#' neighbour is faster and preserves signal values and sharp edges in the image;
#' bilinear interpolation allows for precise rotation without adding distortions
#' to image structures.
#'
#' @param round
#' Input values are usually counts and thus integers. If TRUE, the bilinear interpolated
#' values are rounded back to integers to prevent compatibility issues.
#'
#' @param fill
#' Fill value of the empty areas created by the rotation.
#'
#' @param verbose
#' Print progress messages.
#'
#' @returns
#' SpatRaster if input was SpatRaster,
#' matrix if input was matrix, array if input was array
#'
#' @examples
#' # TODO
#'
#' @export
rotate_image <- function(
  obj,
  angle,
  center = c(0.5, 0.5),
  method = c("near", "bilinear"),
  round = FALSE,
  fill = NA,
  verbose = TRUE
) {

  ## ------ Changelog ------
  ## 2026-01-30, DM: First fully functional version, created with the help of ChatGPT 5
  ## 2026-10-07, DM: Checked algorithm for validity, enhanced documentation
  ##
  ## ------ Internal documenation ------
  ## The elephant in the room: terra::rotate() does not work as it some very different thing.
  ## And terra::spin() is for spatVector only.
  ##
  ## ToDos
  ## - Improve performance!
  ## - Center arguments input check
  ## - Improve documentation
  ##
  ##  Performance analysis results by Claude Sonnet 5 at 2026-07-30 using
  ##  50 iterations of rotating a single-layer 512x512 image:
  ##
  ##  | Component | Self time | % of total |
  ##  | --- | --- | --- |
  ##  | Core rotation/interpolation math (inside rotate_image itself) | 1.47s | 57% |
  ##  | as.array(obj) — SpatRaster → array conversion | 0.66s | 25.5% |
  ##  | expand.grid() — output pixel grid | 0.31s | 12% |
  ##  | rast() — array → SpatRaster reconstruction | 0.06s | 2.3% |

  if (!method[1] %in% c("near", "bilinear"))
    stop("[rotate_image()] Resampling method should be either 'near' or 'bilinear'.")
  method <- match.arg(method)
  is_raster <- FALSE

  if (is.matrix(obj)) {

    # Promote 2D matrix to 3D array with one layer
    arr <- array(obj, dim = c(nrow(obj), ncol(obj), 1))

  } else if (is.array(obj) && length(dim(obj)) == 3) {

    # Already a stacked image array
    arr <- obj

  } else {

    img <- as.SpatRaster(obj, verbose = verbose)
    is_raster <- TRUE

    # Convert input to array [row, col, layer]
    arr <- terra::as.array(img)
  }

  # Extract dimensions
  nrows <- dim(arr)[1]
  ncols <- dim(arr)[2]
  nlays <- dim(arr)[3]

  # Console output
  if (verbose) {
   rot_dir <- "clockwise"
   if (angle < 0) rot_dir <- "counter-clockwise"
   text <- "Rotate image"
   if (nlays > 1) text <- paste("Rotate", nlays, "images")

   cat(text, paste0(round(abs(angle), 2), "\u00b0 ", rot_dir,"."), "\n") # \u00b0 is °
  }

  # Rotation center in pixel coordinates
  center_col <- ncols * center[1] + 0.5
  center_row <- nrows * (1 - center[2]) + 0.5


  # Convert degrees to radians
  theta <- angle * pi / 180
  ct <- cos(theta)
  st <- sin(theta)

  # Output grid (vectorised)
  grid <- expand.grid(
    row = seq_len(nrows),
    col = seq_len(ncols)
  )

  # Pixel offset relative to rotation center
  dx <- grid$col - center_col
  dy <- grid$row - center_row

  # Inverse rotation (output → input)
  src_x <-  ct * dx + st * dy + center_col
  src_y <- -st * dx + ct * dy + center_row

  # Skip pixels outside the input image
  inside <- src_x >= 1 & src_x <= ncols &
    src_y >= 1 & src_y <= nrows

  # Initialize output with fill value
  out <- array(fill, dim = c(nrows * ncols, nlays))

  if (method == "near") {

    ii <- round(src_y[inside])
    jj <- round(src_x[inside])

    idx <- (jj - 1) * nrows + ii

    for (k in seq_len(nlays)) {
      out[inside, k] <- arr[, , k][idx]
    }

  } else {

    # Neighbouring pixel indices
    x1 <- floor(src_x)
    x2 <- ceiling(src_x)
    y1 <- floor(src_y)
    y2 <- ceiling(src_y)

    # Skip if any neighbour is outside image
    valid <- inside &
      x1 >= 1 & x2 <= ncols &
      y1 >= 1 & y2 <= nrows

    # Fractional distances
    wx <- src_x - x1
    wy <- src_y - y1

    idx11 <- (x1 - 1) * nrows + y1
    idx21 <- (x2 - 1) * nrows + y1
    idx12 <- (x1 - 1) * nrows + y2
    idx22 <- (x2 - 1) * nrows + y2

    # Bilinear weights
    w11 <- (1 - wx) * (1 - wy)
    w21 <-  wx      * (1 - wy)
    w12 <- (1 - wx) *  wy
    w22 <-  wx      *  wy

    # Interpolate each layer identically
    for (k in seq_len(nlays)) {
      layer <- arr[, , k]
      out[valid, k] <-
        w11[valid] * layer[idx11[valid]] +
        w21[valid] * layer[idx21[valid]] +
        w12[valid] * layer[idx12[valid]] +
        w22[valid] * layer[idx22[valid]]
    }

    if (round) out <- round(out)
  }

  out <- array(out, dim = c(nrows, ncols, nlays))

  if (is_raster) {

    # For arrays, terra::rast() correctly interprets
    # [row, col, layer] as a multilayer SpatRaster
    r <- terra::rast(out, crs = terra::crs(img))

    # Take over extension and layer names from original image
    terra::ext(r) <- terra::ext(img)
    names(r) <- names(img)
    return(r)
  }

  # Drop singleton layer for matrix output
  if (is.matrix(obj)) return(out[, , 1])

  # Otherwise return full 3D array
  out
}
