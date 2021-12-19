%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2017a
% Created : 2017.06.06
% Revised : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Examples using the Perry Database of 345 Compounds : Perry.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1] - Perry, R. H.; Green, D. W. Perry?S Chemical Engineer?S Handbook; 
% 8th Ed.; McGraw-Hill: New York, NY, 2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc

% Load Database 

load Perry;

% Compound selection

i = randi(345); % Compounds Number
T = 300; % Working Temperature (could give some error with some coumpounds)

i = 127

%% Liquid Density 
C = [Perry.C_Rho1(i) Perry.C_Rho2(i) Perry.C_Rho3(i) Perry.C_Rho4(i)];
Rho = Rho_Liq_mol_Perry(C,T);

% Heat Capacity of the Liquid 
C = [Perry.CP_Liq1(i) Perry.CP_Liq2(i) Perry.CP_Liq3(i) Perry.CP_Liq4(i) Perry.CP_Liq5(i)];
CP_Liq = CP_Liq_mol_Perry(C,T);

% Heat Capacity of the Gas in the ideal State 
C = [Perry.CP_Gas1(i) Perry.CP_Gas2(i) Perry.CP_Gas3(i) Perry.CP_Gas4(i) Perry.CP_Gas5(i)];
CP_Gaz = CP_Gas_mol_Perry(C,T);

% Enthalpy of Vaporization
C = [Perry.H_Vap1(i) Perry.H_Vap2(i) Perry.H_Vap3(i) Perry.H_Vap4(i)];
Tr = T / Perry.TC(i);
DH_Vap = DH_Vap_Perry(C,Tr);

%% Vapor Pressure 
C = [Perry.C_Vap1(i) Perry.C_Vap2(i) Perry.C_Vap3(i) Perry.C_Vap4(i) Perry.C_Vap5(i) ];
Psat = P_Sat_Perry(C,T);

% Printing

disp(['Num : ', num2str(Perry.N(i))])
disp(['Nom : ', Perry.Name{i}])
disp(['TC : ', num2str(Perry.TC(i)), ' K'])
disp(['-----------------------------------'])
disp(['Température de Travail : ', num2str(T), ' K'])
disp(['-----------------------------------'])
disp(['Psat : ', num2str(Psat), ' Pa'])
disp(['Rho_mol : ', num2str(Rho), ' kmol/m3'])
disp(['Rho_mas : ', num2str(Rho*Perry.Mol_W(i)), ' kg/m3'])
disp(['CP_Liq : ', num2str(CP_Liq), ' J/kmol.K'])
disp(['CP_Gaz : ', num2str(CP_Gaz), ' J/kmol.K'])
disp(['CP_Liq_mas : ', num2str(CP_Liq*Perry.Mol_W(i)/1000/1000), ' kJ/mol.K'])
disp(['DH_Vap : ', num2str(DH_Vap), ' J/kmol'])

% Information on the variable

i = randi(58); % Number of variable per Compound

disp(['------------------------------------------------'])
disp(['Compounds Number : ',int2str(i)])
%fprintf('Compounds Number %i \n',i)
disp(['------------------------------------------------'])
disp(['Nom : ',Perry.Properties.VariableNames{i}])
disp(['Units : ',Perry.Properties.VariableUnits{i}])
disp(['Description : ',Perry.Properties.VariableDescriptions{i}])

 

