#' Saves single-grain IR-RF measurements
#'
#' Writes a *.rf file, see Mittelstraß and Kreutzer (2021) for details.
#' Open the resulting *.rf file with [Luminescence::read_RF2R] for further use.
#'
#' @param rois
#' List of regions of interest (ROIs) as returned by [apply_rois].
#'
#' @param file
#' File path of the *.rf file to write.
#'
#' @param curve.selection
#' Numeric vector of length 2 storing the indices of RF_nat and RF_reg curves
#' in `$curves` list of ROI objects.
#'
#' @param class
#' Mineral classes to write out. If `NA`, all ROIs are taken.
#'
#' @param meta
#' List of additional 'info' for the XML header.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' The name of the file written to is returned invisibly.
#'
#' @references
#' Mittelstraß, D., Kreutzer, S., 2021. Spatially resolved infrared
#' radiofluorescence: single-grain K-feldspar dating using CCD imaging.
#' Geochronology 3, 299–319. \doi{10.5194/gchron-3-299-2021}
#'
#' @export
write_rf_table <- function(
  rois,
  file,
  curve.selection = c(1, 2),
  class = NA,
  meta = NULL,
  verbose = TRUE
) {

  ## Changelog
  ## 2026-08-25, DM: Initial implementation.
  ## 2026-09-16, DM: Revision for new ROI object structure; changed curve selection approach
  ##
  ## ToDo's:
  ## - Update header line code when Luminescence 1.4 RLumImage 0.1 is released
  ## - Take over global meta data from ROIs object to header
  ## - Select RF_nat and RF_reg curves via RecordType and/or DetectionWavelength

  if (length(rois) == 0L) stop("[save_roi_table()]: 'rois' is empty.")

  # ----- Data reduction -----
  # Reduce the ROI list to only those with the correct class and to only
  # the information which is needed
  grains <- list()
  N <- 0
  for (i in seq_along(rois)) {

    roi <- rois[[i]]
    grain <- list()

    # Sort for mineral class
    if(!is.na(class) && roi$class != class) next

    # Get curves (if there are enough)
    if (length(roi$curves) < max(curve.selection)) next
    grain <- roi$curves[curve.selection]


    # Append the roi parameters, but only the length=1 attributes
    for (param in names(roi)) {
      if(!is.atomic(roi[[param]]) || length(roi[[param]]) != 1) next
      grain[[param]] <- roi[[param]]
    }

    # Store attributes of the mask, without storing the mask itself
    grain$width <- ncol(roi$mask)
    grain$height <- nrow(roi$mask)
    grain$pixels <- sum(roi$mask)

    # Append everything stored in the $info slot
    grain <- c(grain, roi$info)

    # Store all in a new list
    grains[[paste0("grain_", i)]] <- grain
    N <- N + 1
  }

  if (verbose) cat("Select", N, "from", length(rois), "regions of interests.\n")

  if (N == 0)
    stop("[save_roi_table()]: No entry of the 'rois' list matches the filter arguments.")

  # ----- Header line -----
  header_fields <- c(
    "macro_version=0.1.0", # ToDo: Remove this after release of Luminescence 1.4
    paste0("rlumimage_version=", packageVersion("RLumImage")),
    paste0("terra_version=", packageVersion("terra")),
    paste0("r_version=", getRversion()),

    # Assume that the curve descriptor of the first RF_nat is the same as for all other curves
    paste0("curveDescriptor=\"", grains[[1]][[1]]$curveDescriptor, "\""),
    paste0("date=\"", date(), "\""))

  meta_str <- NULL
  if (length(meta) > 0L)
    meta_str <- paste(names(meta), unlist(meta), sep = "=", collapse = " ")

  header_line <- paste0("<", paste(header_fields, collapse = " "), meta_str, ">")

  # ----- <Statistics> block -----

  statistics_block <- c("<Statistics>",
                        paste(c("ROI:", names(rois)), collapse = "\t"))


  # Which meta data does the ROI entries carry?
  for (param in names(grains[[1]])) {

    # Use first ROI for type check to exclude any curve data
    if(!is.atomic(grains[[1]][[param]])) next

    # Define one line for each parameter
    stat <- paste0(param, ":")

    # Build columns
    for (grain in grains) stat <- c(stat, grain[[param]])

    # Add the line of this parameter
    statistics_block <- c(statistics_block, paste(stat, collapse = "\t"))
  }
  statistics_block <- c(statistics_block, "</Statistics>")

  # ----- Create signal curve tables -----

  # Build two tables
  df_nat <- df_reg <- NULL
  for (grain_name in names(grains)) {

    grain <- grains[[grain_name]]

    # Set the first two columns
    if (is.null(df_nat) || is.null(df_reg)) {
      df_nat <- data.frame(no = seq_along(grain[[1]]$x),
                           x = grain[[1]]$x)
      df_reg <- data.frame(no = seq_along(grain[[2]]$x),
                           x = grain[[2]]$x)
    }

    # Set the column for the RF signal
    df_nat[[grain_name]] <- round(grain[[1]]$y, 4)
    df_reg[[grain_name]] <- round(grain[[2]]$y, 4)
  }

  # ----- <Natural> block -----
  natural_block <- c(
    "<Natural>",
    paste(names(df_nat), collapse = "\t"))

  for (i in seq_along(nrow(df_nat))) {
    natural_block <- c(
      natural_block,
      paste(df_nat[i, ], collapse = "\t"))
  }
  natural_block <- c(natural_block, "</Natural>")

  # ----- <Bleached> block -----
  bleached_block <- c(
    "<Bleached>",
    paste(names(df_reg), collapse = "\t"))

  for(i in 1:nrow(df_reg))
    bleached_block <- c(
      bleached_block,
      paste(df_reg[i, ], collapse = "\t"))

  bleached_block <- c(bleached_block, "</Bleached>")

  # ----- Save *.rf file -----
  all_lines <- c(header_line, statistics_block, natural_block, bleached_block)
  writeLines(all_lines, con = file)
  if (verbose) cat("Saved", file, "\n")

  invisible(file)
}
