%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2019a
% Created : 2020.03.18
% Revised :  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the compressibility factor of single or both phase using 
% the Peng & Robinson Cubic Equation of State.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T  : Temperature - [K]
% P  : Pressure - [MPa]
% TC : Critical Temperature - [K]
% PC : Critical Pressure - [MPa]
% w  : Pitzer"s acntric factor [1] 
% Z_1: Lowest Compressility factor (liquid in two Phases case)
% Z_2: Grteast Compressility factor (Vapor in two Phases case)
% Two_Phase : Logical (0 : Single Phase, 1 : Two Phases)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remarks : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P & PC could be used with another units, but must be expressed
% in the same units (Pa, atm, bar, mmHg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] K.S. Pitzer, D.Z. Lippmann, R.F. Curl Jr, C.M. Huggins, 
% and D.E. Petersen, ?The Volumetric and Thermodynamic Properties of Fluids
% II. Compressibility Factor, Vapor Pressure and Entropy of Vaporization,? 
% J. Am. Chem. Soc., vol. 77, no. 13, pp. 3433?3440, 1955.
%
% [2] D. Y. Peng and D.B. Robinson, ?A new two-constant equation of state,? 
% Industrial & Engineering Chemistry, 1976.
%
% [3]https://physics.nist.gov/cgi-bin/cuu/Value?r|search_for=physchem_in!
% Codata recommended values of the fundamental physical constants - 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Z_1,Two_Phase, Z_2] = Z_PR(T,P,TC,PC,w)


%% Constants

R = 8.314462618; % Recommended Value [3]

omega_a  = 0.45724;
omega_b  = 0.07780;

m0 = 0.37464;
m1 = 1.54226;
m2 = -0.26992;

%% Initialization

Tr = T / TC ;
Pr = P / PC;

N_phase = 0; 
idx = [0 0 0 ];

%% Formal cubic Equation of State

m = m0 + m1*w +m2*w.^2;

alpha =  (1+m.*(1-sqrt(Tr))).^2;

a = omega_a*R*R*TC*TC/PC;
b = omega_b*R*TC/PC;

A = a *alpha* P / R / R ./ T./T;
B = b * P / R ./ T;

Poly = [1;B-1; A-2*B-3*B*B; -A*B+B*B+B*B*B];

%% Root's and # of Phases identification

racines = roots(Poly);

% Physical root are real and > 0

for i = 1:1:3;
    if (isreal(racines(i)))&& (real(racines(i))>0 );
        N_phase = N_phase +1;
        idx(i) = i;
    end
end

% Z repartition

if (N_phase > 1);
    Two_Phase = true;
     Z_1 = min(racines(idx~=0));
     Z_2 = max(racines(idx~=0));
elseif (N_phase == 1);
    Two_Phase = false;
    Z_1 = racines(idx~=0);
    Z_2 = NaN;
 end
end
