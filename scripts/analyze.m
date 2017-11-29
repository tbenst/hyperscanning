run('setup.m')

% plot chronological RDM
% [rdmA rdmB similarity] = behaviorRDM(Spikes, trialInfoMat, 'plot', true, ...
%     'trialOrder', {[1];[2:adminIdx+1];[(adminIdx+2):ntrials]}, ...
%     'labels', {'','pre',conditionA;'','pre',conditionB}, ...
%     'monkeyNames', monkeyNames);

% plotAll(Spikes, trialInfoMat, adminIdx, conditionA, conditionB, monkeyNames);
% plotAll(shuffleSpikes(Spikes), trialInfoMat, adminIdx, conditionA, conditionB, {'random A', 'random B'});


% % pairwise VP
% comparisonFunc = @(A,B,d) distanceBetween(@(a,b) victorPurpura(a,b,4), A, B);

% % spike count A - spike count B
% comparisonFunc = @(A,B,d) cellMapReduce(@length, @sum, A) - ../d.
%         cellMapReduce(@length, @sum, B);

% % (unit - unit) asymmetric
% comparisonFunc = @(A,B,d) distanceBetween(@(a,b) length(a)-length(b), A, B);

% (unit - unit) symmetric
comparisonFunc = @(A,B,d) distanceBetween(@(a,b) abs(length(a)-length(b))/d, A, B);
%
reduceFunc = @(x) sum(x(:));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hungarian algorithm to minimize distance of match neurons %
% Choose one of (A) or (B)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reduceFunc = @(x) paren(munkres(x),2);

[izzyIdx peytonIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);

%%%%%%%%%%%%%%%%% A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % minimize distance of match neurons over global data
neuronsMatch = munkres(comparisonFunc(Spikes(izzyIdx), Spikes(peytonIdx),1));

neuronWeights = normalizeWeights(matchToWeights(neuronsMatch,length(izzyIdx),...
    length(peytonIdx)),startTimes, ...
    endTimes, Spikes, comparisonFunc);
%
% %%%%%%%%%%%%%%%% B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calc spike count distribution per neuron
% FRbyTrial_A = mapByTrial(@(spikes, duration) cellfun(@(unit) length(unit)/duration, spikes), ...
%                 trialInfoMat, Spikes(izzyIdx));
% FRbyTrial_B = mapByTrial(@(spikes, duration) cellfun(@(unit) length(unit)/duration, spikes), ...
%                 trialInfoMat, Spikes(peytonIdx));
%
% trialSCbyNeuron_A = arrayfun(@(i) cell2mat(cellfun(@(trial) trial(i), FRbyTrial_A, ...
%                                  'UniformOutput', false)), ...
%                              1:length(izzyIdx), 'UniformOutput', false);
% trialSCbyNeuron_B = arrayfun(@(i) cell2mat(cellfun(@(trial) trial(i), FRbyTrial_B, ...
%                                  'UniformOutput', false)), ...
%                              1:length(peytonIdx), 'UniformOutput', false);
% distA = cellfun(@(unit) fitdist(unit,'Kernel'),...
%                 trialSCbyNeuron_A, 'UniformOutput', false);
% distB = cellfun(@(unit) fitdist(unit,'Kernel'),...
%                 trialSCbyNeuron_B, 'UniformOutput', false);
% % symmetric KL divergence, per original definition by Kullback and Leibler
% comparisonFunc = @(A,B,d) distanceBetween(@(a,b) KLdivergence(a,b), A, B);
% costMatrix = comparisonFunc(distA, distB);
% neuronsMatch = munkres(costMatrix);
%
% possibleMatches = min(length(izzyIdx), length(peytonIdx));
% numMatched = length(find(neuronsMatch>0));
% if numMatched < possibleMatches
%     ['warning: only matched ' num2str(numMatched) ' / ' ...
%         num2str(possibleMatches) ' neurons']
% end

