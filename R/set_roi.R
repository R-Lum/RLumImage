#' Create or edit a region-of-interest (ROI) object
#'
#' Creates a new ROI object or edits an existing one. ROIs define regions within an
#' image, typically used for extracting luminescence signal time series. This function
#' supports setting the ROI shape, position, and metadata like mineral class.
#'
#' @param roi A ROI object (list) to edit. If `NULL` (default), a new ROI is created.
#'
#' @param mask A logical matrix defining the shape of the ROI. `TRUE` values indicate
#'   pixels within the ROI, `FALSE` values indicate pixels outside.
#'
#' @param col_min Numeric (pixels). The column index (1-based) of the upper-left corner
#'   of the ROI bounding box in the image.
#'
#' @param row_min Numeric (pixels). The row index (1-based) of the upper-left corner
#'   of the ROI bounding box in the image.
#'
#' @param shape Character. The geometric shape of the ROI (e.g., "circle", "rectangle").
#'   Used for proper visualization of the ROI overlay.
#'
#' @param class Character. Mineral classification for the ROI (default: "unclassified").
#'
#' @param info A named list of optional attributes and parameters associated with the ROI.
#'
#' @param overlay A named list of plotting parameters for visualizing the ROI overlay.
#' The necessary arguments in the overlay list depend on the `shape` of the ROI.
#'
#' @param curves A named list of luminescence curves extracted from image stacks.
#'
#' @param add.curve A luminescence curve to add to the ROI's `curves` list.
#'
#' @param add.info A named list of attributes to add to the ROI's `info` list.
#'
#' @param warnings Logical. If `TRUE` (default), print warnings about potential data loss
#'   when overwriting existing parameters.
#'
#' @return A list representing a single ROI object, compatible with [apply_rois()] and
#'   [select_grains()].
#'

