using Plots
using DifferentialEquations

function model1(du, u, p, t)
	du[1]= -0.336*u[1] - 0.877*u[2] + sin(t+1) + 1
	du[2]= -0.441*u[1] - 0.232*u[2] + cos(t+2) + 1

end

function model2(du, u, p, t)
	du[1]= -0.432*u[1] - 0.815*u[2] + sin(2*t) + 2
	du[2]= -0.336*u[1]*u[2] - 0.245*u[2] + cos(t) + 2

end

const mans = Float64[321000, 123000]
const prom1 = [0.0, 3.0]
const prom2 = [0.0, 0.0007]

prob1 = ODEProblem(model1, mans, prom1)
prob2 = ODEProblem(model2, mans, prom2)

sol1 = solve(prob1, dtmax=0.1)
sol2 = solve(prob2, dtmax=0.000001)

A1= [u[1] for u in sol1.u]
A2= [u[2] for u in sol1.u]

A3= [u[1] for u in sol2.u]
A4= [u[2] for u in sol2.u]

T1= [t for t in sol1.t]
T2= [t for t in sol2.t]

plt1 = plot(dpi = 300, legend = true, bg =:white)
plot!(plt1, xlabel="Время", ylabel="Численность", title="Модель боевых действий случай 1")
plot!(plt1, T1, A1, label="Численность армии X", color =:red)
plot!(plt1, T1, A2, label="Численность армии Y", color =:green)
savefig(plt1, "lab3_1.png")

plt2 = plot(dpi = 1200, legend = true, bg =:white)
plot!(plt2, xlabel="Время", ylabel="Численность", title="Модель боевых действий случай 2")
plot!(plt2, T2, A3, label="Численность армии X", color =:red)
plot!(plt2, T2, A4, label="Численность армии Y", color =:green)
savefig(plt2, "lab3_2.png")