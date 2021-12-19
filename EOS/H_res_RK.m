%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2021a
% Created : 2021.04.16
% Revised :  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimate the Enthalpie using the Redlich-Kwong Cubic Equation of State.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T  : Temperature - [K]
% P  : Pressure - [MPa]
% TC : Critical Temperature - [K]
% PC : Critical Pressure - [MPa]
% H_1: Lowest Compressility factor (liquid in two Phases case)
% H_2: Grteast Compressility factor (Vapor in two Phases case)
% Two_Phase : Logical (0 : Single Phase, 1 : Two Phases)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remarks : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P & PC could be used with another units, but must be expressed
% in the same units (Pa, atm, bar, mmHg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] O. Redlich and J. N. S. KWONG, ?On the thermodynamics of solutions; 
% an equation of state; fugacities of gaseous solutions.,? 
% Chem. Rev., vol. 44, no. 1, pp. 233?244, Feb. 1949.
%
% [2] https://physics.nist.gov/cuu/Constants/index.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [H_res_1,Two_Phase, H_res_2] = H_res_RK(T,P,TC,PC)


%% Constants

R = 8.31446618; % Recommended Value [2]

omega_a  = 1 / 9 /( 2^(1/3) - 1);
omega_b  = ( 2^(1/3) - 1) / 3;

%% Initialization

Tr = T / TC ;
Pr = P / PC;
N_phase = 0; 
idx = [0 0 0 ];

%% Formal cubic Equation of State

alpha =  1./sqrt(T);
a = omega_a * R * R * TC.^(2.5) / PC;
b = omega_b * R * TC / PC;
A = a * P / R / R ./ T.^(2.5);
B = b * P / R ./ T;

Poly = [1 -1 (A-B - B.*B) -A.*B];

%% Root's and # of Phases identification

racines = roots(Poly);

% Physical root are real and > 0

for i = 1:1:3;
    if (isreal(racines(i)))&& (real(racines(i))>0 );
        N_phase = N_phase +1;
        idx(i) = i;
    end;
end;

% Z repartition

if (N_phase > 1);
    Two_Phase = true;
    Z_1 = min(racines(idx~=0));
    Z_2 = max(racines(idx~=0));
    % Molar Volume Calculation
    V_1 = Z_1*R*T/P;
    V_2 = Z_2*R*T/P;
    % Résidual Enthalpie Calculation
    H_res_1 = (Z_1 - 1 - 1.5*omega_a/(omega_b*Tr^1.5) * log(1 + b/V_1))*R*T;
    H_res_2 = (Z_2 - 1 - 1.5*omega_a/(omega_b*Tr^1.5) * log(1 + b/V_2))*R*T;
elseif (N_phase == 1);
    Two_Phase = false;
    Z_1 = racines(idx~=0);
    Z_2 = NaN;
    V_1 = Z_1*R*T/P;
    H_res_1 = (Z_1 - 1 - 1.5*omega_a/(omega_b*Tr^1.5) * log(1 + b/V_1))*R*T;
    H_res_2 = NaN;
end;

end
