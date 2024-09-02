# Domača Naloga 3 - Matematično nihalo

##### Avtor: Timotej Šalamon

## Opis naloge
V nalogi želimo čim bolj natančno modelirati matematično nihalo pri nedušenem nihanju. Za računanje kotnega odmika nitnega nihala uporabimo z diferencialno enačbo, ki jo pretvorimo v enačbo prvega reda in rešimo z uporabo metode Runge-Kutta 4. reda. Primerjamo še nihanje z nihanjem harmoničnega nihala in opazujemo kako se spreminja nihajni čas v odvisnosti od energije.

## Uporaba kode
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo naslednje ukaze:
    1. ```activate Domaca03```
    2. ```add Plots```
    3. ```add Test```
3. Nato lahko v Julia terminalu poganjamo posamezne vrstice kode (v Visual Studio Code s stiskom na Shift+Enter na vrstici ki jo želimo izvesti).

## Poganjanje testov
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo naslednje ukaze:
    1. ```activate Domaca03```
    2. ```test```
3. Testi se izvedejo

## Generiranje poročila
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo: 
    1. ```activate Domaca03```
    2. ```add Weave```
3. Pritisnemo "Backspace", da gremo iz pkg
4. Izvedemo naslednje ukaze:
    1. ```cd("Domaca03\\scripts")```
    2. ```include("makedocs.jl")```
5. Ustvari se poročilo z imenom "demo.pdf"