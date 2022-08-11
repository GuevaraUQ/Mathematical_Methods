clear, clc

X=input('Ingrese un número:');
X0=input('Ingrese valor inicial:');
E=input('Ingrese la toleracia:');

fprintf(' n   |      x_n        |      E_t  \n')

[R,k]=Raiz(X,X0,E);

function [S,k]=Raiz(x,x0,e)
    k=0;
    S=x0;
    fprintf(' %#.2g | %#.14g | %#.10g %%\n',k,S,100*abs(S-sqrt(x))/sqrt(x))
    while abs(S-sqrt(x))>=e
        S=1/2*(S+x/S);
        k=k+1;
        fprintf(' %#.2g | %#.14g | %#.10g %%\n',k,S,100*abs(S-sqrt(x))/sqrt(x))
    end
end