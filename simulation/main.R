# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021

library(simmer)
library("xlsx")

source('simulation/driver.R')
source('simulation/simulate_gates.R')

all_gates <- c("gate1", "gate2", "gate3", "gate4")
only_cash_gates <- c("gate2", "gate3", "gate4")

cash_drivers_trajectory <- driver("CASH", only_cash_gates, 1, 2)
card_drivers_trajectory <- driver("CARD", all_gates, 2, 2)

export_dataset <- function(dataset) {
  write.xlsx(dataset, file = "simulation/export/data.xlsx", sheetName = "discrete_events")
}

results <- data.frame("drivers", "avg_waiting_time", "avg_activity_time")
for (i in seq(20, 100, by = 10))
{

  result <- simulate_gates(cars_per_minute = 2,
                           cash_drivers_trajectory,
                           card_drivers_trajectory,
                           cash_drivers_num = i,
                           card_drivers_num = i)
  results <- rbind(results, c(sum(result$finished), mean(result$waiting_time), mean(result$activity_time)))

  print(paste("### Avarage time for", sum(result$finished), "drivers:", mean(result$waiting_time), "minutes"))
}

export_dataset(results)
