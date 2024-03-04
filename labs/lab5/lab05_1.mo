model lab05_1
Real a = 0.34;
Real b = 0.051;
Real c = 0.33;
Real d = 0.031;
Real x;
Real y;
initial equation
x = 9;
y = 30;
equation
der(x) = -a*x + b*x*y;
der(y) = c*y - d*x*y;
end lab05_1;
