% load('simulation.mat')

m = 25;
n = 25;
centerDistance = 3;
[ W_B_BAR,Y_B_BAR,B_Bar,hasTreeGridList ] = processForestData( extGridList, m, n, centerDistance);

times = 1:length(hasTreeGridList);

figure;
hold;

plot(times,W_B_BAR)
plot(times,Y_B_BAR)
plot(times,B_Bar)
legend('White Birch','Yellow Birch','Beech')
xlabel('Time in Years')
ylabel('Total Basal Area')
title('Total Basal Area of Trees Species over time')
hold off;