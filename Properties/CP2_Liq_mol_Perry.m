%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2021a
% Created : 2021.05.20
% Revised : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Molar heat Capacity at constant pressure calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CP :  Heat Capacity at constant Pressure - [J /kmol.K]
% Tr  : reduce temperature T/TC - [K]
% C  : constant from [1,Table 2-153] - Equation of type 2
% C(5) is used as Critical Temperature for argument compatibility beetween 
% CP_Liq_mol_Perry & CP2_Liq_mol_Perry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] - Perry, R. H.; Green, D. W. Perry's Chemical Engineer's Handbook; 
% 8th Ed.; McGraw-Hill: New York, NY, 2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function CP  = CP2_Liq_mol_Perry(T,C)
taux = 1-T/C(5);
CP = C(1)^2./taux+C(2)-2*C(1)*C(3).*taux-C(1)*C(4).*taux.^2-(C(3)^2)/3.*taux^3-C(3)*C(4)/2.*taux.^4-C(4)^2/5.*taux.^5;
end

