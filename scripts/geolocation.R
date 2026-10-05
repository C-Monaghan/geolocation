# Packages ---------------------------------------------------------------------
pacman::p_load(
  dplyr,
  tidyr,
  purrr,
  httr,
  jsonlite,
  pbapply
)

# Setting API Key --------------------------------------------------------------

# Run this to add API key to .Renviron
# usethis::edit_r_environ(scope = "project")

api_key <- Sys.getenv("GOOGLE_API_KEY") # Edit R environment with API key

# Geolocation function ---------------------------------------------------------
source(here::here("R/get_coords_from_place_id.R"))

# Data -------------------------------------------------------------------------
places <- readRDS(here::here("data/places.RDS")) |> pull(place_ID)

# Geocode the place IDs --------------------------------------------------------
geo_codes <- pblapply(places, function(road_id) {
  get_coords_from_place_id(place_id = road_id, key = api_key)
}) |>
  bind_rows()

# Export -----------------------------------------------------------------------
saveRDS(object = geo_codes, file = here::here("data/geo_codes.RDS"))
