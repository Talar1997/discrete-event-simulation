# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021

library(simmer)
library("xlsx")

source('simulation/driver.R')
source('simulation/simulate_gates.R')

gates_for_card_drivers <- c("gate1", "gate2", "gate3", "gate4")
gates_for_cash_drivers <- c("gate2", "gate3", "gate4")

cash_drivers_trajectory <- driver("CASH", gates_for_cash_drivers, 3, 2)
card_drivers_trajectory <- driver("CARD", gates_for_card_drivers, 2, 1)

results <- data.frame("drivers", "lambda", "avg_waiting_time", "avg_activity_time")

for (j in seq(1, 10, by = 1)) {
  cars_per_minute <- j
  drivers <- 50
  for (i in seq(1, 10, by = 1))
  {
    result <- simulate_gates(cars_per_minute,
      cash_drivers_trajectory,
      card_drivers_trajectory,
      cash_drivers_num = drivers,
      card_drivers_num = drivers)

    results <- rbind(results, c(sum(result$finished), cars_per_minute, mean(result$waiting_time), mean(result$activity_time)))
    print(paste("Avg time for", sum(result$finished), "drivers:", mean(result$waiting_time), "minutes"))
  }
}

export_dataset <- function(dataset) {
  write.xlsx(dataset, file = "simulation/export/data.xlsx", sheetName = "discrete_events")
}

export_dataset(results)
