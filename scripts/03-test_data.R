#### Preamble ####
# Purpose: Tests data 
# Author: Samantha Barfoot, Mehrnoush Mohammadi, Brooklin Becker
# Date: 13 February 2024 
# Contact: samantha.barfoot@mail.utoronto.ca
# License: MIT
# need to have run 01-download_data.R

#### Workspace setup ####
library(tidyverse)

#### Test data ####

#boundary condition test
#read in the data 
food_choices <-
  read_csv(
    file = "outputs/data/food_choices.csv",
    show_col_types = FALSE
  )

#read in the data 
sum_table_wide <-
  read_csv(
    file = "outputs/data/sum_table_wide.csv",
    show_col_types = FALSE
  )

#will check that the table_incentive_pr values are in the range (0,1) for the food_choices table
for(i in 1:length(food_choices$table_incentive_pr)){
  if(food_choices$table_incentive_pr[i] < 0 || food_choices$table_incentive_pr[i] > 1 ){
    print(paste("food_choices: bad data table_incentive_pr on sample ",i))
  }
}

#will check that the table_incentive_pr values are in the range (0,1) for the sum_table_wide table
for(i in 1:length(sum_table_wide$table_incentive_pr)){
  if(sum_table_wide$table_incentive_pr[i] < 0 || sum_table_wide$table_incentive_pr[i] > 1 ){
    print(paste("sum_table_wide: bad data table_incentive_pr on sample ",i))
  }
}
