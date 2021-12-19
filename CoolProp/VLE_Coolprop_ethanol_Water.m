Tliq = [];
Tvap= [];
P = 101325; 
for i=1:101
    x = (i-1)*0.01;
    Composition = ['ethanol[',num2str(x),']&water[',num2str(1-x),']'];
    TL = PropsSI('T','P',P,'Q', 0,Composition)  ; 
    TV = PropsSI('T','P',P,'Q', 1,Composition);
    [Tliq(i)] = TL
end
