using Plots
using DifferentialEquations

a=0.34
b=0.051
c=0.33
d=0.031

x0 = c / d 
y0 = a / b 

function func2(du, u, p, t)
    x, y = u
    du[1] = -a*u[1] + b * u[1] * u[2]
    du[2] = c * u[2] - d * u[1] * u[2]
end

v0 = [x0, y0]
interval = (0.0, 60.0)
problem = ODEProblem(func2, v0, interval) 
solution = solve(problem, dtmax=0.05)
X = [u[1] for u in solution.u]
Y = [u[2] for u in solution.u]
T = [t for t in solution.t]

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

savefig(plt2, "lab05_3.png")