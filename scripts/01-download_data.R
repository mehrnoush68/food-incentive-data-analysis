#### Preamble ####
# Purpose: Downloads, saves, and converts the data from .dta to .csv file format from the American Economic Association 
# Author: Samantha Barfoot, Mehrnoush Mohammadi, Brooklin Becker
# Date: 7 February 2024 
# Contact: samantha.barfoot@mail.utoronto.ca
# License: MIT
# Pre-requisites: download replication package with the raw data from American Economic Association (https://www.aeaweb.org/journals/dataset?id=10.1257/pol.20170588)

#### Workspace Setup ####
library(haven)
library(tidyverse)

#Note: data is behind sign-in
# data can be acessed at https://www.aeaweb.org/journals/dataset?id=10.1257/pol.20170588 from the American Economic Association

#### Read in the data ####
#Since data is behind a sign in it has also been added to the file directory at inputs/data/APRS_data.dta
raw_food <-
  read_dta('inputs/data/APRS_data.dta')

#### Save data and convert to csv ####
write_csv(
  x = raw_food,
  file = "inputs/data/food_data.csv"
)
