model lab05_2
Real a = 0.34;
Real b = 0.051;
Real c = 0.33;
Real d = 0.031;
Real x;
Real y;
initial equation
x = c / d;
y = a / b;
equation
der(x) = -a*x + b*x*y;
der(y) = c*y - d*x*y;
end lab05_2;
