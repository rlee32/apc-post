function plot_power_loading(dirname, plottag)

listing = dir(dirname);
for k = 1:length(listing)
    if listing(k).isdir == 0
        mat = dlmread([dirname '/' listing(k).name],'',3,0);
        plot(mat(:,1), mat(:,8)./mat(:,6), plottag ...
            , 'DisplayName', [dirname ', ' listing(k).name]);
        hold on;
    end
end
title('Power Loading vs. Advance Speed');
ylabel('Power Loading (lbf / hp)');
xlabel('Advance Speed (mph)');
legend('show');




