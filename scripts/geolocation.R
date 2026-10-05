# Packages ---------------------------------------------------------------------
source("packages.R")

# Setting API Key --------------------------------------------------------------

# Run this to add API key to .Renviron
# usethis::edit_r_environ(scope = "project")

api_key <- Sys.getenv("GOOGLE_API_KEY") # Edit R environment with API key

# Geolocation function ---------------------------------------------------------
source(here("R/get_coords_from_place_id.R"))

# Loading the data -------------------------------------------------------------
# What dataset number are you using (1, 2, 3, 4, 5)?
number <- 1
import_data <- paste0("dataset_", number, ".rds")

places <- readRDS(here::here("data/split/", import_data)) |> pull(place_ID)

# Geocode the place IDs --------------------------------------------------------
geo_codes <- pblapply(places, function(road_id) {
  get_coords_from_place_id(place_id = road_id, key = api_key)
}) |>
  bind_rows()

# Export -----------------------------------------------------------------------
export_data <- paste0("geocodes_", number, ".rds")

saveRDS(object = geo_codes, file = here::here("data/geocoded/export_data.RDS"))
