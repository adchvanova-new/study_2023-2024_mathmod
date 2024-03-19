using Plots
using DifferentialEquations

N = 1304
n0 = 10

function func3(du, u, p, t)
    (n) = u
    du[1] = (0.7*sin(7*t) + 0.7*sin(3*t)*u[1])*(N - u[1])
end

v0 = [n0]
interval = (0.0, 0.1)
problem = ODEProblem(func3, v0, interval)
solution = solve(problem, dtmax = 0.05)
n = [u[1] for u in solution.u]
T = [t for t in solution.t]

plt = plot(
  dpi = 600,
  title = "Эффективность распространения рекламы мод.3 ",
  legend = false)
plot!(
  plt,
  T,
  n,
  color = :red)

savefig(plt, "lab07_3.png")