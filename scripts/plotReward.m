setup();
fig = figure();
nonNaN = completedTrials(trialInfoMat);
noReward = find(peytonReward==-1);
izzyReward(noReward) = 0;
peytonReward(noReward) = 0;
bar(1:length(izzyReward), -peytonReward, 1, 'b')
ylim([-7 7])
hold on
bar(1:length(izzyReward), izzyReward, 1, 'r')
legend({'Peyton' 'Izzy'})

title(['Trial reward ' expDate])
xlabel('Trial #')
ylabel('Reward amount')
yt = yticks;
yticklabels(abs(yticks))


if ~strcmp(saveFig,'no')
    filename = [saveFig expDate '_' 'reward.png'];
    ['saving ' filename]
    saveas(fig, filename);
end