%%%%%%%%%%%%%%%%%%%%% for both A & B %%%%%%%%%%%%%%%%%%%%%%%%%%
if toggleRandomMatch
    neuronsMatch = randomMatch(comparisonFunc(Spikes(izzyIdx), Spikes(peytonIdx),1));
end
reduceFunc = f_maybe(@(x) matchedDistance(neuronsMatch, x));
% reduceFunc = f_maybe(@(x) sum(reshape(neuronWeights.*x,1,[])));
% switch back to asymmetric
comparisonFunc = @(A,B,d) distanceBetween(@(a,b) (length(a)-length(b))/d, A, B);
% comparisonFunc = @(A,B,d) distanceBetween(@(a,b) abs(length(a)-length(b))/d, A, B);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[synchrony SCdiffByTrial] = synchronyByTime(startTimes, endTimes, Spikes, ...
    comparisonFunc, reduceFunc);

[izzyNeurons peytonNeurons] = getMatchedNeurons(neuronsMatch, ...
    Spikes(izzyIdx), Spikes(peytonIdx));
izzyFR = cell2mat(mapByTime(@(x,d) cellMapReduce(@length, @sum, x)/d, startTimes, endTimes, ...
    izzyNeurons));
peytonFR = cell2mat(mapByTime(@(x,d) cellMapReduce(@length, @sum, x)/d, startTimes, endTimes, ...
    peytonNeurons));


[myMax iMax] = max(endTimes-startTimes);
[myMin iMin] = min(endTimes-startTimes);
notNaN = find(~isnan(startTimes) & ~isnan(endTimes));
myMean = mean(endTimes(notNaN)-startTimes(notNaN));
[CC CD DC DD] = getOutcomes(trialInfoMat);

%%%%%%%%%%%%%%% misc stats
% {'max(endTimes-startTimes)' myMax 'idx' iMax}
% {'mean(endTimes-startTimes)' myMean}
% {'min(endTimes-startTimes)' myMin 'idx' iMin}
% trialDuration = startTimes-endTimes;
% {'CC avg duration' mean(trialDuration(CC))}
% {'CD avg duration' mean(trialDuration(CD))}
% {'DC avg duration' mean(trialDuration(DC))}
% {'DD avg duration' mean(trialDuration(DD))}


% valueMap = containers.Map({'CC', 'CD', 'DC', 'DD'}, [1, 0, 0, 1]);
% reg = similarityRegression(trialInfoMat,synchrony, valueMap)
[p tbl stats multcomp] = anovaByOutcome(trialInfoMat,synchrony);
fig = histSimilarityOutcome(trialInfoMat,synchrony, ...
    [expDate ' distribution of ' timePeriod ' with outcome ']);
    % [expDate ' distribution of ' timePeriod ' with outcome '], izzyFR, peytonFR);

if ~strcmp(saveFig,'no')
    saveas(fig, [saveFig expDate '_' 'FR-distribution-byOutcome.png'])
end
% stats
%
'ANOVA for synchrony'
tbl
multcomp
%
% 'ANOVA for Izzy'
% [p tbl stats multcomp] = anovaByOutcome(trialInfoMat,izzyFR);
% tbl
% multcomp
%
% 'ANOVA for Peyton'
% [p tbl stats multcomp] = anovaByOutcome(trialInfoMat,peytonFR);
% tbl
% multcomp



% 'izzy null hypothesis: DD-DC=0'
% [h,p] = ttest2(izzyFR(DD),izzyFR(DC))
% 'izzy null hypothesis: CC-CD=0'
% [h,p] = ttest2(izzyFR(CC),izzyFR(CD))
%
% 'peyton null hypothesis: DD-CD=0'
% [h,p] = ttest2(peytonFR(DD),peytonFR(CD))
% 'peyton null hypothesis: CC-DC=0'
% [h,p] = ttest2(peytonFR(CC),peytonFR(DC))
