%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2019a
% Created : 2019.05.15
% Revised : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VLE equilibrium Calculation for mixture binary Methanol / Water
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P  : Working Pressure - [Pa]
% Liquid : Methanol molar Liquid fraction
% Vapor : Methanol molar Vapor fraction 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : Simulis Thermodynamics Toolbox
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc

% create Calculator
scal = stCALCreate;

% Product Database 
Base = 'Standard 2019';

% Compound Addition by CAS 
nbCompound = AddCompoundByCAS(scal, Base, '67-56-1'); % Methanol
nbCompound = AddCompoundByCAS(scal, Base, '7732-18-5'); % Water

% Compound Addition by CAS 
name1 = stCALCompoundDisplayName(scal,1);
name2 = stCALCompoundDisplayName(scal,2);

% Model Choice

stCALSetModlModelCode(scal,18); % SRK-MHV2-UNIFAC
model1 = stCALGetModlName(scal);

%% Units

stCALSetUnitNameInSystem(scal,1,'Temperature','°C'); % Température entrée en °C
stCALSetUnitNameInSystem(scal,2,'Temperature','°C'); % Température sortie en °C
stCALSetUnitNameInSystem(scal,1,'Pressure','Pa'); %Pression d'entrée
stCALSetUnitNameInSystem(scal,2,'Pressure','Pa'); % pression de sortie


%% Caculation Condition  & Initialization 

P = 101325; % Pa
fractions = [0 0];
typeFrac = 0; % molar fraction
typeRes = 0; % molar fraction
N = 100; % 

%% Liquid-Vapor equilibrium calculation 

for i = 1:N+1
   x(i) = (i-1)/N;
   fractions(1) = 1-x(i);
   fractions(2) = x(i);
   [bubble(i),liquid(i,:),vapor(i,:)] = stCALBubbleTemperature(scal,P,fractions,typeFrac,typeRes,false);
end

%% Calculator closing
stCALFree(scal)

%% Plot diagram

x_liq = liquid(:,1);
y_vap = vapor(:,1);

hold on
plot (x_liq, y_vap, 'b')
plot (x_liq, x_liq,'k')
grid minor
title('Methanol/Water Equilibrium Curve @1 atm');
xlabel('molar liquid fraction');
ylabel('molar vapor fraction');

%% Experimental VLE Data from 

% Data from https://www.cheric.org/research/kdb/hcvle/hcvle.php
data1 = importdata('Methanol_Water_VLE_Data_01.dat');
plot (data1(:,3),data1(:,4),'or');

data2 = importdata('Methanol_Water_VLE_Data_02.dat');
plot (data2(:,3),data2(:,4),'og');

data3 = importdata('Methanol_Water_VLE_Data_03.dat');
plot (data3(:,3),data3(:,4),'om');

data4 = importdata('Methanol_Water_VLE_Data_04.dat');
plot (data4(:,3),data4(:,4),'oc');

% End

