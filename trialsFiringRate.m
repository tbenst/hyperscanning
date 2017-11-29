function trialsFR = trialsFiringRate(trialInfoMat, Spikes)
    % Split into the two monkeys, and return units with non-zero firing rate
    nonempty_Spikes = find(~cellfun(@isempty,Spikes));
    spikes = Spikes(nonempty_Spikes);

    startTimes = trialInfoMat(:,11);
    endTimes = trialInfoMat(:,12);

    trialsFR = firingRate(spikes, startTimes, endTimes);

end

function fr = firingRate(Spikes, startTimes, endTimes)
    % return firing rate of each unit during a time window
    assert(size(startTimes,1)==size(endTimes,1));
    duration = endTimes - startTimes;

    % Spikes is a cell of cells
    % we transpose so cell2mat gives dimensions (ntrial, nunits)
    fr = cell2mat(arrayfun(@(s,e) ...
        cell2mat(cellfun(@(unitSpikes) ...
            unitFiringRate(unitSpikes,s,e), ...
            Spikes, 'UniformOutput', false))', ...
        startTimes, endTimes, 'UniformOutput', false));

end

function ufr = unitFiringRate(unitSpikes, startTime, endTime)
    spikes = take(unitSpikes >= startTime & unitSpikes < endTime, unitSpikes);
    duration = endTime - startTime;
    ufr = size(spikes,1)/duration;
end
