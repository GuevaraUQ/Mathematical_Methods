clear, clc, close all 
syms x
f(x)=exp(-x)-log(x);
%f=inline(input('Ingrese la función en x: ','s')); % @(x)

Bin=input('¿Cúal método desea usar? \n 0 para el de la bisección. \n 1 para el de la falsa posición. \n 2 para el del punto fijo. \n\n');

if Bin==0 || Bin==1
    m=1;
    while m~=0
        a=input('Elija el límite inferior del intevalo:');
        b=input('Elija el límite superior del intevalo:');
        if f(a)*f(b)<0
            m=0;
        else
        fprintf('Los intervalos no funcionan.')
        end
    end
    e=input('Ingrese la tolerancia:');
    
    if Bin==0
        A=bis(a,b,e,f);
    else
        A=fal(a,b,e,f);
    end
elseif Bin==2
    A=pun(f);
end

function B=bis(a,b,e,f)

    fi1=figure();
    fplot(f,[a,b])
    grid on
    
    figure
    title('Error')
    hold on

    p=1;
    k=2;
    
    Rf=(a+b)/2;

    fprintf(' n  |       x_n       |          E_a   \n')
    fprintf('%#.2g | %#.14g |\n', 1, Rf)

    %R=[Rf];
    %Er=[1];

    while p~=0
        Ri=Rf;  
        if f(a)*f(Rf)<=0
            b=Rf;
        else
            a=Rf;
        end   
        Rf=(a+b)/2; 
        E=abs(Ri-Rf)/Rf;
        plot(k,E,'.','MarkerSize',20)
        %R(end+1)=Rf;
        %Er(end+1)=E;
        fprintf('%#.2g | %#.14g | %#.14e %% \n', k, Rf,E*100)
        if E<e
            p=0;
        end
        k=k+1;
    end
    
    hold off

    figure(fi1)
    hold on
    title('Función')
    plot(Rf,f(Rf),'.','MarkerSize',20)
    hold off
    
    B=Rf;

    %R=R(:);
    %Er=Er(:);
    %T=table(R,Er);

    %figure
    %uitable('Data',T{:,:},'ColumnName',['Valor';'Error'])
end

function F=fal(a,b,e,f)

    fi1=figure();
    fplot(f,[a,b])
    grid on
    
    figure
    title('Error')
    hold on

    p=1;
    k=2;
    
    Rf=b+(b-a)/(f(a)-f(b))*f(b);

    fprintf(' n  |       x_n       |          E_a   \n')
    fprintf('%#.2g | %#.14g |\n', 1, Rf)

    while p~=0
        Ri=Rf;  
        if f(a)*f(Rf)<=0
            b=Rf;
        else
            a=Rf;
        end   
        Rf=b+(b-a)/(f(a)-f(b))*f(b); 
        E=abs(Ri-Rf)/Rf;
        plot(k,E,'.','MarkerSize',20)
        fprintf('%#.2g | %#.14g | %#.14e %% \n', k, Rf,E*100)
        if E<e
            p=0;
        end
        k=k+1;
    end
    
    hold off

    figure(fi1)
    hold on
    title('Función')
    plot(Rf,f(Rf),'.','MarkerSize',20)
    hold off
    
    F=Rf;
end

function P=pun(f)

    syms x

    g(x)=f(x)+x;
    dg(x)=diff(g,x);
    S=solve(dg==0,x);
    p=1;
    m=1;
    k=1;
    while m~=0
        a=input('Elija el límite inferior del intevalo: ');
        b=input('Elija el límite superior del intevalo: ');
        q=0;
        for r=S
            if (g(r)>=a) && (g(r)<=b)
                q=q+1;
            end
        end
        if (((g(a)>=a) && (g(a)<=b)) && ((g(b)>=a) && (g(b)<=b))) && length(S)==q
            m=0;
        else
            fprintf('Los intervalos no funcionan. \n')
        end
    end
    
    e=input('Ingrese la tolerancia: ');
    O=input('Elija el punto inicial: ');
    
    fi1=figure();
    fplot(f,[a,b])
    grid on
    
    figure
    title('Error')
    hold on
    
    E=1;
    
    plot(k,E,'.','MarkerSize',20)
    fprintf(' n  |       x_n       |          E_a   \n')
    fprintf('%#.2g | %#.14g |\n', k, O)
    
    while p~=0
        if E<e
            p=0;
        end
        E=abs(O-g(O))/g(O);
        O=g(O);
        k=k+1;
        plot(k,E,'.','MarkerSize',20)
        fprintf('%#.2g | %#.14g | %#.14e %% \n', k, O,E*100)
    end
    
    hold off

    figure(fi1)
    hold on
    title('Función')
    plot(O,f(O),'.','MarkerSize',20)
    hold off
    
    P=O;
end