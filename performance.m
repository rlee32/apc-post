clear; clc; close all;

listing = dir('processed');
data = {};
for k = 1:length(listing)
    if listing(k).isdir == 0
        data = [data, { listing(k).name }]; 
    end
end
data = { 'PER3_15x55MR.dat', ...
     'PER3_16x4E.dat', ...
     'PER3_16x55MR.dat', ...
     'PER3_17x6E.dat', ...
     'PER3_18x55MR.dat', ...
     'PER3_20x8E.dat', ...
     'PER3_19x8E.dat', ...
     'PER3_27x13E.dat', ...
     'PER3_22x8.dat' ... % 'PER3_24x12E.dat', 'PER3_26x13E.dat', 'PER3_27x13E.dat', 'PER3_13x65E.dat', 'PER3_13x55EP.dat'
     };
patterns = '+xosd^><v';





figure;
for k = 1:length(data)
    mat = dlmread(['processed/' data{k}]);
    name = strrep(data{k}, 'PER3_', '');
    name = strrep(name, '.dat', '');
    plot(mat(:,2), mat(:,3), ['-', patterns(mod(k,length(patterns))+1)] ...
        , 'DisplayName', name);
    hold on;
end
axis( [10, 60, 20, 80] );
legend('show');
xlabel('Static Thrust (lb_f)');
ylabel('Power Loading (N / kW)');
% ylabel('Static Thrust (lb_f)');
% xlabel('Tip Mach Number');







figure;
for k = 1:length(data)
    mat = dlmread(['processed/' data{k}]);
    name = strrep(data{k}, 'PER3_', '');
    name = strrep(name, '.dat', '');
    plot(mat(:,1), mat(:,2), ['-', patterns(mod(k,length(patterns))+1)] ...
        , 'DisplayName', name);
    hold on;
end
axis( [0, 0.4, 0, 40] );
legend('show');
xlabel('Tip Mach number');
ylabel('Static Thrust (lb_f)');


