#' Class `"RLum.Analysis.ROI"`
#'
#' @description
#' Object class to represent analysis data for protocol and image analysis.
#' This is an extension of [Luminescence::RLum.Analysis-class] that also
#' carries region of interest (ROI) information.
#'
#' @name RLum.Analysis.ROI-class
#'
#' @docType class
#'
#' @slot roi
#' A single `RLumImage.ROI` object.
#'
#' @section Class version: 0.1.0
#'
#' @author
#' Marco Colombo, Institute of Geography, Heidelberg University (Germany)\cr
#'
#' @seealso [Luminescence::RLum.Analysis-class]
#'
#' @keywords classes internal
#'
#' @examples
#' showClass("RLum.Analysis.ROI")
#'
#' @export
setClass("RLum.Analysis.ROI",
         contains = "RLum.Analysis",
         slots = list(
             roi = "list"
         )
)

## Validator ----------------------------------------------------------------
setValidity("RLum.Analysis.ROI",
function(object) {
  ## an empty list is considered valid
  if (inherits(object@roi, "RLumImage.ROI") || length(object@roi) == 0)
    return(TRUE)
  "@roi must be a single object of class 'RLumImage.ROI'"
})

## set_RLum() ---------------------------------------------------------------
#' Construction method for [RLumImage::RLum.Analysis.ROI-class] objects.
#'
#' @param class
#' Name of the S4 class to create.
#'
#' @param originator
#' Name of the function that produces this object. It is inferred automatically
#' but can be set manually.
#'
#' @param .uid
#' Unique object identifier.
#'
#' @param .pid
#' Parent object identifier.
#'
#' @param protocol
#' Protocol type for analysis object. Value may be used by subsequent
#' analysis functions.
#'
#' @param records
#' List of [Luminescence::RLum.Data.Curve-class] objects.
#'
#' @param info
#' List containing additional info data for the object.
#'
#' @param roi
#' An `RLumImage.ROI` object.
#'
#' @return
#' An [RLumImage::RLum.Analysis.ROI-class] object.
#'
#' @examples
#' ## create an empty object
#' obj <- set_RLum("RLum.Analysis.ROI")
#'
#' ## show the object's structure
#' show(obj)
#'
#' @export
setMethod("set_RLum", "RLum.Analysis.ROI",
function(
  class,
  originator,
  .uid,
  .pid,
  protocol = NA_character_,
  records = list(),
  info = list(),
  roi = list()
) {
  ## empty class object
  obj <- methods::new(Class = "RLum.Analysis.ROI",
                      roi = roi)

  ## allow extending an existing RLum.Analysis object
  if (inherits(records, "RLum.Analysis")) {
    info <- c(records@info, info)
    if (missing(protocol))
      protocol <- records@protocol
    if (isTRUE(is.na(.pid)))
      .pid <- records@.uid
    records <- records@records
  }

  obj@protocol <- protocol
  obj@originator <- originator
  obj@records <- records
  obj@info <- info
  obj@.uid <- .uid
  obj@.pid <- .pid

  obj
})

## show() -------------------------------------------------------------------
#' Show the structure of `RLum.Analysis.ROI` objects.
#'
#' @noRd
setMethod("show", "RLum.Analysis.ROI",
function(object) {

  ## call the Luminescence RLum.Analysis show() method
  out <- capture.output(methods::callNextMethod(object))
  out <- gsub("RLum.Analysis-class", "RLum.Analysis.ROI-class", out,
              fixed = TRUE)

  ## extend the output to include ROI objects
  idx <- grep("number of records:", out, fixed = TRUE)
  if (length(object@roi) > 0) {
    roi <- object@roi
    msg <- c(sprintf("\t ROI: %s, %d x %d px at (%d, %d)", roi$shape,
                     ncol(roi$mask), nrow(roi$mask), roi$col_min, roi$row_min),
             sprintf("\t mineral class: %s", roi$class))
  } else {
    msg <- "\t ROI: <none>"
  }
  out <- c(out[1:(idx - 1)], msg, out[idx:length(out)])
  cat(out, sep = "\n")
})
