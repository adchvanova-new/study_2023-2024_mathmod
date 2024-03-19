model lab07_1
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.76 + 0.000016*n)*(N-n);
end lab07_1;
