clear, clc

m1=input('Ingrese un número entero:');
m2=input('Ingrese otro número entero:');

[r,k]=MCD(m1,m2);

fprintf('El máximo común divisor de ellos es %i.\n',r)
fprintf('El número de iteraciones fue de %i.',k)

function [M,k]=MCD(m,n)
    k=0;
    if n>m
        r=n;
        n=m;
        m=r;
    end
    r=mod(m,n);
    while r~=0
        m=n;
        n=r;
        r=mod(m,n);
        k=k+1;
    end
    M=n;
end