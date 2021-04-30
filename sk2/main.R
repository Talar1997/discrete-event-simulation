library(simmer)
driverCash <- trajectory("Drivers's path") %>%
    log_("Przyjeżdżam GOTÓWKA") %>%
    select(c("gate2", "gate3", "gate4"), policy = "shortest-queue") %>%
# kierowca gotówkowy wybiera spośród 3 bramek (wybiera tam gdzie najmniejsza kolejka)
seize_selected() %>% #Zajmuje stanowisko gdy jest wolne
timeout(function()rnorm(1, 2, 2)) %>%
# kierowca średnio płaci przez 15 minut, odchylenie standardowe 2
release_selected() %>% #kierowca zwalnia stanowisko i odjeżdża
log_("odjeżdżam GOTÓWKA")
driverCard <-
trajectory("Drivers's path") %>%
log_("Przyjeżdżam KARTA") %>%
select(c("gate1", "gate2", "gate3", "gate4"), policy =
"shortest-queue") %>%
seize_selected() %>%
timeout(function()rnorm(1, 1, 2)) %>%
release_selected() %>%
log_("odjeżdżam KARTA")
traffic_param = 2
# ilość aut na minute (z tego co widzę to najbardziej pasuje
# dokladać tu co pół auta na minute czyli najpierw 0.5 auta na minute, 1 auto na minute, 15 auta itd.)
# Wtedy widać jak wydłuża się średni czas oczekiwania
# trzeba pamiętać, że kierowców płacących kartą i gotówką puszczamy nie zależnie czyli
# traffic_param = 0.5 oznacza de facto 1 kierowce na minute,traffic_param = 1.5 oznacza 3 kierowców na minute łącznie itd.
# Myślę, że spoko będzie pokazać, że od pewnej wartości sredni
# czas oczekiwania nie wzrasta już (np jak wszyscy kierowcy przyjadą
# w ciągu minuty lub dwóch)
gates <-
simmer("gates") %>%
add_resource("gate1", 1) %>%
add_resource("gate2", 1) %>%
add_resource("gate3", 1) %>%
add_resource("gate4", 1) %>%
add_generator("Driver with cash", driverCash, function() {c(0,
rexp(29, traffic_param), -1)}) %>% # 30 kierowców płacącychgotówką
add_generator("Driver with card", driverCard, function() {c(0,
rexp(29, traffic_param), -1)}) # 30 kierowców płacących kartą
gates %>% run(until = 2000)
result <- gates %>%
get_mon_arrivals() %>%
transform(waiting_time = end_time - start_time - activity_time)
paste("Średni czas oczekiwania dla ", sum(result$finished), "
kierowców wyniósł ", mean(result$waiting_time), "minut.")
