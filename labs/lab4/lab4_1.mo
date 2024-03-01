//case1: x''+ 1.9x = 0
model lab4_1 
//x'' + g* x' + w^2* x = f(t) 
//w - частота 
//g - затухание 

parameter Real w = 1.9;
parameter Real g = 0;
parameter Real x0 = 1.9;// начальное условие
parameter Real y0 = 0.9;// начальное условие
Real x(start=x0);
Real y(start=y0);
equation
der(x)=y;
der(y)=-w*x;

end lab4_1;
