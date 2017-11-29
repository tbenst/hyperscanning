function firingRate = spikesToFR(Spikes, varargin)
    spikes = cell2mat(Spikes(:));
    lastTime = max(spikes);

    p = inputParser;
    addRequired(p,'Spikes');
    addOptional(p,'duration',lastTime);
    addOptional(p,'bandwidth',150);
    addOptional(p,'resolution',1000);
    parse(p,Spikes,varargin{:});
    bandwidth = p.Results.bandwidth;
    resolution = p.Results.resolution;
    duration = p.Results.duration;

    firingRate = spikeTrainToFR(spikes, lastTime, bandwidth, resolution);
end
