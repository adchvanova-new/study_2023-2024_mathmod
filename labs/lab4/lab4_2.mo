//case2: x'' + 2.9x' + 3.9x = 0
model lab4_2

parameter Real w = sqrt(3.90);  
parameter Real g = 2.9;  

parameter Real x0 = 1.9;// начальное условие
parameter Real y0 = 0.9;// начальное условие

Real x(start=x0); 
Real y(start=y0); 

// f(t) 
function f 
input Real t ; 
output Real res; 
algorithm  
res := 0; 
end f; 

equation 
der(x) = y; 
der(y) = -w*w*x - g*y + f(time); 

end lab4_2;
