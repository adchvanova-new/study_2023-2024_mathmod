model lab07_2
Real N = 1304;
Real n;
initial equation
n = 10;
equation
der(n) = (0.000016 + 0.6*n)*(N-n);
end lab07_2;
