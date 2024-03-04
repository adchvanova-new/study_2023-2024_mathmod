using Plots
using DifferentialEquations

x0=9
y0=30

a=0.34
b=0.051
c=0.33
d=0.031

function func1(du,u,p,t)
	x,y=u
	du[1]=-a*u[1] +b*u[1]*u[2]
	du[2]=c*u[2] -d*u[1]*u[2]
end

v0=[x0,y0]	
interval = (0.0,60.0)
problem=ODEProblem(func1, v0, interval)
solution=solve(problem,dtmax=0.05)

X=[u[1] for u in solution.u]
Y=[u[2] for u in solution.u]
T=[t for t in solution.t]
plt = plot(
  dpi=300,
  legend=false)

plot!(
  plt,
  X,
  Y,
  color=:blue)

savefig(plt, "lab05_1.png")

plt2 = plot(
  dpi=300,
  legend=true)

plot!(
  plt2,
  T,
  X,
  label="Численность жертв",
  color=:red)

plot!(
  plt2,
  T,
  Y,
  label="Численность хищников",
  color=:green)

savefig(plt2, "lab05_2.png")

