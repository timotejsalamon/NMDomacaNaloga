module Domaca03

using Plots

"""
    rk4 = rk4(f, x, y, h)

Uporabimo funkcijo Runge-Kutta 4. reda za reševanje diferencialne enačbe na funkciji
`f` razdeljeno na `n` delov.
"""
function rk4(f, x, y, h)
    k1 = h * f(x, y)
    k2 = h * f(x + h / 2, y + k1 / 2)
    k3 = h * f(x + h / 2, y + k2 / 2)
    k4 = h * f(x + h, y + k3)
    y += (k1 + 2 * k2 + 2 * k3 + k4) / 6
    return y
end

"""
    sistem = sistem(x, y, g, l)

Definiramo sistem diferencialnih enačb za nihalo.
"""
function sistem(x, y, g, l)
    o1 = y[1]
    o2 = y[2]
    do1 = o2
    do2 = -(g / l) * sin(o1)
    return [do1, do2]
end

"""
    odmik = nihalo(l, t, theta0, dtheta0, n)

Izračunamo odmik nihala dolžine `l` pri času `t`. Nihalo ima začetni odmik `theta0` in
začetno kotno hitrost `dtheta0`. Interval [0, t] pa je razdeljen na `n` podintervalov
enake dolžine.
"""
function nihalo(l, t, theta0, dtheta0, n)
    g = 9.80665
    h = t / n

    f(x, y) = sistem(x, y, g, l)
    y = [theta0, dtheta0]

    for i in 1:n
        y = rk4(f, i * h, y, h)
    end
    return y[1]
end

"""
    harmOsc = harmOsc(l, t, theta0, dtheta0)

Izračunamo odmik harmoničnega nihala dolžine `l` pri času `t` z začetnim odmikom `theta0`
in začetno kotno hitrostjo `dtheta0`.
"""
function harmOsc(l, t, theta0, n)
    g = 9.80665
    h = t / n
    cT = 0.0
    HOsc = theta0

    for i in 1:n
        HOsc = theta0 * cos(cT * sqrt(g / l))
        cT += h
    end

    return HOsc
end

"""
    nihajniCas = nihajniCas(thetaRange, l)

Izračunamo nihajni čas za različne začetne kote `theta0` in dolžino `l`.
"""
function nihajniCas(thetaRange, l)
    g = 9.80665
    T = []

    for theta in thetaRange
        cas = 2 * pi * sqrt(l / g) * (1 + (1 / 16) * theta^2 + (11 / 3072) * theta^4)
        push!(T, cas)
    end
    return T
end

export rk4, sistem, nihalo, harmOsc, nihajniCas

end # module Domaca03
