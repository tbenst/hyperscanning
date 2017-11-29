run('setup.m')

[izzyIdx peytonIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);
izzyNeurons = Spikes(izzyIdx);
peytonNeurons = Spikes(peytonIdx);
izzyFR = mapByTime(@(x,d) (cellfun(@length, x)./d), startTimes, endTimes, ...
    izzyNeurons);
peytonFR = mapByTime(@(x,d) (cellfun(@length, x)./d), startTimes, endTimes, ...
    peytonNeurons);
% (nTrials, nNeurons)
outcomes = trialOutcomes(trialInfoMat);
vals = {'DD' 'DC' 'CD' 'CC', 'N'};
valueMap = containers.Map(vals, 1:length(vals));
outcomes = cellfun(@(x) valueMap(x), outcomes);
idx = intersect(find(outcomes~=5), find(cellfun(@(x) ~strictIsnan(x),izzyFR)));
completed = outcomes(idx);
completedIzzyFR = cell2mat(izzyFR(idx));
completedPeytonFR = cell2mat(peytonFR(idx));


colors = flipud(hsv(4));
Iz = tsne(completedIzzyFR,'Algorithm','exact','Distance', 'seuclidean');
if fnum==1
    fig = figure('units','inches');
    set(gcf,'pos',[0 0 16 8])
end

subplot(3,4,fnum)
gscatter(Iz(:,1),Iz(:,2),completed,colors,[],[],'off')
if fnum==1
    legend(vals(1:4))
end
title(['IzzyFR t-SNE for ' expDate])

Pey = tsne(completedPeytonFR,'Algorithm','exact','Distance', 'seuclidean');
subplot(3,4,4+fnum)
gscatter(Pey(:,1),Pey(:,2),completed,colors,[],[],'off')
% legend(vals(1:4))
title(['PeytonFR t-SNE for ' expDate])

both = tsne([completedIzzyFR completedPeytonFR],'Algorithm','exact','Distance', 'seuclidean');
subplot(3,4,8+fnum)
gscatter(both(:,1),both(:,2),completed,colors,[],[],'off')
% legend(vals(1:4))
title(['combined t-SNE for ' expDate])


if ~strcmp(saveFig,'no')
    fname = [saveFig 'tSNE_seuclidean_' timePeriod '_FR.png']
    saveas(fig, [saveFig 'tSNE_seuclidean_' timePeriod '_FR.png']);
end
