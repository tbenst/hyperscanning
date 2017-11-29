function val = applyBetween(func, Spikes, startTime, endTime)
    % func takes (spikes, duration)
    if isnan(startTime) | isnan(endTime)
        val = NaN;
    else
        spikes = cellfun(@(unitSpikes) ...
            take(unitSpikes >= startTime & unitSpikes < endTime, unitSpikes), ...
                 Spikes,  'UniformOutput', false);
        duration = endTime - startTime;
        val = func(spikes, duration);
    end
end
