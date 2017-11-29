function valByTrial = mapByTime(func, startTimes, endTimes, Spikes)
    % func takes @(Spikes, duration)
    assert(size(startTimes,1)==size(endTimes,1));
    duration = endTimes - startTimes;

    valByTrial = arrayfun(@(s,e) ...
        applyBetween(func,Spikes,s,e), ...
        startTimes, endTimes, 'UniformOutput', false);
end
