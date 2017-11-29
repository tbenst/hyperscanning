function [normWeights vbt ]= normalizeWeights(weights, startTimes, endTimes, ...
        Spikes, comparisonFunc)
    % comparisonFunc should take @(SpikesA, SpikesB)
    [aIdx bIdx] = splitSpikes(Spikes, 48, size(Spikes,1)-48);
    func = @(spikes, duration) ...
            comparisonFunc(spikes(aIdx), spikes(bIdx), duration);
    valByTime = mapByTime(func, startTimes, endTimes, Spikes);
    % vals = reduceByTime(concatCellbyCell,valByTime,{});
    normalized = reduceByTime(f_maybe(@(a,n) max([a n])), ...
        nonNaNcell(valByTime));
    normWeights = 1./normalized;
    normWeights = normWeights.*weights;
end

function w = normed(x)
    xmin = min(x);
    xmax = max(x);
    w = (x-xmin)/(xmax-xmin);
end
