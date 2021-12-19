import py.CoolProp.CoolProp.* 


P_0 = 0.1E5;
P_1 = 100E5;
T_0 = PropsSI('T','P',P_0,'Q', 1,'H2O');
S_0 = PropsSI('S','P',P_0,'Q', 0,'H2O');
H_0 = PropsSI('H','P',P_0,'Q', 0,'H2O');
S_1 = S_0;
T_1 = PropsSI('T','P',P_1,'S', S_1,'H2O');
H_1 = PropsSI('H','P',P_1,'S', S_1,'H2O');
W_Pump = H_1 - H_0;

% irreversible process

eta_pump = 0.9;
W_Pump_irr = W_Pump / eta_pump
H_1_irr = W_Pump_irr + H_0
T_1_irr = PropsSI('T','P',P_1,'H', H_1_irr,'H2O');


P_2 = P_1;
T_2  = 550 + 273.15; 
H_2  = PropsSI('H','P',P_2,'T', T_2,'H2O');
S_2  = PropsSI('S','P',P_2,'T', T_2,'H2O');

P_3 = P_0;
S_3 = S_2;
H_3 = PropsSI('H','P',P_3,'S', S_3,'H2O');
T_3 = PropsSI('T','P',P_3,'S', S_3,'H2O');
W_Turbine = H_3 - H_2;

eta_Turb = 0.92
W_Turbine_irr = W_Turbine  * eta_Turb
H_3_irr = W_Turbine_irr + H_2

Q_Boiler = H_2 - H_1;
Q_Boiler_irr = H_2 - H_1_irr;

Carnot_Eff = - (W_Pump + W_Turbine)/Q_Boiler
Carnot_Eff_irr = - (W_Pump_irr + W_Turbine_irr)/Q_Boiler_irr
