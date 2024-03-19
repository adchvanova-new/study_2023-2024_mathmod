using Plots
using DifferentialEquations

N = 1304
n0 = 10

function func2(du, u, p, t)
    (n) = u
    du[1] = (0.000016 + 0.6*u[1])*(N - u[1])
end

v0 = [n0]
interval= (0.0, 0.1)
problem = ODEProblem(func2, v0, interval)
solution = solve(problem)
n = [u[1] for u in solution.u]
T = [t for t in solution.t]

max_dn = 0;
max_dn_t = 0;
max_dn_n = 0;
for (i, t) in enumerate(T)
    if solution(t, Val{1})[1] > max_dn
        global max_dn = solution(t, Val{1})[1]
        global max_dn_t = t
        global max_dn_n = n[i]
    end
end

plt = plot(
  dpi = 600,
  title = "Эффективность распространения рекламы мод.2 ",
  legend = false)
plot!(
  plt,
  T,
  n,
  color = :red)
plot!(
  plt,
  [max_dn_t],
  [max_dn_n],
  seriestype = :scatter,
  color = :red)

savefig(plt, "lab07_2.png")