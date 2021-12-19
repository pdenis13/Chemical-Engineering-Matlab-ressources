
% data from Perry 

load ('~/Dropbox/Matlab-Drive/Database/Perry.mat')

N_Ethanol = 126
N_Butanol = 34

C_Perry_Ethanol = [Perry.C_Vap1(N_Ethanol) Perry.C_Vap2(N_Ethanol) Perry.C_Vap3(N_Ethanol) Perry.C_Vap4(N_Ethanol) Perry.C_Vap5(N_Ethanol)];
T_range_Perry_Ethanol = [Perry.T_P_Vap_min(N_Ethanol) Perry.T_P_Vap_max(N_Ethanol)]

C_Perry_Butanol = [Perry.C_Vap1(N_Butanol) Perry.C_Vap2(N_Butanol) Perry.C_Vap3(N_Butanol) Perry.C_Vap4(N_Butanol) Perry.C_Vap5(N_Butanol)];
T_range_Perry_Butanol = [Perry.T_P_Vap_min(N_Butanol) Perry.T_P_Vap_max(N_Butanol)]

T_range_Perry = [max(T_range_Ethanol(1), T_range_Butanol(1)) min(T_range_Ethanol(2), T_range_Butanol(2))];
T_Perry = linspace(T_range_Perry(1),T_range_Perry(2) , 100);

P_Sat_Perry_Ethanol = P_Sat_Perry(C_Perry_Ethanol,T_Perry);
P_Sat_Perry_Butanol = P_Sat_Perry(C_Perry_Butanol,T_Perry);


% data from KDB 

C_KDB_Butanol = [ -9.882614E+00  -9.127496E+03 8.672214E+01  1.428480E-06];
T_KDB_range_Butanol = [83.85 563.00]

C_KDB_Ethanol = [ -5.089412E+00  	-6.606453E+03	5.317030E+01	5.954048E-07];
T_KDB_range_Ethanol = [159.05 516.25]



T_KDB_range = [max(T_KDB_range_Ethanol(1), T_KDB_range_Butanol(1)) min(T_KDB_range_Ethanol(2), T_KDB_range_Butanol(2))];
T_KDB = linspace(T_KDB_range(1),T_KDB_range(2) , 100);

P_Sat_KDB_Ethanol = P_Sat_KDB(C_KDB_Ethanol,T_KDB) * 1000;
P_Sat_KDB_Butanol = P_Sat_KDB(C_KDB_Butanol,T_KDB) * 1000 ;



hold on
plot ( T_Perry-273.15, P_Sat_Perry_Ethanol,'r-');
plot ( T_Perry-273.15, P_Sat_Perry_Butanol,'b-');
plot ( T_KDB-273.15, P_Sat_KDB_Ethanol,'r:');
plot ( T_KDB-273.15, P_Sat_KDB_Butanol,'b:');

grid
grid minor
xlabel('Temperature (K)')
ylabel('Saturation Pressure (Pa)')
hold off

