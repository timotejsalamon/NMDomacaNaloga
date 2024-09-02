using Test, Domaca03

@testset "RK4" begin
    f(x, y) = y 
    x0 = 0.0
    y0 = 1.0
    h = 0.1
    y = y0
    for i in 1:10
        y = rk4(f, x0 + i * h, y, h)
    end
    @test isapprox(y, exp(1.0), atol=1e-5)
end

@testset "Sistem" begin
    g = 9.80665
    l = 1.0
    y = [0.1, 0.0]
    res = sistem(0.0, y, g, l)
    @test isapprox(res[1], 0.0, atol=1e-10)
    @test isapprox(res[2], -g/l * sin(0.1), atol=1e-10)
end

@testset "Nihalo" begin
    l = 1.0
    t = 2.0
    theta0 = 0.1
    dtheta0 = 0.0
    n = 100
    res = nihalo(l, t, theta0, dtheta0, n)
    @test isapprox(res, 0.1 * cos(sqrt(9.80665) * t), atol=1e-5)
end

@testset "Nihajni čas" begin
    thetaRange = [0.1, 0.2, 0.3]
    l = 1.0
    T = nihajniCas(thetaRange, l)
    pricakovan = [2 * pi * sqrt(l / 9.80665) * (1 + (1 / 16) * theta^2 + (11 / 3072) * theta^4) for theta in thetaRange]
    @test all(isapprox.(T, pricakovan, atol=1e-10))
end