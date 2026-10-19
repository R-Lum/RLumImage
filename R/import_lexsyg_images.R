#' Searches for TIFF files and assigns them to XSYG sequence data
#'
#' Imports TIFF files recorded from lexsyg research readers using LexStudio 2.
#'
#' **Important note**: This function is complicated and might break if the
#' data structure of lexsyg image recording is changed. Thus, this function needs a
#' overwork once LexStudio is updated for better image recording. Also, this structure
#' should be switched to XLUM format.
#'
#' @param xsyg_file
#' Path to the lexsyg XSYG file of the measured sequence.
#'
#' @param folder
#' Folder where the TIFF files are stored. Defaults to the XSYG file's directory.
#'
#' @param detector
#' Short name of the detector in LexStudio 2.
#'
#' @param verbose
#' Logical. If `TRUE`, prints progress messages. TIFF files that fall outside
#' the XSYG recording time range (i.e. cannot be matched to any record) are
#' always reported via `warning()` and excluded from the result, regardless
#' of `verbose`.
#'
#' @returns
#' A nested list, structured as:
#'
#' ├─ [[aliquot position]]
#' │		├─ [[1]]
#' │		│   ├─ position
#' │		│   ├─ recordNumber
#' │		│   ├─ recordType
#' │		│   ├─ detectionInterval
#' │		│   ├─ detectionWavelength
#' │		│   └─ imageFiles (data.frame)
#' │		│   	├─ file
#' │		│   	├─ time
#' │		│   	└─ channel
#' ...	...
#'
#'
#' @export
#'
#' @examples
import_lexsyg_images <- function(xsyg_file,
                                 folder = NA,
                                 detector = "EMCCD",
                                 verbose = TRUE,
                                 print.sequence = TRUE,
                                 city=NA,
                                 country=NA){
  ## ToDo
  ## - (!) Read TIFF meta data and use that time stamp as first choice
  ##   Fall back to file creating time stamp only if that in the meta data is not available
  ## - Add console output of XSYG basename and list of aliquot positions if verbose = TRUE
  ## - Revise 'ImageData' list structure and maybe add an empty 'Processing' list
  ## - Missing or unexpected meta data values in the XSYG have no error handling.
  ##   Put meta data readout in a sub-function which provides error handling and default "NA" return.
  ##
  ## Changelog:
  ## 2026-08-10, DM, MSG: Check for 'recordType' location in the RLum data
  ## 2026-08-10, DM, Claude Sonnet 5: Fix issue of fake aliquots and too long imageFile lists
  ##  if folder contains TIFF files which are not covered by the XSYG file
  ## 2026-08-10, DM: Saves detectionInterval now as numeric
  ## 2026-10-11, MSG: added merge if >1 xsyg in folder


  ### --------------- Input checks ------------------

  if(length(xsyg_file)>1) {

    #sort by time
    xsyg_file <- xsyg_file[order(as.numeric(file.info(xsyg_file)$mtime))]

    #separate first and rest
    xsyg_file_rest <- xsyg_file[-1]
    xsyg_file <- xsyg_file[1]
  } else { xsyg_file_rest <- NULL}

  if (!file.exists(xsyg_file))
    stop("[import_lexsyg_images()] XSYG file does not exist.")

  if (is.na(folder)) folder <- dirname(xsyg_file)

  # Find all .tif or .tiff files
  tif_files <- list.files(folder, pattern = "\\.tif(f)?$", full.names = TRUE)
  if (length(tif_files) < 1)
    stop("[import_lexsyg_images()] Folder does not contain any TIFF images.")

  if (verbose) cat("Folder contains", length(tif_files), "TIFF files.\n\n")

  ### --------------- Step 1 ------------------

  if (verbose) cat("#1 Use creation date of the TIFF files as time stamp and sort them ...")

    # Create file table and sort the for their creating data
  files <- data.frame(NULL)
  for (file in tif_files) {

    # Get creation time
    recorded_at <- as.numeric(file.info(file)$ctime)
    alt_recorded_at <- as.numeric(file.info(file)$mtime)

    if (alt_recorded_at < recorded_at)
      recorded_at <- alt_recorded_at

    files <- rbind(files,
                   data.frame(file = file,
                              time = recorded_at, # + timezone_offset,
                              position = 0, type = "unknown",
                              channel = 0, recordNumber = -1,
                              interval = 0, wavelength = NA,
                              maxMeasuredT= NA))
  }

  # Sort files
  files <- files[order(files$time),]


  if (verbose) cat("DONE\n   Images were recorded between",
                   strftime(files$time[1]), "and", strftime(files$time[nrow(files)]), "\n\n")

  ### --------------- Step 2 ------------------

  if (verbose) cat("#2 Read XSYG file and get sequence data ...")

  # Read lexsyg data
  lex <- Luminescence::read_XSYG2R(xsyg_file[1],
                                   fastForward = TRUE,
                                   verbose = FALSE,
                                   txtProgressBar = FALSE)

  #merge xsyg files
  if(length(xsyg_file_rest)>0){

    for(xsyg_i in 1:length(xsyg_file_rest)){
    lex_i <- Luminescence::read_XSYG2R(xsyg_file_rest[xsyg_i],
                                     fastForward = TRUE,
                                     verbose = FALSE,
                                     txtProgressBar = FALSE)

    lex[[1]] <- merge_RLum(objects = list(lex[[1]], lex_i[[1]]))

     }
    }



  # Get sequence information
  record_table <- data.frame(NULL)
  for (aliquot_no in 1:length(lex)) {

    no <- 1
    for(record in lex[[aliquot_no]]@records)
    {
      info <- record@info

      if (isTRUE(info$detector == detector)) {

        start_time <- as.numeric(strptime(info$startDate,
                                          format = "%Y%m%d%H%M%S"))

        # Extract the central emission wavelength from the filter, if available
        wavelength <- suppressWarnings(as.numeric(sub(".*?(\\d+)\\s*nm.*", "\\1",
                                     info$detectionWindow,
                                     ignore.case = TRUE)))
        if (length(wavelength) != 1) wavelength <- NA

        # get recordType for different LexStudio version
        if (is.null(info$recordType) && "recordType" %in% slotNames(record)) {
          record_type <- record@recordType
          warning("XSYG meta data parsed to RLum object misses 'recordType' in info list. Please check versions of R package Luminescence and LexStudio.")
        } else if (is.character(info$recordType)){
          record_type <- info$recordType
        } else {
          stop("[import_lexsyg_images()] XSYG file does not contain any recordType information. Please check versions of R package Luminescence and LexStudio.")
        }

        if("recordType" %in% slotNames(record)) recordType_OldLexStudio <- record@recordType

        #to get measurement temperature
        stepID <- info[["parentID"]]
        #get heating record of the same step
        Heating_record <- which(sapply(1:length(lex[[aliquot_no]]@records), function(x) lex[[aliquot_no]]@records[[x]]@info[["parentID"]]==stepID &
                 ifelse(is.null(lex[[aliquot_no]]@records[[x]]@info[["stimulator"]]), FALSE, lex[[aliquot_no]]@records[[x]]@info[["stimulator"]]=="heating element") &
                 ifelse(is.null(lex[[aliquot_no]]@records[[x]]@curveType), FALSE, lex[[aliquot_no]]@records[[x]]@curveType=="measured")))
        #get maximum measured T of the same step
        maxMeasuredT <- ifelse(length(Heating_record)==0, NA, round(max(lex[[aliquot_no]]@records[[Heating_record]]@data[,2])))


        # Build a overview of the records for this aliquot
        record_table <- rbind(record_table,
                              data.frame(recordNumber = no,
                                         time = start_time,
                                         type = record_type,
                                         position = info$position,
                                         duration = info$duration,
                                         offset = info$offset,
                                         interval = info$interval,
                                         wavelength = wavelength,
                                         maxMeasuredT = maxMeasuredT))
      }
      no <- no + 1
    }

    #  record_tables[[aliquot_no]] <- record_table
  }

  if (verbose) cat("DONE\n   Found", nrow(record_table),"records in", length(lex), "aliquots, using a",
                   detector, "as detector.\n\n")

  ### --------------- Step 3 ------------------

  if (verbose) cat("#3 Assign image files to sequence steps according to their time stamp ...")

  #correct for time difference between measurement location and analysis location
  timezone_offset <- 3600*ifelse(is.na(country),
                                 round((abs(as.numeric(file.info(xsyg_file)$mtime)-
                                              as.numeric((strptime( lex[[length(lex)]]@records[[length(lex[[length(lex)]]@records)]]@info[["endDate"]],
                                                                    format = "%Y%m%d%H%M%S")))))/3600), #difference between xsyg and tif "change time", rounded to hours (time zone)
                                 get_time_difference(file=tif_files[1], city=city, country=country))

  files$time <- files$time + timezone_offset

  if (verbose & timezone_offset>0) cat("\n   Corrected for time zone offset of ", timezone_offset/3600, " h...")

  # Determine a sensible upper time bound for the *last* record, instead of
  # using Inf (which would greedily assign every later TIFF file to it).
  last_duration <- suppressWarnings(as.numeric(record_table$duration[nrow(record_table)]) + as.numeric(record_table$offset[nrow(record_table)]))
  if (!is.finite(last_duration) || last_duration <= 0) {

    # Duration info missing/invalid: fall back to the typical spacing
    # between records as a best-effort estimate.
    gaps <- diff(record_table$time)
    last_duration <- if (length(gaps) > 0) stats::median(gaps) else 0
  }
  last_record_end <- record_table$time[nrow(record_table)] + last_duration

  # Now assign the xsyg infos to the file table
  file_i <- 1
  for (i in 1:nrow(record_table)) {

    # Time limits of the current record
    start_time <- record_table$time[i]

    end_time <- last_record_end
    if (i < nrow(record_table)) end_time <- record_table$time[i + 1]

    rec_i <- 1
    while(file_i <= nrow(files) && files$time[file_i] < end_time)
    {

      if (files$time[file_i] >= start_time) {

        files$position[file_i] <- record_table$position[i]
        files$type[file_i] <- record_table$type[i]
        files$channel[file_i] <- rec_i
        files$wavelength[file_i] <- record_table$wavelength[i]
        files$interval[file_i] <- record_table$interval[i]
        files$recordNumber[file_i] <- record_table$recordNumber[i]
        files$maxMeasuredT[file_i] <- record_table$maxMeasuredT[i]
      }

      file_i <- file_i + 1
      rec_i <- rec_i + 1
    }
  }

  # Files that never got matched to any record (either older than the first
  # record, or younger than the estimated end of the last one) still carry
  # their initial placeholder values (type == "unknown", position == 0).
  # Drop them rather than letting them form a bogus aliquot '0' or being
  # mis-assigned to the last record.
  unmatched <- files$type == "unknown"
  if (verbose) cat("DONE\n   Assigned", sum(!unmatched),"TIFF files to specific sequence steps. ")

  if (any(unmatched)) {
    if (verbose) cat(sum(unmatched), "TIFFs fall outside the XSYG time range and were excluded.\n")

    files <- files[!unmatched, , drop = FALSE]
  }

  if (nrow(files) < 1)
    stop("[import_lexsyg_images()] No TIFF file could be matched to any XSYG record.")

  if(verbose) cat("\n\n")

  ### --------------- Step 4 ------------------

  if (verbose) cat("#4 Build R list object ...")

  # Now split the long table into aliquots ...
  image_seq <- split(files, files$position, drop = TRUE)

  # ... and structure further
  image_seq <- lapply(image_seq, function(objA) {

    # split by recordNumber
    records <- split(objA, objA$recordNumber, drop = TRUE)

    # convert to unnamed list of structured elements
    unname(lapply(records, function(objB) {
      list(
        position = unique(objB$position),
        recordNumber = unique(objB$recordNumber),
        recordType = unique(objB$type),
        detectionInterval = as.numeric(unique(objB$interval)), # Crashes if interval is not available
        detectionWavelength = unique(objB$wavelength),
        maxMeasuredT = unique(objB$maxMeasuredT),
        imageFiles  = objB[ , !(names(objB) %in% c("position",
                                                   "recordNumber",
                                                   "type",
                                                   "wavelength",
                                                   "interval")), drop = FALSE])
    }))
  })

  if (verbose) {
    # in megabyte
    image_seq_size <- round(object.size(image_seq) / 1014^2, 2)
    cat("DONE\n   Created image sequence object which is",
                   image_seq_size, "MB large.\n\n")
  }
  if (verbose)
    get_sequence(image_seq, print.friendly = TRUE, verbose = TRUE)

  return(image_seq)
}
