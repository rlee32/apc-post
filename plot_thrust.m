function plot_thrust(dirname, plottag)

listing = dir(dirname);
for k = 1:length(listing)
    if listing(k).isdir == 0
        mat = dlmread([dirname '/' listing(k).name],'',3,0);
        plot(mat(:,1), mat(:,8), plottag ...
            , 'DisplayName', [dirname ', ' listing(k).name]);
        hold on;
    end
end
title('Thrust vs. Advance Speed');
ylabel('Thrust (lbf)');
xlabel('Advance Speed (mph)');
legend('show');




