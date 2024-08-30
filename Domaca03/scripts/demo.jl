#' # DN3: Matematično nihalo
#' Avtor: Timotej Šalamon

#' V nalogi želimo čim bolj natančno modelirati matematično nihalo pri nedušenem nihanju. Kotni odmik Φ(t) (v radianih)
#' nitnega nihala opišemo z diferencialno enačbo
#' $$
#'  \frac{g}{l}sin(Φ(t)) + Φ''(t) = 0, Φ(0) = Φ_0, Φ'(0) = Φ'_0
#' $$
#' kjer je g = 9.80665 $m/s^2$ težni pospešek in l dolžina nihala.
#' Enačbo pretvorim iz drugega reda v prevega in ga rešim s pomočjo metode Runge-Kutta 4. reda:
#' $$
#' k_1 = hf(x_n, y_n) \\
#' k_2 = hf(x_n + \frac{h}{2}, y_n + \frac{k_1}{2}) \\
#' k_3 = hf(x_n + \frac{h}{2}, y_n + \frac{k_2}{2}) \\
#' k_2 = hf(x_n + h, y_n + k_3) \\
#' y_n+1 = y_n + (k_1 + 2k_2 + 2k_3 + k_4) / 6
#' $$

using Domaca03, Plots

#' Določimo dolžino nihala, začetni odmik, začetno kotno hitrost in število podintervalov
l = 1.0
theta0 = 0.1
dtheta0 = 0.1
n = 100
thetaRange = 1:0.1:50

#' Izačunamo odmik pri θ = 1.0
odmik = nihalo(l, thetaRange[1], theta0, dtheta0, n)

#' Izrišemo nihanje.
plot([nihalo(l, t, theta0, dtheta0, n) for t in thetaRange], title="Matematično nihalo", label="Matematično nihalo")

#' Dobljeno matematično nihalo lahko primerjamo s harmoničnim. Opazimo, da matematično nihalo s
#' časom zaradi izgubljanja energije niha vedno manj.
plot!([harmOsc(l, t, theta0, n) for t in thetaRange], title="Matematično vs Harmonično nihalo", label="Harmonicno nihalo")

#' Poglejmo nihanje za različne dolžine nihala
thetaRange = 1:0.1:120
plot([nihalo(3, t, theta0, dtheta0, n) for t in thetaRange], title="Primerjava različnih dolžin nihala", label="l = 3")
plot!([nihalo(5, t, theta0, dtheta0, n) for t in thetaRange], label="l = 5")

#' Poglejmo še kako je nihajni čas odvisen od začetnega kota.
thetaRange = 0.1:0.1:1.5
T = nihajniCas(thetaRange, 1)
plot(thetaRange, T, xlabel="Začetni kot (rad)", ylabel="Nihajni čas (s)", title="Nihajni čas v odvisnosti od začetnega kota")

#' Poglejmo še kako se spreminja nihalni čas z energijo nihala.
#' Primerjamo lahko spremembno nihajnega časa za različne mase nihala.
l = 1
function energija(theta0, l, m)
    g = 9.80665
    E = m * g * l * (1 - cos(theta0))
    return E
end

thetaRange = range(0.0, pi/4, 100)
nihajniCasi = nihajniCas(thetaRange, l)
energije = [energija(theta, l, 1) for theta in thetaRange]
plot(energije, nihajniCasi, xlabel="Energija (J)", ylabel="Nihajni čas (s)", title="Nihajni čas v odvisnosti od energije nihala", label="m = 1")

energije = [energija(theta, l, 2) for theta in thetaRange]
plot!(energije, nihajniCasi, label="m = 2")
