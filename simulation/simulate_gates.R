# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021

simulate_gates <- function(cars_per_minute = 2,
                           cash_drivers_trajectory,
                           card_drivers_trajectory,
                           card_drivers_num,
                           cash_drivers_num) {
  gates <- simmer("gates") %>%
    add_resource("gate1", 1) %>%
    add_resource("gate2", 1) %>%
    add_resource("gate3", 1) %>%
    add_resource("gate4", 1) %>%
    add_generator("CASH event ",
                  cash_drivers_trajectory,
                  function() { c(0, rexp(cash_drivers_num - 1, cars_per_minute), -1) }) %>%
    add_generator("CARD event ",
                  card_drivers_trajectory,
                  function() { c(0, rexp(card_drivers_num - 1, cars_per_minute), -1) })

  gates %>% run(until = 2000)

  return(
    result <- gates %>%
      get_mon_arrivals() %>%
      transform(waiting_time = end_time - start_time - activity_time)
  )
}