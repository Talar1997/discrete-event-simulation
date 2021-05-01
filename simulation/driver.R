# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021
library(simmer)

driver <- function(alias, gates, proceed_time, standard_deviation) {
  return(
    trajectory("Drivers' path") %>%
      log_(paste(alias, "driver has arrived")) %>%
      select(gates, policy = "shortest-queue") %>%
      seize_selected() %>%
      timeout(function()rnorm(1, proceed_time, standard_deviation)) %>%
      release_selected() %>%
      log_(paste(alias, "driver drove away"))
  )
}

