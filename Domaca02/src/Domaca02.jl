module Domaca02

"""
    por = normalPorGost(x)

Vrne vrednost gostote porazdelitve standardne normalne slučajne spremenljivke.
"""
function normalPorGost(x)
    return exp(-x^2 / 2) / sqrt(2 * pi)
end

"""
    simpson = simpsonovoPravilo(f, a, b, n)

Uporabimo Simpsonovo pravilo za numerično integracijo. Uporabimo vhodno funkcijo `f`
s krajišči `a` in `b`. Interval med `a` in `b` je razdeljen na `n` delov (katerih
število mora biti sodo).
"""
function simpsonovoPravilo(f, a, b, n)
    if n % 2 != 0
        error("n mora biti sodo število!")
    end

    h = (b - a) / n
    s = f(a) + f(b)

    for i in 1:2:(n-1)
        s += 4 * f(a + i * h)
    end
    for i in 2:2:(n-2)
        s += 2 * f(a + i * h)
    end
    simpson = s * h / 3
    return simpson
end

"""
    porazdelitev = normalPorazd(x, tol=1e-10)

Izračunamo `Φ(x)` za standardno normalno porazdelitev z uporabo Simpsonove metode.
V primeru, ko je `x` zelo negativen vrnemo 0, saj je rezultat praktično 0. V primeru,
ko pa je `x` zelo pozitiven pa vrnemo 1.
"""

function normalPor(x, tol=1e-10)
    if x < -10
        return 0.0
    end
    if x > 10
        return 1.0
    end

    a = -10.0
    b = x
    n = 2

    prevIntegral = 0.0
    integral = simpsonovoPravilo(normalPorGost, a, b, n)

    while abs(integral - prevIntegral) > tol
        n *= 2
        prevIntegral = integral
        integral = simpsonovoPravilo(normalPorGost, a, b, n)
    end

    return integral

end

"""
    gl2p = gaussLegendre2P(f, a, b)

Izračunamo Gauss-Legendreovo pravilo za dve točki. Sprejmemo funkcijo `f` in interval 
[a, b] na katerem računamo integral.
"""
function gaussLegendre2P(f, a, b)
    x1, x2 = -1 / sqrt(3), 1 / sqrt(3)
    w1, w2 = 1.0, 1.0

    t1 = 0.5 * (b - a) * x1 + 0.5 * (b + a)
    t2 = 0.5 * (b - a) * x2 + 0.5 * (b + a)

    gl2p = 0.5 * (b - a) * (w1 * f(t1) + w2 * f(t2))

    return gl2p
end

"""
    gl = gaussLegendre(f, a, b, n)

Izračunamo sestavljeno Gauss-Legendreovo pravilo za funkcijo `f` na intervalu [a, b],
ki je razdeljen na `n` delov.
"""
function gaussLegendre(f, a, b, n)
    h = (b - a) / n
    gl = 0.0

    for i in 0:n-1
        xi = a + i * h
        xiNext = xi + h
        gl += gaussLegendre2P(f, xi, xiNext)
    end
    return gl
end


"""
    res, stIzracunov = primerGL()

Preverimo funkcijo gaussLegendre in funkcio `sin(x)/x` integriramo na intervalu 
med 0 in 5. Vrnemo rezultat integriranja in število izračunov funkcijske vrednosti, 
da dosežemo integral na 10 decimalk natančno. 
"""
function primerGL()
    f(x) = sin(x) / x
    a, b = 0.0, 5.0
    n = 10
    tol = 1e-10

    integral = gaussLegendre(f, a, b, n)
    
    while true
        n *= 2
        integralNew = gaussLegendre(f, a, b, n)
        if abs(integralNew - integral) < tol
            break
        end
        integral = integralNew
    end

    stIzracunov = 2 * n
    
    return integral, stIzracunov
end

export normalPorGost, simpsonovoPravilo, normalPor, gaussLegendre2P, gaussLegendre, primerGL

end # module Domaca02
