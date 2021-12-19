%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2020a
% Created : 2020.03.21
% Revised : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VLE Calculation binary Water - Ethanol under atmospheric Pressure
% using a rationnal function from the fitting of a SRK-MHV2-UNIQUAC 
% Simulis Calculation
% Error < 0.0001
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x  : Ethanol liquid molar fraction
% y  : Ethanol Vapor molar fraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulis Thermodynamics from ProSim SA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = Ethanol_Water_VLE(x)

p1 =  -65.1642;
p2 =  150.9874;
p3 = -141.7973;
p4 =  273.8276;
p5 =    0.0033;

q1 =  -69.5261;
q2 = -129.3260;
q3 =  394.6458;
q4 =   21.0454;

y = (p1.*x.^4+p2.*x.^3+p3.*x.^2+p4.*x+p5)./(x.^4+q1.*x.^3+q2.*x.^2+q3.*x+q4);

end
