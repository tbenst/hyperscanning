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

izzyFRbyTime = cellfun(@(x) mean(cell2mat(x)), izzyByTime);
peytonFRbyTime = cellfun(@(x) mean(cell2mat(x)), peytonByTime);
completed = completedTrials(trialInfoMat)';
completedTriple = sort([3*completed-2 3*completed-1 3*completed]);
% myNaN = find(isnan(peytonFRbyTime));
% peytonFRbyTime(myNaN) = 0;
% izzyFRbyTime(myNaN) = 0;
peytonFRbyTime = peytonFRbyTime(completedTriple);
izzyFRbyTime = izzyFRbyTime(completedTriple);
fig = figure('units','inches');
set(fig,'pos',[0 0 6.5 9])
subplot(4,1,1)
crosscorr(izzyFRbyTime,peytonFRbyTime)
title(['Cross-correlation between Izzy & Peyton for ' expDate])

subplot(4,1,2)
crosscorr(izzyFRbyTime(1:450),peytonFRbyTime(1:450))
title('Trials 1-150')

subplot(4,1,3)
crosscorr(izzyFRbyTime(451:900),peytonFRbyTime(451:900))
title('Trials 151-300')

subplot(4,1,4)
e = length(izzyFRbyTime);
crosscorr(izzyFRbyTime(901:e),peytonFRbyTime(901:e))
title(['Trials 301-' num2str(e/3)])



if ~strcmp(saveFig,'no')
    filename = [saveFig expDate '_' 'crosscorr.png'];
    ['saving ' filename]
    saveas(fig, filename);
end
