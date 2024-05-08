#### Preamble ####
# Purpose: Cleans the raw data compiled by the original papers researchers
# Author: Samantha Barfoot, Mehrnoush Mohammadi, Brooklin Becker
# Date: 13 February 2024
# Contact: samantha.barfoot@mail.utoronto.ca
# License: MIT
# Pre-requisites: need to have run 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(knitr)
library(kableExtra)
library(dplyr)

#### Load Data ####
incentive_data <-
  read_csv(
    file = "inputs/data/food_data.csv",
    show_col_types = FALSE,
  )

#### Clean data ####

# Filter data for only public treatment tables
public_data <- incentive_data|>
  filter(private == 0)

# Remove all column containing '999'
food_choices <- public_data |>
  filter_all(all_vars(. != 999))

# Add a new column named Switched
food_choices$Switched = ifelse(food_choices$grape == 0 & food_choices$grape2 == 1, "Cookie to Grape",
                               ifelse(food_choices$grape == 1 & food_choices$grape2 == 0, "Grape to Cookie", "Not Changed"))

# Add a new column named Stayed
food_choices$Stayed = ifelse(food_choices$grape == 0 & food_choices$grape2 == 0, "Stayed Cookie",
                               ifelse(food_choices$grape == 1 & food_choices$grape2 == 1, "Stayed Grape", "Changed"))

#the incentive_data_sum tibble will contain the selected columns from the original incentive_data dataset, with an additional state column representing the row names.
incentive_data_sum <-
  incentive_data |>
  as_tibble() |>
  mutate(state = rownames(incentive_data)) |>
  select(public, incentive, table_incentive_pr, table_size, male, black, grade, hispanic, free)

# Change all column contains '999' to NA
incentive_data_sum[incentive_data_sum == 999] <- NA

#---------

# Public-0-no incentive: Children in the public treatment in which none of the grape cards were incentivized.
public_0_no_incentive <- incentive_data_sum |>
  filter(public == 1 & table_incentive_pr == 0)

# Calculate mean values for each numeric column excluding NAs
#https://www.r-bloggers.com/2023/07/exploring-data-with-colmeans-in-r-a-programmers-guide/
mean_values <- colMeans(public_0_no_incentive, na.rm = TRUE)

# Round mean values to two decimal places
mean_values <- round(mean_values, 2)

# Get the total number of rows
total_rows <- nrow(public_0_no_incentive)

# Create a new data frame with the mean values and total rows
sum_table <- data.frame(
  Group = 'Public-0',
  Variable = names(mean_values),
  Mean = mean_values,
  Observations = total_rows
)
# Reshapes the data frame from long to wide format. This means it takes data that is currently represented in a tall, skinny format (with many rows and few columns) and spreads it out into a wide format (with fewer rows and more columns)
sum_table_wide <- pivot_wider(sum_table, names_from = "Variable", values_from = "Mean")

# ---------

# Public-50-no incentive: Children in the public treatment in which 50 percent of the grape cards were incentivized, and the child’s own card was not incentivized. 
public_50_no_incentive <- incentive_data_sum %>%
  filter(public == 1 & table_incentive_pr > 0 & table_incentive_pr < 1  & incentive == 0)

# Calculate mean values for each numeric column excluding NAs
mean_values <- colMeans(public_50_no_incentive, na.rm = TRUE)

# Round mean values to two decimal places
mean_values <- round(mean_values, 2)

# Get the total number of rows
total_rows <- nrow(public_50_no_incentive)

# Create a new data frame with the mean values and total rows
sum_table <- data.frame(
  Group = 'Public-50-no incentive',
  Variable = names(mean_values),
  Mean = mean_values,
  Observations = total_rows
)

# Reshapes the data frame from long to wide format. This means it takes data that is currently represented in a tall, skinny format (with many rows and few columns) and spreads it out into a wide format (with fewer rows and more columns)
sum_table <- pivot_wider(sum_table, names_from = "Variable", values_from = "Mean")

# Append sum_table to sum_table_wide
sum_table_wide <- rbind(sum_table_wide, sum_table)

#---------

# Public-50-incentive: Children in the public treatment in which 50 percent of the grape cards were incentivized, and the child’s own card was incentivized
Public_50_incentive <- incentive_data_sum %>%
  filter(public == 1 & table_incentive_pr > 0 & table_incentive_pr < 1  & incentive == 1)


# Calculate mean values for each numeric column excluding NAs
mean_values <- colMeans(Public_50_incentive, na.rm = TRUE)

# Round mean values to two decimal places
mean_values <- round(mean_values, 2)

# Get the total number of rows
total_rows <- nrow(Public_50_incentive)

# Create a new data frame with the mean values and total rows
sum_table <- data.frame(
  Group = 'Public-50-incentive',
  Variable = names(mean_values),
  Mean = mean_values,
  Observations = total_rows
)
# reshapes the data frame from long to wide format. This means it takes data that is currently represented in a tall, skinny format (with many rows and few columns) and spreads it out into a wide format (with fewer rows and more columns)
sum_table <- pivot_wider(sum_table, names_from = "Variable", values_from = "Mean")

# Append new_data to sum_table_wide
sum_table_wide <- rbind(sum_table_wide, sum_table)

#---------

# Public-100-incentive: Children in the public treatment in which all of the grape cards were incentivized.
Public_100_incentive <- incentive_data_sum %>%
  filter(public == 1 & table_incentive_pr == 1 & incentive == 1)

# Calculate mean values for each numeric column excluding NAs
mean_values <- colMeans(Public_100_incentive, na.rm = TRUE)

# Round mean values to two decimal places
mean_values <- round(mean_values, 2)

# Get the total number of rows
total_rows <- nrow(Public_100_incentive)

# Create a new data frame with the mean values and total rows
sum_table <- data.frame(
  Group = 'Public-100-incentive',
  Variable = names(mean_values),
  Mean = mean_values,
  Observations = total_rows
)
#reshapes the data frame from long to wide format. This means it takes data that is currently represented in a tall, skinny format (with many rows and few columns) and spreads it out into a wide format (with fewer rows and more columns)
sum_table <- pivot_wider(sum_table, names_from = "Variable", values_from = "Mean")

# Append new_data to sum_table_wide
sum_table_wide <- rbind(sum_table_wide, sum_table)

#----------

# Combining data frames that have the same columns and represent different subsets of the same dataset, allowing for easier analysis and comparison.
combined_table <- rbind(public_0_no_incentive, public_50_no_incentive, Public_50_incentive, Public_100_incentive)

# calculates the column means of the combined_table data frame using the colMeans() function.
mean_values <- colMeans(combined_table, na.rm = TRUE)

# Round mean values to two decimal places
mean_values <- round(mean_values, 2)

# Get the total number of rows
total_rows <- nrow(combined_table)

# Create a new data frame with the mean values and total rows
sum_table <- data.frame(
  Group = 'Total',
  Variable = names(mean_values),
  Mean = mean_values,
  Observations = total_rows
)
#  Reshape the sum_table data frame from long to wide format. 
sum_table <- pivot_wider(sum_table, names_from = "Variable", values_from = "Mean")

# Append new_data to sum_table_wide
sum_table_wide <- rbind(sum_table_wide, sum_table) 

#### Save data ####
write_csv(
  x = sum_table_wide,
  file = "outputs/data/sum_table_wide.csv"
)

write_csv(
  x = food_choices,
  file = "outputs/data/food_choices.csv"
)