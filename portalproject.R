library(tidyverse)
library(portalr)

# Load in the data
rodent_data <- read.csv("PortalData/Rodents/Portal_rodent.csv")
species_data <- read.csv("PortalData/Rodents/Portal_rodent_species.csv")
weather_data <- read.csv("PortalData/Weather/Portal_weather.csv")

# Data cleaning

# Select relevant variables
rodent_data <- rodent_data[, c(1, 2, 3, 4, 5, 6, 8, 9, 31)]



# Feature engineering


# Create species diversity parameter

rodent_tbl <- rodent_data %>%
  filter(species != "") %>%
  group_by(year, species) %>%
  count() %>%
  group_by(year) %>%
  mutate(n_peryear = sum(n))


n_peryear <- unique(rodent_tbl$n_peryear)
year = c(1977:2022)
n <- data.frame(n_peryear, year)

# Full join

rodent_data <- full_join(rodent_data, n, by = "year")


