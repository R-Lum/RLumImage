#' Convert a ROI list into a list of `RLum.Analysis` objects
#'
#' Converts the per-ROI curve lists stored in a ROI object (as returned by
#' [apply_rois] and [set_roi]) into `Luminescence::RLum.Data.Curve` objects
#' and combines all curves of one ROI into a `Luminescence::RLum.Analysis`
#' object. The output is a named list of `RLum.Analysis` objects, one per ROI.
#'
#' Each entry of `rois$curves` (a list with elements `x`, `y`, `recordType`,
#' `detectionInterval`, `curveDescriptor`, and `source_obj`) is translated into
#' an `RLum.Data.Curve` object, where
#'
#' - `x`/`y` are combined into the 2-column `data` matrix,
#' - `recordType` is taken over into the `recordType` slot,
#' - `curveType` is set to `"measured"`,
#' - all remaining per-curve metadata is stored in the `info` slot.
#'
#' The whole ROI is collected in an `RLum.Analysis` object (slots `records`
#' and `info`), with the ROI's `class` stored in `info$class`.
#'
#' @param rois
#' A named list of ROI objects as returned by [apply_rois], [set_roi],
#' [find_grains] or [select_grains]. Each ROI is a list with (at least) a
#' `curves` element holding a list of per-curve lists.
#'
#' @param originator
#' Name to be stored in the `originator` slot of every generated object.
#' If `NULL`, defaults to the name of this function.
#'
#' @return
#' A named list of `Luminescence::RLum.Analysis` objects, one per ROI.
#' Each list element maintains the name of the corresponding ROI.
#'
#' @seealso
#' [Luminescence::set_RLum()], [Luminescence::RLum.Analysis-class],
#' [Luminescence::RLum.Data.Curve-class]
#'
#' @examples
#' \dontrun{
#'   rois_analysis <- convert_rois2RLum(rois)
#'   get_RLum(rois_analysis[[1]])
#' }
#'
#' @export
convert_rois2RLum <- function(rois, originator = NULL) {

  ## ------ Changelog ------
  ## 2026-09-26, DM & DeepSeek v4: First version

  if (missing(originator) || is.null(originator))
    originator <- "convert_rois2RLum"

  # Sanity check of the input
  if (!is.list(rois) || is.null(names(rois)) || length(rois) == 0)
    stop("[convert_rois2RLum()] 'rois' must be a non-empty named list.")

  if (all(c("mask", "col_min", "row_min") %in% names(rois)))
    rois <- list(rois)

  out <- vector(mode = "list", length = length(rois))
  names(out) <- names(rois)

  for (roi_name in names(rois)) {

    roi <- rois[[roi_name]]

    # Convert every curve into an RLum.Data.Curve object
    records <- lapply(roi$curves, function(curve) {

      if (!is.list(curve) || is.null(curve$x) || is.null(curve$y))
        stop(paste0("[convert_rois2RLum()] Curve entry of ROI '",
                    roi_name, "' is malformed."))

      # Combine x and y into the 2-column data matrix
      curve_data <- cbind(x = as.numeric(curve$x),
                          y = as.numeric(curve$y))

      # recordType slot has to be a single character
      record_type <- curve$recordType
      if (length(record_type) != 1 || is.na(record_type))
        record_type <- NA_character_

      # Store all remaining per-curve metadata in the info slot
      info <- curve[!names(curve) %in% c("x", "y", "recordType")]

      Luminescence::set_RLum(
        class = "RLum.Data.Curve",
        originator = originator,
        recordType = record_type,
        curveType = "measured",
        data = curve_data,
        info = info
      )
    })

    # Collect the whole ROI in an RLum.Analysis object
    roi_info <- list(class = roi$class)

    out[[roi_name]] <- Luminescence::set_RLum(
      class = "RLum.Analysis",
      originator = originator,
      records = records,
      info = roi_info
    )
  }

  return(out)
}
