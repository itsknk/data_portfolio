# drought_data_processing.R
# Script for processing drought impact data with monthly/weekly identifiers

library(dplyr)
library(readr)

# Convert numeric month to 3-letter abbreviation
month_to_abbrev <- function(month_num) {
  stopifnot(month_num %in% 1:12)  # Validate input
  month.abb[month_num]
}

# Load and preprocess data
drought_data <- read_csv('PopulationDrought.csv') %>%
  select(-1) %>%  # Remove first column (assumed index)
  mutate(
    Month = month_to_abbrev(Month),  # Convert numeric month to abbreviation
    month_year = paste(Month, Year)
  ) %>%
  group_by(month_year) %>%
  mutate(
    week_month_year = paste(row_number(), month_year)  # Create weekly identifier
  ) %>%
  ungroup() %>%
  select(-Year, -Month, -X13, -X14) %>%  # Explicit column removal
  tibble::column_to_rownames("week_month_year")  # Set meaningful row names

# Verify final structure
glimpse(drought_data)
