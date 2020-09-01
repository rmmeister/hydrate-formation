%% INITIALIZE MATLAB
clc
clear all
close all
format long

%% DASHBOARD
componentName = {'C1', 'C2', 'C3', 'iC4', 'nC4', 'N2', 'CO2'};
vaporComposition = [.784 .060 .036 .005 .019 .094 .002]; % component molar fraction
initialPressure = 500;
temperatureStep = 1;
temperatureVector = 32:temperatureStep:58; % degrees Fahrenheit

%% SOLVING FOR HYDRATE PRESSURE AT EACH T
temperatureCounter = 0;
Pressure = zeros(size(temperatureVector));
for Temperature = temperatureVector 
    temperatureCounter = temperatureCounter + 1;
    funkHandle = @(p) getHydratePressure (vaporComposition, Temperature, p);
    [p, sumError(temperatureCounter), pressureFlag(temperatureCounter)] = fsolve(funkHandle,...
        initialPressure, optimoptions('fsolve','Display','off'));
    Pressure(temperatureCounter) = p; 
    if pressureFlag(temperatureCounter) ~= 1
        errorTemp = Temperature;
        warning(['Sum of y/K did not converge to 1 @ T = ', num2str(errorTemp)]);
    end
end

%% RESULTS
% P-T diagram
figure
plot(temperatureVector, Pressure, 'r' ,'LineWidth', 2)
grid on
title('Hydrate Formation P-T Diagram');
xlabel('Temperature, degrees F');
ylabel('Pressure, psia');
xlim([32 58]);

% Error diagram
figure 
plot(temperatureVector, sumError, 'c' ,'LineWidth', 2)
xlim([32 58]);
xlabel('Temperature, degrees F');
ylabel('Error, psia');

% Composition Table
compositionTable = table(componentName', vaporComposition');
compositionTable.Properties.VariableNames = {'Components', 'MolarFractions'};
disp(compositionTable);