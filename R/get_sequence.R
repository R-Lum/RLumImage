#' Extracts the sequence table of an imported imaging measurement
#'
#' @param obj
#' A list as returned by [import_lexsyg_images], either for a single aliquot
#' position or a list of such lists for multiple positions.
#'
#' @param print.friendly
#' Whether a nicely formatted output should be produced (`FALSE` by default).
#'
#' @param digits
#' Number of digits used when rounding. It is ignored if `print.friendly` is
#' `FALSE`.
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#'
#' @return
#' A data frame with one row per measurement record and columns `files`,
#' `recordType`, `wavelength`, `interval`, and `maxMeasuredT`. With
#' `print.friendly = TRUE`, values are rounded and the columns are given
#' readable names.
#'
#' @examples
#' # TODO
#'
#' @export
get_sequence <- function(
  obj,
  print.friendly = FALSE,
  digits = 2,
  verbose = TRUE
) {

  ## ToDo
  ## - Check for 'Processing' list entry and add to table
  ## - Check for 'ImageData' list entry and add to table

  if (!is.list(obj)) stop("[get_sequence()] Input object must be of type list.")

  # Is input object a list of lists (multiple aliquots) or just a list (one aliquot selected)?
  if (is.list(obj[[1]])) {

    seq <- obj[[1]]

  }else{
    seq <- obj
  }

  # Extract sequence data
  tab <- data.frame(NULL)
  for (i in 1:length(seq)) {
    rec <- seq[[i]]

    files <- nrow(rec$imageFiles)
    interval <- as.numeric(rec$detectionInterval)

    # Build table
    row <- data.frame(files = files,
                      recordType = rec$recordType,
                      wavelength = rec$detectionWavelength,
                      interval = interval,
                      maxMeasuredT = rec$maxMeasuredT)

    tab <- rbind(tab, row)
  }

  if (!print.friendly) return(tab)

  # Round
  tab$interval <- round(tab$interval, digits)

  # Nice emission wavelength column
  na.ids <- is.na(tab$wavelength)
  tab$wavelength[na.ids] <- ""
  tab$wavelength[!na.ids] <- paste(tab$wavelength[!na.ids], "nm")

  # Provide a nice header
  colnames(tab) <- c("Files", "Type", "Emission",  "Interval [sec]", "Maximum measured temperature [\u2103]") # \u2103 is ℃


  if (verbose) {
    print(tab, right = FALSE)
    cat("Measurement sequence of position",  paste0(names(obj)[1], "."))

    if (length(obj) > 1) {
      cat(" It is assumed that the sequences for the other",
          length(obj) - 1, "positions are identical.")
    }
  cat("\n")
  }

  return(tab)
}