set_roi <- function(roi = NULL, # Existing ROI object
                    mask = NULL, # TRUE/FALSE mask defining the ROI
                    col_min = NULL, # Upper left corner of the ROI in the image
                    row_min = NULL, # Upper left corner of the ROI in the image
                    shape = NULL, # ROI shape: "circle", "rectangle", ... Is important for the overlay
                    class = NULL, # Mineral classification result
                    info = list(), # List optional attributes and parameter
                    overlay = list(), # Overlay parameters for plotting the ROI
                    curves = list(), # Luminescence curves from image stacks
                    add.curve = NULL, # Add a new luminescence curve
                    add.info = NULL, # Add one or multiple (list/vector) optional information
                    source.image = NULL,
                    warnings = TRUE
                    ){

  ## ------ Changelog ------
  ## 2026-09-09, DM: First version
  ## 2026-09-15, DM: Add easy building of rectangular ROIs
  ## 2026-09-23, DM: Fix multiple bugs

  ## ToDos:
  ## - Create overlay properties automatically based on 'mask' and 'shape'
  ## - Add some 'checks' for overlay and 'curve'

  # Build a new ROI ...
  if (is.null(roi)) {

    # Mandatory parameters
    if (is.null(mask) || is.null(col_min) || is.null(row_min))
      stop("[set_roi()] If no 'roi' is set, the arguments 'mask', 'col_min' and 'row_min' are mandatory.")

    # Validate mask
    if (!is.matrix(mask) || !is.logical(mask)) {
      stop("[set_roi()] 'mask' must be a logical matrix.")
    }

    # Validate col_min and row_min
    if (!is.numeric(col_min) || length(col_min) != 1 || col_min < 0 || col_min != floor(col_min)) {
      stop("[set_roi()] 'col_min' must be a non-negative integer.")
    }

    if (!is.numeric(row_min) || length(row_min) != 1 || row_min < 0 || row_min != floor(row_min)) {
      stop("[set_roi()] 'row_min' must be a non-negative integer.")
    }


    if (is.null(shape)){
      shape <- "irregular"

      # Set shape to 'rectangle' automatically
      if (ncol(mask) * nrow(mask) == sum(mask))
        shape <- "rectangle"
    }else{
      # Ensure that it doesn't matter how the user did set cases
      shape <- tolower(shape)
    }

    # Check and set overlay options
    if (shape == "rectangle") {

      # ToDo: Add checks

      if(!(is.list(overlay) && length(overlay) > 0)){
        overlay <- list(dx = ncol(mask),
                        dy = nrow(mask))
      }
    } else if (shape == "circle") {

      # ToDo: Add checks or set overlay automatically
    } else {

      # ToDo: Add checks or set overlay automatically
    }

    if (is.null(class)) class <- "Unclassified"

    roi <- list(
      mask    = mask,
      col_min = col_min,
      row_min = row_min,
      shape   = shape,
      class   = class,
      info    = info,
      overlay = overlay,
      curves  = curves
      )

  # ... or edit an existing ROI
  } else {

    # Changing these, would make the others invalid
    if (!is.null(mask) || !is.null(col_min) || !is.null(row_min) || !is.null(shape))
      stop("[set_roi()] Changing 'mask', 'col_min', 'row_min' or 'shape' in an existing ROI object is not allowed.")

    # -------
    # As we go through the further arguments, some might need different handling
    # -------


    if (!is.null(class)) {
      roi$class <- class
      # ToDo: If in a future version the color is also saved, update the color here
    }

    if (is.list(info) && length(info) > 0){

      # Check if new list is as informative as the old one
      if (!all(names(roi$info) %in% names(info)) && warnings)
        warning("[set_roi()] Old 'info' contains entries which are not in new 'info'. Information might be lost.")

      roi$info <- info
    }

    if (is.list(overlay) && length(overlay) > 0){

      # Check if new list is as informative as the old one
      if (!all(names(roi$overlay) %in% names(overlay)) && warnings)
        warning("[set_roi()] Old 'overlay' contains entries which are not in new 'overlay'. Information might be lost.")

      # ToDo: Check if new overlay still matches 'mask', 'col_min' and 'row_min'

      if (warnings) warning("[set_roi()] Changing the overlay might lead to errornous plots.")

      roi$overlay <- overlay
    }

    if (is.list(curves) && length(curves) > 0){

      # Check if new list is as informative as the old one
      if (!all(names(roi$curves) %in% names(curves)) && warnings)
        warning("[set_roi()] Old 'curves' contains entries which are not in new 'curves'. Information might be lost.")

      roi$curves <- curves
    }

    if (!is.null(add.curve)) {

      # ToDo: Check if curve object has the right structure and contains the basic content
      this_curve <- list(add.curve)
      roi$curves <- c(roi$curves, this_curve)
    }

    if (!is.null(add.info)) {

      for (this_name in names(add.info)) {

        # Check if parameter already exists
        # # ToDo: Improve the next 8 lines of code
        # exists_already <- FALSE
        # while (this_name %in% names(roi$info)) {
        #   this_name <- paste0(this_name, "_")
        #   exists_already <- TRUE
        # }
        # if (warnings && exists_already)
        #   warning(paste("[set_roi()] 'info' parameter", this_name, "did already exists."))

        # ... naa, just overwrite the parameter if it exists already
        roi$info[[this_name]] <- add.info[[this_name]]
      }
    }
  }

  # Tell that this ROI was edited by this function
  roi$info$source_function <- "set_roi"

  # Update info(source_XXX = ...) parameters
  if (!is.null(source.image)) {

    # ToDo: In case ncols/nrows are updated, check the compatibility with the
    # former parameters

    img <- as.SpatRaster(source.image, warnings = warnings)

    roi$info$source_obj <- deparse(substitute(source.image))
    roi$info$source_ncols <- terra::ncol(img)
    roi$info$source_nrows <- terra::nrow(img)
  }

  return(roi)
}
