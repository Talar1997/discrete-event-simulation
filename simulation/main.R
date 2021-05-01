# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021

library(simmer)

source('simulation/driver.R')
source('simulation/simulate_gates.R')

all_gates <- c("gate1", "gate2", "gate3", "gate4")
only_cash_gates <- c("gate2", "gate3", "gate4")

cash_drivers_trajectory <- driver("CASH", only_cash_gates, 1, 2)
card_drivers_trajectory <- driver("CARD", all_gates, 2, 2)

for (i in seq(20, 40, by = 10))
{
  result <- simulate_gates(cars_per_minute = 2,
                 cash_drivers_trajectory,
                 card_drivers_trajectory,
                 cash_drivers_num = i,
                 card_drivers_num = i)

  # TODO: export results to .xlsx
  print(paste("### Avarage time for", sum(result$finished), "drivers:", mean(result$waiting_time), "minutes"))

}