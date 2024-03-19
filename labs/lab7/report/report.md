---
## Front matter
title: "Отчёт по лабораторной работе №7"
subtitle: "Модель распространения рекламы. Вариант 53 "
author: "Чванова Ангелина Дмитриевна"



## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Изучить и построить модель эффективности рекламы.

# Теоретическое введение. Построение математической модели.

Организуется рекламная кампания нового товара или услуги. Необходимо, чтобы прибыль будущих продаж с избытком покрывала издержки на рекламу. Вначале расходы могут превышать прибыль, поскольку лишь малая часть потенциальных покупателей будет информирована о новинке. Затем, при увеличении числа продаж, возрастает и прибыль, и, наконец, наступит момент, когда рынок насытиться, и рекламировать товар станет бесполезным.

Предположим, что торговыми учреждениями реализуется некоторая продукция, о которой в момент времени $t$ из числа потенциальных покупателей $N$ знает лишь $n$ покупателей. Для ускорения сбыта продукции запускается реклама по радио, телевидению и других средств массовой информации. После запуска рекламной кампании информация о продукции начнет распространяться среди потенциальных покупателей путем общения друг с другом. Таким образом, после запуска рекламных объявлений скорость изменения числа знающих о продукции людей пропорциональна как числу знающих о товаре покупателей, так и числу покупателей о нем не знающих

Модель рекламной кампании описывается следующими величинами.
Считаем, что $\frac{dn}{dt}$ - скорость изменения со временем числа потребителей, узнавших о товаре и готовых его купить,
$t$ - время, прошедшее с начала рекламной кампании,
$N$ - общее число потенциальных платежеспособных покупателей,
$n(t)$ - число  уже информированных клиентов.
Эта величина пропорциональна числу покупателей, еще не знающих о нем, это описывается следующим образом
$\alpha _1(t)(N-n(t))$, где $\alpha _1>0$ -  характеризует интенсивность рекламной кампании (зависит от затрат на рекламу в данный момент времени).
Помимо этого, узнавшие о товаре потребители также распространяют полученную информацию среди потенциальных покупателей, не знающих о нем (в этом случае работает т.н. сарафанное радио). Этот вклад в рекламу описывается величиной  $\alpha _2(t)n(t)(N-n(t))$. эта величина увеличивается с увеличением потребителей узнавших о товаре.

Математическая модель распространения рекламы описывается уравнением:

$$\frac{dn}{dt} = (\alpha _1(t) + \alpha _2(t)n(t))(N-n(t))$$

При $\alpha _1(t) >> \alpha _2(t)$ получается модель типа модели Мальтуса, решение которой имеет вид 

![График решения уравнения модели Мальтуса](image/00.PNG){ #fig:001 width=70% height=70% }

В обратном случае $\alpha _1(t) << \alpha _2(t)$ получаем уравнение логистической кривой

![График логистической кривой](image/000.PNG){ #fig:002 width=70% height=70% }

# Задание

**Вариант**

Постройте график распространения рекламы, математическая модель которой описывается следующим уравнением:

1.	$\frac{dn}{dt} = (0.76 + 0.000016n(t))(N-n(t))$
2.	$\frac{dn}{dt} = (0.000016 + 0.6n(t))(N-n(t))$
3.	$\frac{dn}{dt} = (0.7\sin{(7t)} + 0.7\sin{(3t)}  n(t))(N-n(t))$

При этом объем аудитории $N = 1304$, в начальный момент о товаре знает 10 человек.

Для случая 2 определите в какой момент времени скорость распространения рекламы будет иметь максимальное значение.

# Выполнение лабораторной работы

## Решение с помощью программ

### Julia

Код программы для первого случая $\frac{dn}{dt} = (0.76 + 0.000016n(t))(N-n(t))$:

```
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
```

Код программы для второго случая $\frac{dn}{dt} = (0.000016 + 0.6n(t))(N-n(t))$:

```
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
```

Код программы для третьего случая $\frac{dn}{dt} = (0.7\sin{(7t)} + 0.7\sin{(3t)}  n(t))(N-n(t))$:

```
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
```

### Результаты работы кода на Julia

![График распространения рекламы для первого случая, построенный Julia](image/lab07_1.png){ #fig:003 width=70% height=70% }

![График распространения рекламы для второго случая, построенный Julia](image/lab07_2.png){ #fig:004 width=70% height=70% }

![График распространения рекламы для третьего случая, построенный Julia](image/lab07_3.png){ #fig:005 width=70% height=70% }

## OpenModelica

Код программы для первого случая $\frac{dn}{dt} = (0.76 + 0.000016n(t))(N-n(t))$:

```
model lab07_1
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.76 + 0.000016*n)*(N-n);
end lab07_1;

```

Код программы для второго случая $\frac{dn}{dt} = (0.000016 + 0.6n(t))(N-n(t))$:

```
model lab07_2
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.000016 + 0.6*n)*(N-n);
end lab07_2;

```

Код программы для третьего случая $\frac{dn}{dt} = (0.7\sin{(7t)} + 0.7\sin{(3t)}  n(t))(N-n(t))$:

```
model lab07_3
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.7*sin(7*time) + 0.7*sin(3*time)*n)*(N-n);
end lab07_3;
```

### Результаты работы кода на OpenModelica

![График распространения рекламы для первого случая, построенный с помощью OpenModelica](image/lab07_1_OpenModelica.png){ #fig:006 width=70% height=70% }

![График распространения рекламы для второго случая, построенный с помощью OpenModelica](image/lab07_2_OpenModelica.png){ #fig:007 width=70% height=70% }

![График распространения рекламы для третьего случая, построенный с помощью OpenModelica](image/lab07_3_OpenModelica.png){ #fig:008 width=70% height=70% }

# Анализ полученных результатов. Сравнение языков.

В результате проделанной работы нами были построены графики распространения рекламы для трех случаев на Julia и OpenModelica. Построения на языке OpenModelica проводятся относительно значения времени t по умолчанию, что делает работу с построением данных графиков проще. 

# Вывод

В ходе выполнения лабораторной работы была изучена модель эффективности рекламы, а также были построены графики распространения рекламы для трех случаев на Julia и OpenModelica.

# Список литературы. Библиография.

[1] Документация по Julia: https://docs.julialang.org/en/v1/

[2] Документация по OpenModelica: https://openmodelica.org/

[3] Решение дифференциальных уравнений: https://www.wolframalpha.com/

[4] Мальтузианская модель роста: https://www.stolaf.edu//people/mckelvey/envision.dir/malthus.html