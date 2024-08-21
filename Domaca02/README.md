# Domača Naloga 2 - Porazdelitvena funkcija normalne slučajne spremenljivke in Gauss-Legendrove kvadrature

##### Avtor: Timotej Šalamon

## Opis naloge
### Naloge s funkcijami: Porazdelitvena funkcija normalne slučajne spremenljivke
V prvem delu naloge želimo napisati učinkovito funkcijo za izračun vrednosti porazdelitvene funkcije za standardno normalno porazdeljeno standardno slučajno spremenljivko. ```X ∼ N[0, 1]```.

Definiral sem tri različne funkcije, ki izračunajo približek s pomočjo sestavljene Simpsonove metode. Prva funkcija vrne vrednost gostote porazdelitve standardne normalne slučajne spremenljivke. Druga izračuna sestavljeno Simpsonovo pravilo. Tretja pa izračuna končno `Φ(x)` za standardno normalno porazdelitev.

### Naloge s števili: Gauss-Legendrove kvadrature
V drugem delu naloge se ukvarjamo z izpeljavo Gauss-Legendreovega pravila za numerično integracijo. 

V prvem koraku sem zapisal funkcijo za izračun Gauss-Legendrove kvadrature na dveh točkah. Glavni del te naloge je izpeljati sestavljeno pravilo za integracijo. To je naloga funkcije ```gaussLegendre(f, a, b, n)```. Na koncu pa izračunam še približek za dejanski primer integrala in število izračunov, ki jih moramo opraviti da dosežemo željeno natančnost.

## Uporaba kode
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo naslednje ukaze:
    1. ```activate Domaca02```
    2. ```add Distributions```
    3. ```add Plots```
    4. ```add Test```
    5. ```add QuadGK```
3. Nato lahko v Julia terminalu poganjamo posamezne vrstice kode (v Visual Studio Code s stiskom na Shift+Enter na vrstici ki jo želimo izvesti).

## Poganjanje testov
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo naslednje ukaze:
    1. ```activate Domaca02```
    2. ```test```
3. Testi se izvedejo

## Generiranje poročila
1. V terminalu zaženemo Julio
2. Pritisnemo "]" in izvedemo: 
    1. ```activate Domaca02```
    2. ```add Weave```
3. Pritisnemo "Backspace", da gremo iz pkg
4. Izvedemo naslednje ukaze:
    1. ```cd("Domaca02\\scripts")```
    2. ```include("makedocs.jl")```
5. Ustvari se poročilo z imenom "demo.pdf"