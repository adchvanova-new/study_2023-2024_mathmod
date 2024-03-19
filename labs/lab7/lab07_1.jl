using Plots
using DifferentialEquations

N=1304
n0=10

function func1(du,u,p,t)
	(n)=u
	du[1]= (0.76 + 0.000016*u[1])*(N-u[1])
end

v0=[n0]
interval=(0.0,30.0)
problem=ODEProblem(func1,v0,interval)
solution=solve(problem,dtmax=0.05)
n=[u[1] for u in solution.u]
T=[t for t in solution.t]


plt = plot(
  dpi = 600,
  title = "Эффективность распространения рекламы мод.1 ",
  legend = false)
plot!(
  plt,
  T,
  n,
  color = :red) 
savefig(plt, "lab07_1.png")