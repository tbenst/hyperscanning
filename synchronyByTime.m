function [synchrony valByTime] = synchronyByTime(startTimes, endTimes, Spikes, ...
            comparisonFunc, reduceFunc)
    % comparisonFunc should take @(SpikesA, SpikesB)
    % and reduce should collapse whatever comparisonFunc returns
    % e.g. a Map-Reduce paradigm, where the map takes two arguments

    [aIdx bIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);
    func = @(spikes, duration) ...
            comparisonFunc(spikes(aIdx), spikes(bIdx), duration);
    % valByTime can be anything--value, matrix, etc.
    valByTime = mapByTime(func, startTimes, endTimes, Spikes);
    synchrony = cellfun(@(val) reduceFunc(val), valByTime);
end
