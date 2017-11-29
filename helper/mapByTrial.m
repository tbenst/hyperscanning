function valByTrial = mapByTrial(func, trialInfoMat, Spikes)
    % func takes @(Spikes)
    startTimes = trialInfoMat(:,11);
    endTimes = trialInfoMat(:,12);

    assert(size(startTimes,1)==size(endTimes,1));
    duration = endTimes - startTimes;

    valByTrial = arrayfun(@(s,e) ...
        applyBetween(func,Spikes,s,e), ...
        startTimes, endTimes, 'UniformOutput', false);
end
