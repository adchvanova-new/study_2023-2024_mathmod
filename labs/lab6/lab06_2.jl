using Plots
using DifferentialEquations

N= 6159
I0=173
R0=61
S0= N - I0 - R0

alpha= 0.1
beta=0.2

#I0 > I*
function func2(du, u, p, t)
    S, I, R = u
    du[1] = -alpha*u[1]
    du[2] = alpha*u[1] - beta*u[2]
    du[3] = beta*I
end

v0 = [S0, I0, R0]
interval = (0.0, 120.0)
problem = ODEProblem(func2, v0, interval)
solution = solve(problem, dtmax=0.05)
S = [u[1] for u in solution.u]
I = [u[2] for u in solution.u]
R = [u[3] for u in solution.u]
T = [t for t in solution.t]

plt = plot(
  dpi=600,
  legend=:right)

plot!(
  plt,
  T,
  S,
  label="Восприимчивые особи",
  color=:blue)
plot!(
  plt,
  T,
  I,
  label="Инфицированные особи",
  color=:red)
plot!(
  plt,
  T,
  R,
  label="Особи с иммунитетом",
  color=:green)


savefig(plt, "lab06_2.png")