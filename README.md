# simmer-simulation

## Zadanie 1
Wykonać symulację bramek autostradowych uwzględniając następujące założenia:
- Dostępne są cztery bramki. Na trzech bramkach kierowcy mogą płacić kartą i gotówką. Na jednej bramce kierowcy mogą płacić tylko kartą.
- Czas trwania obsługi na bramce w przypadku płatności gotówką jest opisany rozkładem normalnym o średniej M1 minuty i odchyleniu standardowym SD1 minuty.
- Czas trwania obsługi na bramce w przypadku płatności kartą jest opisany rozkładem normalnym o średniej M2 minuty i odchyleniu standardowym SD2 minuty.
- Odstęp czasu pomiędzy nadjeżdżającymi samochodami jest opisany rozkładem wykładniczym o parametrze lambda = L (wartość oczekiwana wynosi 1/L minuty, L odpowiada średniej liczbie pojazdów na minutę).
- Połowa kierowców zamierza dokonać płatności kartą a druga połowa gotówką. Nadjeżdżający kierowcy wybierają dostępną bramkę z najkrótszą kolejką. Płacący gotówką mają do wyboru 3 bramki. Płacący kartą wybierają spośród 4 bramek.

![Obrazek](https://i.imgur.com/XkYIgry.png)

Wartości parametrów SD1, SD2, M1 i M2 należy przyjąć według własnego uznania.

Wyznaczyć symulacyjnie zależność pomiędzy średnią liczbą pojazdów na minutę (L) i średnim czasem oczekiwania na przejazd przez bramki. Przedstawić tę zależność na wykresie.

W sprawozdaniu należy zamieścić treść zadania, kod źródłowy rozwiązania z opisem, wyniki symulacji i wykres.
