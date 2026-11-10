#' Transform wavelength into RGB value
#'
#' @param wl
#' Wavelength to convert. **Note:** This is silently clamped between 300 and
#' 1000 nanometres.
#'
#' @param factor
#' Scaling factor (1 by default).
#'
#' @return
#' A hexadecimal string representing the wavelength colour in RGB format.
#'
#' @examples
#' wavelength_to_rgb(420)
#'
#' @export
wavelength_to_rgb <- function(wl, factor = 1) {

  # If wavelength is NA, return a factor-depending shade of grey
  if (is.na(wl) || !is.numeric(wl)) {

    # return grey if no valid wavelength is defined
    r <- 0.9
    g <- 0.9
    b <- 0.9
  } else {

    wl <- max(min(wl, 1000), 300)

    if (wl < 380) {
      r <- 1
      g <- -(wl - 380) / (380 - 250)
      b <- 1

    } else if (wl < 440) {
      r <- -(wl - 440) / (440 - 380)
      g <- 0
      b <- 1

    } else if (wl < 490) {
      r <- 0
      g <- (wl - 440) / (490 - 440)
      b <- 1

    } else if (wl < 510) {
      r <- 0
      g <- 1
      b <- -(wl - 510) / (510 - 490)

    } else if (wl < 580) {
      r <- (wl - 510) / (580 - 510)
      g <- 1
      b <- 0

    } else if (wl < 645) {
      r <- 1
      g <- -(wl - 645) / (645 - 580)
      b <- 0

    } else if (wl < 780){
      r <- 1
      g <- 0.4 * (wl - 645) / (780 - 645)
      b <- 0.5 * (wl - 645) / (780 - 645)

    } else {
      r <- 1 - 0.4 * (wl - 780) / (1000 - 780)
      g <- 0.4
      b <- 0.5
    }
  }
  grDevices::rgb(min(c(r * factor, 1)),
      min(c(g * factor, 1)),
      min(c(b * factor, 1)))
}
