run('setup.m')

% (unit - unit) symmetric
comparisonFunc = @(A,B,d) distanceBetween(@(a,b) abs(length(a)-length(b))/d, A, B);
[izzyIdx peytonIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);

% % minimize distance of match neurons over global data
neuronsMatch = munkres(comparisonFunc(Spikes(izzyIdx), Spikes(peytonIdx),1));
%
% neuronWeights = normalizeWeights(matchToWeights(neuronsMatch,length(izzyIdx),...
%     length(peytonIdx)),startTimes, ...
%     endTimes, Spikes, comparisonFunc);

reduceFunc = f_maybe(@(x) matchedDistance(neuronsMatch, x));
% reduceFunc = f_maybe(@(x) sum(reshape(neuronWeights.*x,1,[])));
% asymmetric
comparisonFunc = f_maybe(@(A,B) distanceBetween(@(a,b) abs(a-b), A, B));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getFR = @(spikes, duration) num2cell(cellfun(@(s) length(s)/duration, spikes));

izzyByTime = mapByTime(getFR, startTimes, endTimes, Spikes(izzyIdx));
peytonByTime = mapByTime(getFR, startTimes, endTimes, Spikes(peytonIdx));
valByTime = {};
for i=1:length(izzyByTime)
    valByTime{i} = comparisonFunc(izzyByTime{i}, peytonByTime{i});
end;
synchrony = cellfun(@(val) reduceFunc(val), valByTime);
%
% [p tbl stats multcomp] = anovaByOutcome(trialInfoMat,synchrony);
% 'ANOVA for synchrony'
% tbl
% multcomp

% shuffled outcome
shuffledPeytonByTime = mapByTime(getFR, shuffledStartTimes, shuffledEndTimes, Spikes(peytonIdx));
shuffledIzzyByTime = mapByTime(getFR, shuffledStartTimes, shuffledEndTimes, Spikes(izzyIdx));
shuffledValByTime = {};
randomValByTime = {};
for i=1:length(izzyByTime)
    shuffledValByTime{i} = comparisonFunc(shuffledIzzyByTime{i}, peytonByTime{i});
    randomValByTime{i} = comparisonFunc(shuffledIzzyByTime{i}, shuffledPeytonByTime{i});
    % shuffledValByTime{i} = comparisonFunc(izzyByTime{i}, shuffledPeytonByTime{i});
end;
shuffledSynchrony = cellfun(@(val) reduceFunc(val), shuffledValByTime);
randomSynchrony = cellfun(@(val) reduceFunc(val), randomValByTime);
%
% [p tbl stats multcomp] = anovaByOutcome(shuffledTrialInfoMat,shuffledSynchrony);
% 'ANOVA for shuffled Outcome synchrony'
% tbl
% multcomp
%

