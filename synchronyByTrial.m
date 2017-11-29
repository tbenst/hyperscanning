function [synchrony valByTrial] = synchronyByTrial(trialInfoMat, Spikes, ...
            comparisonFunc, reduceFunc)
    % comparisonFunc should take @(SpikesA, SpikesB)
    % and reduce should collapse whatever comparisonFunc returns
    % e.g. a Map-Reduce paradigm, where the map takes two arguments
    [aIdx bIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);
    display('warning: not using duration for func')
    func = @(spikes, duration) ...
            comparisonFunc(spikes(aIdx), spikes(bIdx), duration);
    % valByTrial can be anything--value, matrix, etc.
    valByTrial = mapByTrial(func, trialInfoMat, Spikes);
    synchrony = cellfun(@(val) reduceFunc(val), valByTrial);
end
