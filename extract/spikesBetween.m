function spikes = spikesBetween(Spikes,startTime, stopTime)
    spikes = cellfun(@(unit) take(unit>=startTime & unit < stopTime, unit), ...
        Spikes, 'UniformOutput', false);
end
