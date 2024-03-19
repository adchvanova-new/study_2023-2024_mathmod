model lab07_3
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.7*sin(7*time) + 0.7*sin(3*time)*n)*(N-n);
end lab07_3;
