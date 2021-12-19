%% Changement de Référence

CoolProp.set_reference_stateS('n-Propane','IIR')
CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
CP.set_reference_state('n-Propane','ASHRAE')
CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
CoolProp.set_reference_stateS('n-Propane','NBP')
CoolProp.PropsSI('H', 'T', 233.15, 'Q', 0, 'n-Propane')
