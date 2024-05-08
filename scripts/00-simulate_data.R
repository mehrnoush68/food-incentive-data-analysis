#### Preamble ####
# Purpose: Simulates food incentive data for the two datasets sum_table_wide and food_choices
# Author: Samantha Barfoot, Mehrnoush Mohammadi, Brooklin Becker
# Date: 13 February 2024 
# Contact: samantha.barfoot@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Simulate data ####
set.seed(1)

#variable that represents the number of columns in the simulated data set
num_samples <- 800

#simulated tibble table
simulated_data <-
  tibble(
    # Randomly pick an option, with replacement, 153 times
    "incentive" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "private" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "grade" = sample(
      x = 0:8,
      size = num_samples,
      replace = TRUE
    ),
    "table" = sample(
      x = 1:284,
      size = num_samples,
      replace = TRUE
    ),
    "table_size" = sample(
      x = 4:9,
      size = num_samples,
      replace = TRUE
    ),
    "table_incentive" = runif(num_samples),
    "grape" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "grape2" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "cluster" = sample(
      x = 1:284,
      size = num_samples,
      replace = TRUE
    ),
    "strata" = sample(
      x = 1:25,
      size = num_samples,
      replace = TRUE
    ),
    "sex" = sample(
      x = 2:3,
      size = num_samples,
      replace = TRUE
    ),
    "race" = sample(
      x = 1:6,
      size = num_samples,
      replace = TRUE
    ),
    "lunch" = sample(
      x = 1:4,
      size = num_samples,
      replace = TRUE
    ),
    "dg" = sample(
      x = -1:1,
      size = num_samples,
      replace = TRUE
    ),
    "sw" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "sc" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "male" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "group" = sample(
      x = 1:8,
      size = num_samples,
      replace = TRUE
    ),
    "sex_mf" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "grade_mod" = sample(
      x = 0:8,
      size = num_samples,
      replace = TRUE
    ),
    "black" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "hispanic" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "free" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "public" = sample(
      x = 1:1,
      size = num_samples,
      replace = TRUE
    ),
    "above_grade_median" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "nosurvey" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "dbestfriend" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "dbestfriend_i" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "dpopular" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "dpopular_i" = sample(
      x = 0:1,
      size = num_samples,
      replace = TRUE
    ),
    "tpr_own" = runif(num_samples),
    "Switched" = sample(
      x = c("Not Changed", "Cookie to Grape","Grape to Cookie"),
      size = num_samples,
      replace = TRUE
    ),
    "Stayed" = sample(
      x = c("Changed", "Stayed Cookie","Stayed Grape"),
      size = num_samples,
      replace = TRUE
    )
  )

#variable that represents the number of columns in the table
num_samples <- 5

#creates a tibble to simulate the data sum_wide_table dataset
simulated_data <-
  tibble(
    # Randomly pick an option, with replacement 5 times
    "Group" = c("Public-0", "Public-50-no incentive","Public-50-incentive", "Public-100-incentive", "Total"),
    "Observations" = sample(
      x = 100:200,
      size = num_samples,
      replace = TRUE
    ),
    "public" = sample(
      x = 1:1,
      size = num_samples,
      replace = TRUE
    ),
    "incentive" = runif(num_samples),
    "table_incentive" = runif(num_samples),
    "table_size" = runif(num_samples, 5.5,6.5),
    "male" = runif(num_samples,0.4,0.5),
    "black" = runif(num_samples,0.3,0.4),
    "grade" = runif(num_samples,3,5),
    "hispanic" = runif(num_samples,0.5,0.6),
    "free" = runif(num_samples,0.8,0.9)
  )

#creates csv file with simulated data 
write_csv(
  x = simulated_data,
  file = "outputs/data/food_choices.csv"
)

#creates csv file with simulated data 
write_csv(
  x = simulated_data,
  file = "outputs/data/sum_table_wide.csv"
)
