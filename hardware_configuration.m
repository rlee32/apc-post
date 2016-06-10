function hardware_configuration(M,D,T,ME,PL,fixed_kv,fixed_cells,...
    total_props, thrust_efficiency, motor_weight)
% Prints useful information about the necessary hardware
%  characteristics given some operating point and other parameters.
% M: tip Mach number.
% D: rotor diameter in inches.
% T: thrust
% ME: motor efficiency
% PL: power loading, N / kW
% fixed_kv: RPM per volt.
% fixed_cells: LiPo cell count.
% total_props: total number of propellers in stacked coax form.
% thrust_efficiency: coax thrust efficiency (iso-power).
% motor_weight: grams motor mass.

R = D/2.0*0.0254; % radius, m
TS = 343*M; % tip speed m/s
RPM = TS / R * ( 60 / 2 / pi );
TT = T*4.44822;
P = TT / PL / ME * 1000.0;

disp('\n');
disp(['For tip Mach ' num2str(M) ', diameter ' num2str(D) ...
    ' in, power ' num2str(P) ' W, and thrust ' num2str(T) ...
    ' lbf: ']);
disp([' RPM: ' num2str(RPM)]);
effective_volts_per_cell = 3.7;
tmp = RPM / effective_volts_per_cell;
disp([' For fixed Kv of ' num2str(fixed_kv)]);
disp(['  LiPo cell count: ' num2str(tmp / fixed_kv)]);
disp(['  Amps: ' num2str(P / (tmp / fixed_kv) ...
    / effective_volts_per_cell)])
disp([' For fixed cell count of ' num2str(fixed_cells)]);
disp(['  Required Kv: ' num2str(tmp / fixed_cells)]);
disp(['  Amps: ' num2str(P / fixed_cells ...
    / effective_volts_per_cell)]);
disp([' For fixed cell count of ' num2str(fixed_cells) ...
    ' and fixed Kv of ' num2str(fixed_kv)]);
disp(['  RPM: ' num2str( fixed_kv * fixed_cells ...
    * effective_volts_per_cell )]);

% Coaxial configuration
disp(['Estimated total thrust: ' ...
    num2str(T*total_props*thrust_efficiency) ' lbf']);
disp(['Estimated total power: ' ...
    num2str(P*total_props) ' W']);
disp(['Estimated total power loading: ' ...
    num2str(TT*total_props*thrust_efficiency*1000 ...
    / (P*total_props)) ' N/kW']);
disp(['Approximate excess thrust: ' ...
    num2str(T*total_props*thrust_efficiency ...
    - total_props*motor_weight*0.001*9.8/4.44822) ' lbf']);