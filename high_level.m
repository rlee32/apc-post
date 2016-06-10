clear; close all; clc;

% % parameters
% cells = 1:6;
% power_loading = 81.35; % N/kW
% thrust = 200; % lbf
% thrust_per_rotor = 6.669;
% motor_efficiency = 0.84;
% rotor_diameter = 18; % inches
% rpm = 5000;
% parameters
cells = 1:6;
power_loading = 78.89; % N/kW
thrust = 200; % lbf
thrust_per_rotor = 6.176;
motor_efficiency = 0.84;
rotor_diameter = 16; % inches
rpm = 7000;

w.batt = 0.15; % kg
w.motor = 0.15;
w.esc = 0.05;
w.harness = 5.4; 


% derived
volts = cells*3.7;
rotors = thrust / thrust_per_rotor;
radius = rotor_diameter / 2 * 0.0254;
area = pi*radius^2;


% results
thrust_metric = thrust * 4.45;
overall_power = thrust_metric / power_loading / motor_efficiency; % kW
disp(['Overall Power: ' num2str(overall_power) ' kW']);
motor_power = overall_power / rotors * 1000; % W
disp(['Power Per Motor: ' num2str(motor_power) ' W']);
disp(['Number of Rotors Required: ' num2str(rotors)]);

ideal_power = (thrust_metric/rotors)^(1.5) * sqrt(0.5 / 1.18 / area);
disp(['Rotor figure of merit: ' num2str(ideal_power / motor_power)]);
overall_ideal_power = (thrust_metric)^(1.5) * sqrt(0.5 / 1.18 / area / rotors);

uw = w.batt+w.motor+w.esc;
mw = rotors*uw + w.harness;
disp(['Machine Weight: ' num2str(mw) ' kg']);
disp(['Overall Thrust Amplify: ' num2str(thrust_metric / 9.8 / mw)]);
disp(['Unit Thrust Amplify: ' num2str(thrust_per_rotor*4.45 ...
    / 9.8 / uw)]);
disp(['Excess Thrust: ' num2str(thrust - mw*9.8/4.45) ' lbf']);

figure;
plot(cells, motor_power./volts,'x-');
title('Current Draw vs. LiPo Cells');
xlabel('Cells');
ylabel('Amps');

figure;
plot(cells, rpm ./ volts,'x-');
title('k_v vs. LiPo Cells');
xlabel('Cells');
ylabel('k_v');


