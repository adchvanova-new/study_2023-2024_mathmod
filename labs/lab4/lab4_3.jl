#case 3
# x'' + 4.9x' + 5.9x = 6.9sin(7.9t)
using DifferentialEquations

function func3!(du, u, p, t)
    a, b = p
    du[1] = u[2]
    du[2] = -a*du[1] - b*u[1] + 6.9*sin(7.9*t)
end

const x = 1.9
const y = 0.9
u0 = [x, y]

p = (sqrt(4.9), 5.9)
interval = (0.0, 49.0)
problem3= ODEProblem(func3!, u0, interval, p)
solution= solve(problem3,dtmax=0.05)

using Plots; gr()

plot(solution)
savefig("lab4_case3_julia.png")

plot(solution, vars=(2,1))
savefig("lab4_case3_phase_julia.png")