fig = histSimilarityOutcomeControl(trialInfoMat,synchrony', ...
    [expDate ' distribution of ' timePeriod ' with outcome '], shuffledSynchrony');

if ~strcmp(saveFig,'no')
    saveas(fig, [saveFig expDate '_' 'shuffled-vs-hyperscan_FR-distribution-byOutcome.png'])
end

[CC CD DC DD] = getOutcomes(trialInfoMat);
[CCs CDs DCs DDs] = getOutcomes(shuffledTrialInfoMat);
assert(sum(CCs-CC)==0);
assert(sum(CDs-CD)==0);
assert(sum(DCs-DC)==0);
assert(sum(DDs-DD)==0);

%
% 'ANOVA'
% [p tbl stats multcomp] = anovaByOutcome(trialInfoMat,synchrony);
% tbl
% multcomp
%
% 'ANOVA - shuffled trials'
% [p tbl stats multcomp] = anovaByOutcome(trialInfoMat,shuffledSynchrony);
% tbl
% multcomp

%
% [h p ci] = ttest2(synchrony(CC), shuffledSynchrony(CC));
% CC_ttest__reject__pval_______ci = [h p ci]
% [h p ci] = vartest2(synchrony(CC), shuffledSynchrony(CC));
% CC_vartest__reject__pval_______ci = [h p ci]
%
% [h p ci] = ttest2(synchrony(CD), shuffledSynchrony(CD));
% CD_ttest__reject__pval_______ci = [h p ci]
% [h p ci] = vartest2(synchrony(CD), shuffledSynchrony(CD));
% CD_vartest__reject__pval_______ci = [h p ci]
%
% [h p ci] = ttest2(synchrony(DC), shuffledSynchrony(DC));
% DC_ttest__reject__pval_______ci = [h p ci]
% [h p ci] = vartest2(synchrony(DC), shuffledSynchrony(DC));
% DC_vartest__reject__pval_______ci = [h p ci]
%
% [h p ci] = ttest2(synchrony(DD), shuffledSynchrony(DD));
% DD_ttest__reject__pval_______ci = [h p ci]
% [h p ci] = vartest2(synchrony(DD), shuffledSynchrony(DD));
% DD_vartest__reject__pval_______ci = [h p ci]

% [h p ci] = ttest2(synchrony, shuffledSynchrony);
% all_ttest__reject__pval_______ci = [h p ci]
% [h p ci] = vartest2(synchrony, shuffledSynchrony);
% all_vartest__reject__pval_______ci = [h p ci]


randomNonNaN = find(~arrayfun(@strictIsnan, randomSynchrony));
[h p stats] = archtest(randomSynchrony(randomNonNaN));
randomARCHtest__h____p = [h p]

shuffledNonNaN = find(~arrayfun(@strictIsnan, shuffledSynchrony));
[h p stats] = archtest(shuffledSynchrony(shuffledNonNaN));
shuffledARCHtest__h____p = [h p]

synchronyNonNaN = find(~arrayfun(@strictIsnan, synchrony));
[h p stats] = archtest(synchrony(synchronyNonNaN));
synchronyARCHtest__h____p = [h p]
% Mdl = garch('GARCHLags',1,'ARCHLags',1,'Offset',NaN);
% EstMdl = estimate(Mdl,synchrony(nonNaN));
% tinv(0.05,4)


peytonFRbyTime = cellfun(@(x) mean(cell2mat(x)), peytonByTime(synchronyNonNaN));
izzyFRbyTime = cellfun(@(x) mean(cell2mat(x)), izzyByTime(synchronyNonNaN));
[h p] = archtest(peytonFRbyTime);
peytonARCH__h__p = [h p]
[h p] = archtest(izzyFRbyTime);
izzyARCH__h__p = [h p]

shuffledPeytonFRbyTime = cellfun(@(x) mean(cell2mat(x)), shuffledPeytonByTime(shuffledNonNaN));
shuffledIzzyFRbyTime = cellfun(@(x) mean(cell2mat(x)), shuffledIzzyByTime(shuffledNonNaN));

[h p] = archtest(shuffledPeytonFRbyTime);
shuffledPeytonARCH__h__p = [h p]
[h p] = archtest(shuffledIzzyFRbyTime);
shuffledIzzyARCH__h__p = [h p]

autocorr(synchrony(synchronyNonNaN))
parcorr(synchrony(synchronyNonNaN))

Ytrain = izzyFRbyTime(1:300);
Ytest = izzyFRbyTime(301:350);
Mdl = arima(p,d,q);
[EstMdl,EstParamCov,logL, info] = estimate(Mdl,Ytrain);

Yforecast = zeros(1,50)

Yforecast = forecast(EstMdl,50,'Y0',Ytrain);
pmse = mean((Ytest-Yforecast).^2)

figure
plot(Ytest,'r','LineWidth',2)
hold on
plot(Ytrain,'k--','LineWidth',1.5)
xlim([0,44])
title('Prediction Error')
legend('Observed','Forecast','Location','NorthWest')
hold off
