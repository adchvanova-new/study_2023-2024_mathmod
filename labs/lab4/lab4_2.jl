#case 2
# x'' + 2.9x' + 3.9x = 0
using DifferentialEquations

function func2!(du, u, p, t)
    a, b = p
    du[1] = u[2]
    du[2] = -a*du[1] - b*u[1] 
end

const x = 1.9
const y = 0.9
u0 = [x, y]

p = (sqrt(2.9), 3.9)
interval = (0.0, 49.0)
problem2= ODEProblem(func2!, u0, interval, p)
solution= solve(problem2,dtmax=0.05)

using Plots; gr()

plot(solution)
savefig("lab4_case2_julia.png")

plot(solution, vars=(2,1))
savefig("lab4_case2_phase_julia.png")