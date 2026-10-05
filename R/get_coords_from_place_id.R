# Function ---------------------------------------------------------------------
# Get lat/lon from place ID
get_coords_from_place_id <- function(place_id, key) {
  # Use the Place Details (NEW) API endpoint
  url <- paste0("https://places.googleapis.com/v1/places/", place_id)

  # Make a request
  req <- httr2::request(url) |>
    httr2::req_url_query(key = key) |>
    httr2::req_headers(`X-Goog-FieldMask` = "location") |>
    httr2::req_perform()

  # What is the content of the request (ideally lat and lon data)
  content <- httr2::resp_body_json(req)

  # Store the lat and lon data in a tibble if present (NULL response if not)
  if (!is.null(content$location)) {
    details <- dplyr::tibble(
      place_ID = place_id,
      lat = content$location$latitude,
      lon = content$location$longitude
    )
  } else {
    details <- dplyr::tibble(
      place_ID = place_id,
      lat = NA_real_,
      lon = NA_real_
    )
  }

  return(details)
}
