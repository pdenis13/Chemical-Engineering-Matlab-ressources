
import py.CoolProp.CoolProp.* 

TC = PropsSI('Water', 'Tcrit');
TK = PropsSI('Water', 'T_triple');

dT = TK:0.1:TC;
T = py.list(dT);
tic
P = PropsSI('P','T',T,'Q', 0,'H2O');
P2 = double(P) ;
toc
