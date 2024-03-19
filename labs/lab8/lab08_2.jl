using Plots
using DifferentialEquations

kr=48
t1=34
t2=28
p1=9.8
p2=11.8
N=50
q=1

a1 = kr / (t1 * t1 * p1 * p1 * N * q)
a2 = kr / (t2 * t2 * p2 * p2 * N *q)
b = kr / (t1 * t1 * t2 * t2 * p1 * p1 * p2 * p2 * N * q)
c1 = (kr - p1) / (t1 * p1)
c2 = (kr - p2) / (t2 * p2)


function func2(du, u, p, t)
    M1, M2 = u
    du[1] = u[1] - (b / c1 + 0.00043)*u[1] * u[2] - a1 / c1*u[1] * u[1]
    du[2] = c2 / c1*u[2] - b / c1*u[1] * u[2] - a2 / c1*u[2] * u[2]
end

v0= [7.8,9.8]
interval=(0.0,30.0)
problem=ODEProblem(func2,v0,interval)
solution=solve(problem,dtmax=0.05)
M1=[u[1] for u in solution.u]
M2=[u[2] for u in solution.u]
T=[t for t in solution.t]

plt = plot(
  dpi = 600,
  legend = :topright)

plot!(plt, T, M1, label = "Оборотные средства фирмы #1", color = :green)

plot!(plt, T, M2, label = "Оборотные средства фирмы #2", color = :red)

savefig(plt, "lab08_2.png")