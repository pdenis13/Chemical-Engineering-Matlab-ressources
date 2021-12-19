%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2019a
% Created : 2019.09.12
% Revised : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VLE Calculation using Raoult's Law
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P_Sat :  Pressure - [Pa]
% T  : Temperature - [K]
% C  : constant from [1,Table 2-8]
% x  : molar fraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [1]- Perry, R. H.; Green, D. W. Perry'S Chemical Engineer?S Handbook; 
% 8th Ed.; McGraw-Hill: New York, NY, 2008
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc


load ('Perry.mat') % Chargement de la bibliothèque

Id1 = 126; % Composant 1 : Ethanol
Id2 = 342; % Composant 2 : Eau

P = 101325; % pression de travail [Pa]

C1 = [Perry.C_Vap1(Id1) Perry.C_Vap2(Id1) Perry.C_Vap3(Id1) Perry.C_Vap4(Id1) Perry.C_Vap5(Id1)];
C2 = [Perry.C_Vap1(Id2) Perry.C_Vap2(Id2) Perry.C_Vap3(Id2) Perry.C_Vap4(Id2) Perry.C_Vap5(Id2)];


% Calcul des points d'ébullition normaux : 

TNB1 = fzero(@(T) P-P_Sat_Perry(T,C1), 300);
TNB2 = fzero(@(T) P-P_Sat_Perry(T,C2), 300);
T0 = (TNB1 + TNB2) / 2;


T_Perry = TNB1:0.01:TNB2;
P_Sat1 = P_Sat_Perry(T_Perry,C1);
P_Sat2 = P_Sat_Perry(T_Perry,C2);

% Visualisation des 2 Pressions de vapeur saturante pour vérifier leur
% cohérence
figure('Name','Psat Comparison'); % création d'une nouvelle figure

hold on
plot ( T_Perry-273.15, P_Sat1,'r-');
plot ( T_Perry-273.15, P_Sat2,'b-');
hold off

grid
grid minor
xlabel('Temperature (K)')
ylabel('Saturation Pressure (Pa)')

% Calcul des équilibres liquide vapeur

x = 0:0.01:1; %  titre
N = size(x,2);

TEq = [];
y = [];

for i = 1:N
    
    fun = @(T) P - P_Sat_Perry(T,C1)*x(i) - P_Sat_Perry(T,C2)*(1-x(i)); % fonction dont on cherche la racine 
    T = fzero (fun,T0);
    TEq = [TEq T];
    y = [y P_Sat_Perry(T,C1)/P*x(i)];    % Calcul du totre vapeur
end

figure('Name','VLE Equilibrium'); % création d'une nouvelle figure

RAOULT = plot(x,y,'b') % Affectation du tracé à un objet pour manipulation ultrieure 
hold on 
grid
grid minor
xlabel('molar liquid fraction')
ylabel('molar vapor fraction')


% Data de Carey and Lewis, Ind. Eng. Chem., 24, 882 (1932)
data4 = [0 0.0190 0.0721 0.0966 0.1238 0.1661 0.2337 0.2608 0.3273 0.3965 0.5079 0.5198 0.5732 0.6763 0.7472 0.8943 1 ;0 0.1700 0.3891 0.4375 0.4704 0.5089 0.5445 0.5580 0.5826 0.6122 0.6564 0.6599 0.6841 0.7385 0.7815 0.8943 1];
PLOT4 = plot (data4(1,:),data4(2,:),'or'); % Affectation du tracé à un objet pour manipulation ultrieure 
legend([RAOULT,PLOT4],'Raoult''s aw','[2] Carey and Lewis, Ind. Eng. Chem., 24, 882 (1932)');


hold off

