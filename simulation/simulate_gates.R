# Title     : Discrete events simulation
# Objective : -
# Created by: Adam Talarczyk, Mateusz Wrzol
# Created on: 01.05.2021

# ilość aut na minute (z tego co widzę to najbardziej pasuje
# dokladać tu co pół auta na minute czyli najpierw 0.5 auta na minute, 1 auto na minute, 15 auta itd.)
# Wtedy widać jak wydłuża się średni czas oczekiwania
# trzeba pamiętać, że kierowców płacących kartą i gotówką puszczamy nie zależnie czyli
# traffic_param = 0.5 oznacza de facto 1 kierowce na minute,traffic_param = 1.5 oznacza 3 kierowców na minute łącznie itd.
# Myślę, że spoko będzie pokazać, że od pewnej wartości sredni
# czas oczekiwania nie wzrasta już (np jak wszyscy kierowcy przyjadą
# w ciągu minuty lub dwóch)
simulate_gates <- function(cars_per_minute = 2,
                           cash_drivers_trajectory,
                           card_drivers_trajectory,
                           card_drivers_num,
                           cash_drivers_num) {
  gates <-
    simmer("gates") %>%
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