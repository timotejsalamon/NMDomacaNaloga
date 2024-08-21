#' # DN2: Porazdelitvena funkcija normalne slučajne spremenljivke in Gauss-Legendrove kvadrature
#' Avtor: Timotej Šalamon

#' ## Naloge s funkcijami: Porazdelitvena funkcija normalne slučajne spremenljivke

#' V prvem delu naloge se ukvarjamo s pisanjem učinkovite funkcije za izračun vrednosti
#' porazdelitvene funkcije za standardno normalno porazdeljeno standardno slučajno spremenljivko
#' $X ∼ N[0, 1]$.

#' Računamo torej:
#' $$
#' Φ(x) = P(X <= x) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{x} e^{-\frac{t^2}{2}} dt
#' $$

using Domaca02, Distributions, Plots

#' V nalogi je uporabljena sestavljenova Simpsonova metoda za numerično integracuijo.
#' Metoda interval $[a, b]$ razdeli na $n$ podintervalov in izračuna integral na vsakem podintervalu.
#' Integrira torej po formuli: 
#' $$
#' \int_a^b f(x) \approx \frac{1}{3} h (f(x_0) + 4f(x_1) + 2f(x_2) + 4f(x_3) + 2f(x_4) + \dots + 2f(x_{n-2}))
#' $$

#' Za funkcijo $f(x) = x$ izračunamo vrednost integrala s sestavljeno Simpsonovo metodo.
f(x) = x
a1, b1 = 0, 1
simpson = simpsonovoPravilo(f, a1, b1, 100)

#' Za tem lahko z uporabo Simposnove metode izračunamo še vrednosti porazdelitvene funkcije
#' za standardno normalno porazdeljeno slučajno spremenljivko
x = normalPor(0.0)

#' Sedaj lahko primerjamo rezultat dobljen z našo metodo in točen rezultat.
dist = Normal(0, 1)
xs = [-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
razlike = Float64[]

for x in xs
    res = normalPor(x)
    pricakovano = cdf(dist, x)  # Porazdelitvena funkcija iz Distributions.jl
    razlika = abs(res - pricakovano)
    push!(razlike, razlika)
end

plot(xs, razlike, label="Razlika", xlabel="x", 
    ylabel="Razlika", title="Razlike med točnim in izračunanim rezultatom")


#' ## Naloge s števili: Gauss-Legendrove kvadrature

#' V drugem delu naloge se ukvarjamo z izpeljavo Gauss-Legendreovega pravila za numerično integracijo.
#' Najprej ga izračunamo za dve točki po formuli:
#' $$
#' \int_a^b f(x) = A(f(x_1)) + B(f(x_2)) + R_f
#' $$
#' Za primer izračunajmo $\int_1^2 \sin((x))dx$ s pomočjo tega pravila.
f(x) = sin(x)
a, b = 1.0, 2.0
gaussLegendre2P(f, a, b)

#' Sedaj lahko izpeljemo še sestavljeno Gauss-Legendreovo pravilo, kjer moramo določiti
#' še število intervalov na katerega bo glavni interval [a, b] razdeljen. Izračun lahko
#' naredimo na enaki funkciji kot v prvem primeru, a interval razdelino na 10 delov.
n = 10
gaussLegendre(f, a, b, n)

#' Sestavljeno pravilo lahko sedaj uporabimo za izračun različnih funkcij. Za še en
#' primer lahko vzamemo izračun integrala:
#' $$
#' \int_0^5 \frac{sin(x)}{x}dx
#' $$
#' Ocenimo še koliko izračunov funkcijske vrednosti je potrebnih, da je izračun približka
#' integrala natančen na 10 decimalk.
rez, stKorakov = primerGL()

#' Dobimo rezultat:
rez

#' Dobimo število potrebnih korakov da dosežemo željeno natančnost:
stKorakov