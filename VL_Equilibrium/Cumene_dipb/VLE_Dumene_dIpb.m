
calc1 = stCALCreate;
%modified = stCALEdit(calc1);
%modified = stCALSystemEdit(calc1,1);

Base = 'Standard 2019';

% Compound Addition by CAS 
nbCompound = AddCompoundByCAS(calc1, Base, '100-18-5'); % di-isopropyl benzene
nbCompound = AddCompoundByCAS(calc1, Base, '98-82-8'); % Cumene

% Compound Addition by CAS 
name1 = stCALCompoundDisplayName(calc1,1);
name2 = stCALCompoundDisplayName(calc1,2);

% Model Choice

stCALSetModlModelCode(calc1,18); % #3 =LKP semble le plus adaptée
model1 = stCALGetModlName(calc1);
% Unit Choice

stCALSetUnitNameInSystem(calc1,1,'Temperature','°C'); % Température entrée en °C
stCALSetUnitNameInSystem(calc1,2,'Temperature','°C'); % Température sortie en °C
stCALSetUnitNameInSystem(calc1,1,'Pressure','atm');

%P = 50660.0; 
%P = 101325;
P = 1;
typeFrac = 0; % 0 = molaire / 1 = massique
typeRes = 0; % 0 = molaire / 1 = massique
fractions = [0 0]; % initialisation
N = 10000; % nombre de points

for i = 1:N+1
   x(i) = (i-1)/N;
   fractions(1) = 1-x(i);
   fractions(2) = x(i);
   % fractions = [1-x(i) x(i)]; autres méthode
   [bubble(i),liquid(i,:),vapor(i,:)] = stCALBubbleTemperature(calc1,P,fractions,typeFrac,typeRes,false);
 end

figure
hold on

EOS = plot (liquid(:,2), vapor(:,2),'b');
XY = plot (liquid2(:,2), liquid2(:,2),'black');
title('VLE Cumene - diisopropylbenzene (1 atm)');
xlabel('Cumene molar liquid fraction');
ylabel('Cumene molar vapor fraction');
grid on;


hold off
