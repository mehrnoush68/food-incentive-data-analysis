#### Preamble ####
# Purpose: Replicated graphs and tables from Incentives and Unintended Consequences: Spillover Effects in Food Choice by Angelucci, Manuela, Silvia Prina, Heather Royer, and Anya Samek
# Author: Samantha Barfoot, Mehrnoush Mohammadi, Brooklin Becker
# Date: 8 February 2024 
# Contact: samantha.barfoot@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the script 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(SemiPar)
library(knitr)
library(kableExtra)
library(janitor)

#### Load Data ####
incentive_data <-
  read_csv(
    file = "outputs/data/food_data.csv",
    show_col_types = FALSE,
  )

# Filter data for Figure 2 and 3
private_data <- incentive_data|>
  filter(private == 1)

public_data <- incentive_data|>
  filter(private == 0)

### Replicate Figure 2 ###
# To do: currently using Semipar library to replicate the semiparametic regression 
#       mentioned in the orignal paper; this could be tuned further to look more similar to the paper

pdf("outputs/paper/replications/Figure2.pdf")

attach(private_data)
fit_private_grape2 <- spm(grape2~f(table_incentive_pr), family = "gaussian", spar.method = "ML")
attach(public_data)
fit_public_grape2 <- spm(grape2~f(table_incentive_pr), family = "gaussian", spar.method = "ML")
plot.spm(fit_private_grape2, shade = FALSE, col = "lightgrey",se.col="lightgrey",
         xlab = "Proportion of children incentivized",
         ylab = "Final grapes take-up (G2)",
         lty = 2,
         se.lty = 1,
         add.legend = TRUE,
         leg.loc = c(0.5,0.5),
         ylim = c(0.4,0.9))
par(new = TRUE)
plot(fit_public_grape2, shade = FALSE, xlab = "", ylab = "",lty = 2,
     se.lty = 1,add.legend = TRUE,ylim = c(0.4,0.9))
legend(x = "topleft", legend = c("Private", "Public"), lty = c(2, 2),
       col = c("lightgrey", "black"),lwd = 2)

dev.off()

### Replicate Figure 3 ###
# To do: currently using Semipar library to replicate the semiparametic regression
#       mentioned in the orignal paper; this could be tuned further to look more similar to the paper

pdf("outputs/paper/replications/Figure3.pdf")

attach(private_data)
fit_private_grape <- spm(grape~f(table_incentive_pr), family = "gaussian", spar.method = "ML")
attach(public_data)
fit_public_grape <- spm(grape~f(table_incentive_pr), family = "gaussian", spar.method = "ML")
plot.spm(fit_private_grape, shade = FALSE, col = "lightgrey",se.col="lightgrey", 
         xlab = "Proportion of children incentivized",
         ylab = "Final grapes take-up (G1)",
         lty = 2,
         se.lty = 1,
         add.legend = TRUE,
         leg.loc = c(0.5,0.5),
         ylim = c(0.4,0.9))
par(new = TRUE)
plot(fit_public_grape, shade = FALSE, xlab = "", ylab = "",lty = 2,
     se.lty = 1,add.legend = TRUE, ylim = c(0.4,0.9))
legend(x = "topleft", legend = c("Private", "Public"), lty = c(2, 2), col = c("lightgrey", "black"), lwd = 2)


dev.off()

### Replicate Table 1 ###
# Uses a tibble to create a table 
table1 <- incentive_data |>
  tibble()|>
  select(table_incentive_pr,incentive) |>
  group_by(table_incentive_pr) |>
  summarise(not_incentivized = sum(1 - incentive),
            incentivized = sum(incentive))
table1 <- rbind(table1, c(10,colSums(table1[, 2:3])))

kable1 <- gsub("10.000", "TOTAL", kable(table1,
                col.names = c("Table proportion incentivized", 
                "Not incentivized", 
                "Incentivized"),
                digits = 3) |>
add_header_above(kable1,header = c("","Observations by child type" = 2))|>
  column_spec(1:3,width = "30mm")
)
