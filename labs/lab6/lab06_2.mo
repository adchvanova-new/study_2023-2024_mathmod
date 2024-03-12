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
