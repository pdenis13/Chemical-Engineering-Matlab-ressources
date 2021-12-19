%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2017a    
% Created : 2019.09.21
% Revised :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CoolProp Library PropsSI('d(d(Hmass)/d(T)|P)/d(Hmass)|P','P',101325,'T',300,'Water')
% Molar heat Capacity at constant pressure for gases in the
% ideal  state
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T  : Temperature - [K]
% C  : constant from [1,Table 2-156]
% CP0 : molar heat Capacity [J/kmol.K]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] - Perry, R. H.; Green, D. W. Perry?S Chemical Engineer?S Handbook;
% 8th Ed.; McGraw-Hill: New York, NY, 2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


import py.CoolProp.*

P = 101325; % Pressure in Pa
T  = 273.15 + 120; % Temperature in Kelvin

% Saturation Temperature at P
T_Sat = CoolProp.PropsSI('T','P',P,'Q', 0,'H2O')
% Saturation Pressure at T
P_Sat = CoolProp.PropsSI('P','T',T_Sat,'Q', 0,'Water')
% Enthalpy of the Saturated Liquid at Pressure P
H_liq = CoolProp.PropsSI('H','P',P,'Q', 0,'Water')
% Entropie of the Saturated Vapor at Temperatur T
S_vap = CoolProp.PropsSI('S','T',T,'Q', 1,'Water')

% Prandtl of Water 
T =  300; % 300 K
P = 2000000; % 2 MPa

Prandt_Eau = CoolProp.PropsSI('Prandtl','P',P,'T', T,'Water');
Prandt_Air = CoolProp.PropsSI('Prandtl','P',P,'T', T,'Air');

% Isentropique discharge 

P0 = 20000000;% 20 MPa - High Pressure
T0 = 300;
H0 = CoolProp.PropsSI('H','P',P0,'T', T,'Air'); % Enthalpy at beginning
S0 = CoolProp.PropsSI('S','P',P0,'T', T,'Air'); % Entropy at beginning
P1 = 100000;% 0.1 MPa - Low Pressure
H1 = CoolProp.PropsSI('H','P',P1,'S', S0,'Air'); % Enthalpy at Low Pressure
W = H1 - H0 ; % Work available in J / kg
T1 = CoolProp.PropsSI('T','P',P1,'S', S0,'Air');
% T1 correctly computed but ... 
Q = CoolProp.PropsSI('Q','P',P1,'S', S0,'Air'); % Two Phase region

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CoolProp Properties
% see Table  2 : Basic Information & Properties (Prop1SI)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T_crit = CoolProp.PropsSI('Water', 'Tcrit') ; % Critical Temperature of Water
P_Triple =  CoolProp.PropsSI('Water', 'P_TRIPLE'); % Pressure of Triple in Pa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase Determination 
% using CoolProp.PhaseSI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% soit sous forme string : 

string(CoolProp.PhaseSI('P',72.E05, 'T', 273.15+30,'CO2')) % Gas
string(CoolProp.PhaseSI('P',72.E05, 'T', 273.15+32,'CO2')) % SuperCritical Gas
string(CoolProp.PhaseSI('P',70.E05, 'T', 273.15+28,'CO2')) % Liquid

% soit sous forme char : 

char(CoolProp.PhaseSI('P',74.E05, 'T', 273.15+30,'CO2')) % SuperCritical Liquid
char(CoolProp.PhaseSI('P',74.E05, 'T', 273.15+32,'CO2')) % SuperCritical
char(CoolProp.PhaseSI('P',70.E05, 'Q', 0,'CO2')) % Two Phases (Gas & Liquid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changement de Référence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CoolProp.set_reference_state('n-Propane','IIR');
H_IIR = CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
CoolProp.set_reference_state('n-Propane','ASHRAE');
H_ASHRAE = CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
CoolProp.set_reference_state('n-Propane','NBP');
H_NBP= CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
