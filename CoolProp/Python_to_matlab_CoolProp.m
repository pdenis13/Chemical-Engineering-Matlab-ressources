%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author  : Pascal Denis - Centrale Marseille
% Langage : Matlab 2019a
% Created : 2019.06.21
% Revised :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage of CoolProp Python Library with vectorization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Python Libraries needed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CoolProp 6.3.0 (installed via pip (Python packages installer)
% Numpy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Import CoolProp Library

import py.CoolProp.CoolProp.* 

% Type conversion from MATLAB vector to Python list

T_C = 10:10:350; % Temperature range
T_K = T_C + 273.15; % Conversion in K
T = py.list(T_K);

% Use of CoolProp for Vapor Pressure Calculation
P = PropsSI('P','T',T,'Q', 0,'H2O') ;

% Type conversion from Python numpy array to MATLAB vector
P_sat =  double(P); % Conversion from numpy.ndarray to MATLAB Vector

% Figure treatment
P_sat = P_sat / 1E6; % Conversion in MPa
figure('Name','Vapor Pressure of Water');
plot (T_C, P_sat,'r')
xlabel('T (°C)')
ylabel('P (MPa)')
grid minor
title('Vapor Pressure of Water')