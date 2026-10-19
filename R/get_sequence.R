#' Extracts the sequence table of an imported imaging measurement
#'
#' @param obj
#' @param print.friendly
#' @param digits
#' @param verbose
#'
#' @returns
#' @export
#'
#' @examples
get_sequence <- function(obj,
                         print.friendly = FALSE,
                         digits = 2, # Just if print.friendly = TRUE
                         verbose = TRUE){

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
  emi <- tab$wavelength
  emi[is.na(emi)] <- ""
  for (i in 1:length(emi)) {
    if (emi[i] != "") emi[i] <- paste(emi[i], "nm")
  }
  tab$wavelength <- emi

  # Provide a nice header
  colnames(tab) <- c("Files", "Type", "Emission",  "Interval [sec]", "Maximum measured temperature [°C]")


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
