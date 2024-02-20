model Lab03_02
Real x;
Real y;
Real a = 0.432;
Real b = 0.815;
Real c = 0.336;
Real d = 0.245;
Real t = time;
initial equation
x = 123000;
y = 321000;
equation
der(y) = -a*x - b*y + sin(2*t)+2;
der(x) = -c*x*y - d*y + cos(t)+2;
end Lab03_02;
