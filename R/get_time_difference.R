library(lubridate)
library(lutz)
library(tidygeocoder)

get_time_difference <- function(file, city, country) {

  # 1. Get file modification time
  file_time <- file.info(file)$mtime

  if (is.na(file_time)) {
    stop("File not found or modification time unavailable.")
  }

  # 2. Get your computer's time zone
  local_tz <- Sys.timezone()

  if (is.na(local_tz) || !nzchar(local_tz)) {
    stop("Could not determine the computer's time zone.")
  }

  # 3. Find coordinates of the city
  location <- data.frame(
    city = city,
    country = country
  )

  coords <- tidygeocoder::geocode(
    location,
    city = city,
    country = country,
    method = "osm",
    lat = latitude,
    long = longitude
  )

  if (is.na(coords$latitude[1]) ||
      is.na(coords$longitude[1])) {
    stop("Could not find coordinates for the city.")
  }

  # 4. Determine city's IANA time zone
  city_tz <- lutz::tz_lookup_coords(
    lat = coords$latitude[1],
    lon = coords$longitude[1],
    method = "accurate"
  )

  # 5. Calculate UTC offsets at file modification time
  utc_offset <- function(time, tz) {
    z <- format(time, tz = tz, format = "%z")
    sign <- ifelse(substr(z, 1, 1) == "-", -1, 1)
    hours <- as.numeric(substr(z, 2, 3))
    minutes <- as.numeric(substr(z, 4, 5))
    sign * (hours + minutes / 60)
  }

  city_offset <- utc_offset(file_time, city_tz)
  local_offset <- utc_offset(file_time, local_tz)

  # Positive = city ahead of computer
  difference <- city_offset - local_offset

  return(difference)
}
