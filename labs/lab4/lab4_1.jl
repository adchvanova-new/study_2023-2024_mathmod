#case № 1
# x'' + 1.9x = 0
using DifferentialEquations

function func1!(du, u, p, t)
	a=p
	du[1]=u[2]
	du[2]=-a*u[1]
end
const x = 1.9
const y = 0.9
u0= [x,y]
p=(1.9)
interval =(0.0, 49.0)
problem1= ODEProblem(func1!, u0, interval, p)
solution= solve(problem1,dtmax=0.05)
using Plots; gr()

plot(solution)
savefig("lab4_case1_julia.png")

plot(solution, vars=(2,1))
savefig("lab4_case1_phase_julia.png")


