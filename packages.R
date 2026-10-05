# Required packages for targets pipeline
packages <- c(
  # The usual gang
  "dplyr",
  "tidyr",
  "purrr",
  "here",

  # For communicating with APIs
  "httr",
  "jsonlite",

  # Nice little progress bar
  "pbapply"
)

# If package is not installed then install the package
for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }

  library(package, character.only = TRUE)
}
