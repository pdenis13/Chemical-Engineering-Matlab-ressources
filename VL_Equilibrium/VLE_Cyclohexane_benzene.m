% Pascal Denis
% École Centrale Marseille
% december 2015
clc
% Calculator Creation 
calc1 = stCALCreate;


% Compound Addition using CAS number
nbCompound = AddCompoundByCAS(calc1, 'Standard 2017', '110-82-7'); % Cyclohexane
name1 = stCALCompoundDisplayName(calc1,1);

nbCompound = AddCompoundByCAS(calc1, 'Standard 2017', '71-43-2'); % Benzène
name2 = stCALCompoundDisplayName(calc1,2);

% Model Choice%

%stCALSetModlModelCode(calc1,8); % #8 = NRTL
stCALSetModlModelCode(calc1,18); % #18 = SRk-MHV2-UNIFAC
model1 = stCALGetModlName(calc1);


% Unit Choice

stCALSetUnitNameInSystem(calc1,1,'Temperature','°C'); % Température entrée en °C
stCALSetUnitNameInSystem(calc1,2,'Temperature','°C'); % Température sortie en °C
stCALSetUnitNameInSystem(calc1,1,'Pressure','Pa');

% Caculation Condition
P = 101325; 
typeFrac = 0; % molar fraction
typeRes = 0; % molar fraction

% Initialization 
fractions = [0 0];



% Liquid-Vapor equilibrium calculation 
x = 0:0.001:1;

for i = 1:size(x,2)
   fractions(1) = 1-x(i);
   fractions(2) = x(i);
   [bubble(i),liquid(i,:),vapor(i,:)] = stCALBubbleTemperature(calc1,P,fractions,typeFrac,typeRes,false);
   [dew(i),liquid(i,:),vapor(i,:)] = stCALDewTemperature(calc1,P,fractions,typeFrac,typeRes,false);
end

% Plot results 

plot (liquid(:,2), liquid(:,2),'k'); % y=x curve
hold on
plot (liquid(:,2), vapor(:,2),'r'); % y=x curve
grid minor;
title('VLE Benzene - Cyclohexane')
xlabel('Benzene liquid molar fraction')
ylabel('Benzene vapor molar fraction')
hold off

stCALFree(calc1);

% end

