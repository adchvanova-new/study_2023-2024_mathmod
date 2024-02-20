model Lab03_01
Real x;
Real y;
Real a = 0.336;
Real b = 0.877;
Real c = 0.441;
Real d = 0.232;
Real t = time;
initial equation
x = 321000;
y = 123000;
equation
der(x) = -a*x - b*y + sin(t+1)+1;
der(y) = -c*x - d*y + cos(t+2)+1;
end Lab03_01;
