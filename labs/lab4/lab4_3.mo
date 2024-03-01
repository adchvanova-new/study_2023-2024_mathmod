//case3: x'' + 4.9x' + 5.9x = 6.9sin(7.9t)
model lab4_3

parameter Real w = sqrt(5.90);  
parameter Real g = 2.45;  

parameter Real x0 = 1.9;// начальное условие
parameter Real y0 = 0.9;// начальное условие

Real x(start=x0); 
Real y(start=y0); 

// f(t) 
function f 
input Real t ; 
output Real res; 
algorithm  
res := 6.9*sin(7.9*t); // 3 случай 
end f; 

equation 
der(x) = y; 
der(y) = -w*w*x - g*y - f(time); 
end lab4_3;

