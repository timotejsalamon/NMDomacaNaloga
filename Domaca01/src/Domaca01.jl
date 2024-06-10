module Domaca01
using LinearAlgebra, Domaca01, Plots

"""
    A = (V, I)

Za razpršene matrike definiramo novo strukturo RazprsenaMatrika, ki je hranjena v matrikah `V` in `I`.
Matrika zaradi prostorskih zahtev hrani vrednosti v matrikah `V` in `I`, velikosti n x m. Pri tem velja:
`V(i,j) = A(i, I(i, j))`.
"""
struct RazprsenaMatrika
    V
    I
end

"""
    ix = getIndex(A, i, j)

Vrne vrednost, ki se v matriki `A` nahaja na mestu `i, j`.
"""
function getIndex(A::RazprsenaMatrika, i, j)
    idx = findfirst(isequal(j), A.I[i])
    return idx === nothing ? 0.0 : A.V[i][idx]
end
Base.getindex(A::RazprsenaMatrika, i, j) = getIndex(A, i, j)

"""
    ix = setIndex(A, x, i, j)

Na mesto `i, j` v matriki `A` vnese vrednost `x`.
"""
function setIndex(A::RazprsenaMatrika, i, j, e)
    idx = findfirst(isequal(j), A.I[i])
    if idx === nothing
        ix = searchsortedlast(A.I[i], j)
        insert!(A.I[i], ix + 1, j)
        insert!(A.V[i], ix + 1, e)
    else
        A.V[i][idx] = e
    end
end
Base.setindex!(A::RazprsenaMatrika, e, i, j) = setIndex(A, i, j, e)

"""
    first = firstIndex(A, i)

Vrne prvo vrednost v matriki `A`.
"""
function firstIndex(A::RazprsenaMatrika, i)
    return A.I[i][1]
end
Base.firstindex(A::RazprsenaMatrika, i) = firstIndex(A, i)


"""
    first = lastIndex(A, i)

Vrne zanjo vrednost v matriki `A`.
"""
function lastIndex(A::RazprsenaMatrika, i)
    return A.I[i][end]
end
Base.lastindex(A::RazprsenaMatrika, i) = lastIndex(A, i)

"""
    b = A  * x

Izvede množenje matrike `A` in vektorja `x` iz desne.
"""
function Base.:*(A::RazprsenaMatrika, x)
    n = length(A.V)
    b = zeros(Float64, n)

    for i in 1:n
        for (j, idx) in enumerate(A.I[i])
            b[i] += A.V[i][j] * x[idx]
        end
    end
    return b
end


"""
    x, iter = SOR(A, b, x0, omega, tol)

Izračunaj vrednost `x` in število iteracij `iter` za matriko A s SOR iteracijo.
Pri tem podamo vektor `b`, začetni približek `x0`, parameter SOR iteracije `omega` in
pogoj za zaključek `tol`. Nekatere vrednosti omege ne konvergirajo vedno, zato je število
iteracija omejeno na 1000.
"""
function SOR(A::RazprsenaMatrika, b, x0, omega, tol=1e-10)
    n = length(b)
    x = copy(x0)

    iter = 0

    while true
        x_old = copy(x)
        for i in 1:n
            sum1 = 0.0
            sum2 = 0.0

            for j in A.I[i]
                if j < i
                    sum1 += A[i, j] * x[j]
                elseif j > i
                    sum2 += A[i, j] * x_old[j]
                end
            end

            x[i] = (1 - omega) * x_old[i] + (omega / A[i, i]) * (b[i] - sum1 - sum2)
        end

        iter += 1

        if maximum(abs.(A * x - b)) <= tol
            break
        end

        if iter >= 1000
            break
        end
    end

    return x, iter
end

"""
    A = ustvariRazsprsenoMatriko(vozlisca, robovi, vrednosti)

Ustvari in vrne razpršeno matriko `A` iz podanih vozlišč, povezav in vrednosti
grafa.
"""
function ustvariRazsprsenoMatriko(vozlisca, robovi, vrednosti)
    n = length(vozlisca)
    V = Vector{Vector{Float64}}(undef, n)
    I = Vector{Vector{Int}}(undef, n)
    
    for i in 1:n
        V[i] = Float64[]
        I[i] = Int[]
    end
    
    m = length(robovi)
    for k in 1:m
        i, j = robovi[k]
        v = vrednosti[k]
        push!(V[i], v)
        push!(I[i], j)
    end
    
    return RazprsenaMatrika(V, I)
end

"""
    grafOmeg, minStIteracij, optimalniOmega, minX = optimalnaOmega(A, b, x0, stGrafa)

Poišče in vrne optimalno vrednost `omega`, ki vodi do najhitrejše konvergence SOR 
iteracije. Prav tako vrne tudi graf, število iteracij in rezultat SOR iteracije 
pri optimalni omegi.
Pri tem izvede SOR iteracijo za 20 vrednosti med 0.0 in 2.0.
"""
function optimalnaOmega(A::RazprsenaMatrika, b, x0, stGrafa)
    omege = range(0, stop=2.0, length=20)
    stIteracij = Float64[]
    xValues = Vector{Vector{Float64}}()

    for omega in omege
        x, iter = SOR(A, b, x0, omega)
        push!(stIteracij, iter)
        push!(xValues, x)
    end

    minIteracij, minIx = findmin(stIteracij)
    minOmega = omege[minIx]
    minX = xValues[minIx]

    if (stGrafa == 1)
        return scatter(omege, stIteracij, xlabel="Omega", ylabel="Število iteracij",
                       label="Primer $stGrafa", title="Odvisnost hitrosti konvergence od vrednosti omege"), minIteracij, minOmega, minX
    end
    return scatter!(omege, stIteracij, label="Primer $stGrafa"), minIteracij, minOmega, minX
end

export RazprsenaMatrika, getIndex, setIndex, firstIndex, lastIndex, SOR, ustvariRazsprsenoMatriko, optimalnaOmega

end # module Domaca01
