    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Author  : Pascal Denis - Centrale Marseille
    % Langage : Matlab 2017a
    % Created : 2016.12.19
    % Revised : 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Function description
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Molar heat Capacity at constant pressure for gases in the
    % ideal state.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Variables and constants
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % T  : Temperature - [K]
    % C  : constant from [1,Table 2-156]
    % CP0 : molar heat Capacity [J/kmol.K]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % References : 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [1] - Perry, R. H.; Green, D. W. Perry's Chemical Engineer's Handbook; 
    % 8th Ed.; McGraw-Hill: New York, NY, 2008
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function CP_Gas= CP_Gas_mol_Perry(T,C)
        CP_Gas = C(1) + C(2).*(C(3)./T./sinh(C(3)./T)).^2 + C(4).*(C(5)./T./cosh(C(5)./T)).^2;
    end
