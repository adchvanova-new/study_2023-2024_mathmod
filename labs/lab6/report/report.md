---
## Front matter
title: Отчёт по лабораторной работе №6
subtitle: "Задача об эпидемии. Вариант №53"
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

Изучить и построить модель эпидемии.

# Теоретическое введение. Построение математической модели.

Рассмотрим простейшую модель эпидемии. Предположим, что некая популяция, состоящая из $N$ особей, (считаем, что популяция изолирована) подразделяется на три группы. Первая группа - это восприимчивые к болезни, но пока здоровые особи, обозначим их через $S(t)$. Вторая группа – это число инфицированных особей, которые также при этом являются распространителями инфекции, обозначим их $I(t)$. А третья группа, обозначающаяся через $R(t)$ – это здоровые особи с иммунитетом к болезни. 
До того, как число заболевших не превышает критического значения $I^*$, считаем, что все больные изолированы и не заражают здоровых. Когда $I(t)> I^*$, тогда инфицирование способны заражать восприимчивых к болезни особей. 

Таким образом, скорость изменения числа $S(t)$ меняется по следующему закону:

$$
\frac{dS}{dt}=
 \begin{cases}
	-\alpha S &\text{,если $I(t) > I^*$}
	\\   
	0 &\text{,если $I(t) \leq I^*$}
 \end{cases}
$$

Поскольку каждая восприимчивая к болезни особь, которая, в конце концов, заболевает, сама становится инфекционной, то скорость изменения числа инфекционных особей представляет разность за единицу времени между заразившимися и теми, кто уже болеет и лечится, то есть:

$$
\frac{dI}{dt}=
 \begin{cases}
	\alpha S -\beta I &\text{, если $I(t) > I^*$}
	\\   
	-\beta I &\text{, если $I(t) \leq I^*$}
 \end{cases}
$$

А скорость изменения выздоравливающих особей (при этом приобретающие иммунитет к болезни):

$$\frac{dR}{dt} = \beta I$$

Постоянные пропорциональности $\alpha, \beta$ - это коэффициенты заболеваемости и выздоровления соответственно. Для того, чтобы решения соответствующих уравнений определялось однозначно, необходимо задать начальные условия. Считаем, что на начало эпидемии в момент времени $t=0$ нет особей с иммунитетом к болезни $R(0)=0$, а число инфицированных и восприимчивых к болезни особей $I(0)$ и $S(0)$ соответственно. Для анализа картины протекания эпидемии необходимо рассмотреть два случая:  $I(0) \leq I^*$ и  $I(0)>I^*$

# Задание

На одном острове вспыхнула эпидемия. Известно, что из всех проживающих на острове 
$(N=6159)$ в момент начала эпидемии $(t=0)$ число заболевших людей 
(являющихся распространителями инфекции) $I(0)=173$, А число здоровых людей с иммунитетом 
к болезни $R(0)=61$. Таким образом, число людей восприимчивых к болезни, 
но пока здоровых, в начальный момент времени $S(0)=N-I(0)-R(0)$.
Постройте графики изменения числа особей в каждой из трех групп.

Рассмотрите, как будет протекать эпидемия в случае:

1.	$I(0)\leq I^*$

2.	$I(0)>I^*$

# Задачи

Построить графики изменения числа особей в каждой из трех групп $S$, $I$, $R$. Рассмотреть, как будет протекать эпидемия в случаях:

-	$I(0)\leq I^*$

-	$I(0)>I^*$

# Выполнение лабораторной работы

## Julia

Код программы для случая $I(0) \leq I^*$ (для случая, где больные изолированы):

```
using Plots
using DifferentialEquations

N= 6159
I0=173
R0=61
S0= N - I0 - R0

alpha= 0.1
beta=0.2

# I0<=I*

function func1(du,u,p,t)
	S,I,R=u
	du[1]=0
	du[2]=-beta*u[2]
	du[3]=beta*I
end

v0=[S0,I0,R0]
interval=(0.0,60.0)
problem=ODEProblem(func1,v0,interval)
solution=solve(problem,dtmax=0.05)
S=[u[1] for u in solution.u]
I=[u[2] for u in solution.u]
R=[u[3] for u in solution.u]
T=[t for t in solution.t]


plt = plot(
  dpi = 600,
  legend = :topright)
plot!(
  plt,
  T,
  S,
  label = "Восприимчивые особи",
  color = :blue)
plot!(
  plt,
  T,
  I,
  label = "Инфицированные особи",
  color = :red)
plot!(
  plt,
  T,
  R,
  label = "Особи с иммунитетом",
  color = :green)

savefig(plt, "lab06_1.png")
```
Код программы для случая $I(0)>I^*$ (для случая, где больные могут заражать особей группы S): 
```
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
```

## Результаты работы кода на Julia

![Графики численности особей 3 групп S, I, R, построенные на Julia, для случая, где больные изолированы](image/lab06_1.png){ #fig:001 width=70% height=70% }

![Графики численности особей 3 групп S, I, R, построенные на Julia, для случая, где больные могут заражать особей группы S](image/lab06_2.png){ #fig:002 width=70% height=70% }

## OpenModelica

Код программы для случая $I(0) \leq I^*$:

```
model lab06_1
Real N = 6159 ;
Real I;
Real R;
Real S;
Real alpha = 0.1;
Real beta = 0.2;
initial equation
I = 173;
R = 61;
S = N - I - R;
equation
der(S) = 0;
der(I) = -beta*I;
der(R) = beta*I;
end lab06_1;
```

Код программы для случая $I(0)>I^*$:

```
model lab06_2
Real N = 6159;
Real I;
Real R;
Real S;
Real alpha = 0.1;
Real beta = 0.2;
initial equation
I = 173;
R = 61;
S = N - I - R;
equation
der(S) = -alpha*S;
der(I) = alpha*S - beta*I;
der(R) = beta*I;
end lab06_2;
```

## Результаты работы кода на OpenModelica

![Графики численности особей 3 групп S, I, R, построенные на OpenModelica, для случая, где больные изолированы](image/lab06_1_OpenModelica.png){ #fig:003 width=70% height=70% }

![Графики численности особей 3 групп S, I, R, построенные на OpenModelica, для случая, где больные могут заражать особей группы S](image/lab06_2_OpenModelica.png){ #fig:004 width=70% height=70% }

# Анализ полученных результатов. Сравнение языков.

В результате проделанной работы нами были построенны графики зависимости численности особей трех групп S, I, R для случаев, когда больные изолированы и когда они могут заражать особей группы S. Графики на OpenModelica и Julia получаются идентичными, что говорит о правильном построении.

# Вывод

В ходе выполнения лабораторной работы нами была изучена модель эпидемии и построена модель на языках Julia и Open Modelica, а также рассмотрены случаи,где больные изолированы и когда они могут заражать особей группы S.

# Список литературы. Библиография.


[1] Документация по Julia: https://docs.julialang.org/en/v1/

[2] Документация по OpenModelica: https://openmodelica.org/

[3] Решение дифференциальных уравнений: https://www.wolframalpha.com/

[4] Конструирование эпидемиологических моделей: https://habr.com/ru/post/551682/