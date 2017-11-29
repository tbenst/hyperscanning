function firingRate = spikeTrainToFR(spikeTrain, varargin)
    lastTime = max(spikeTrain);
    p = inputParser;
    addRequired(p,'spikeTrain');
    addOptional(p,'duration',lastTime);
    addOptional(p,'bandwidth',150);
    addOptional(p,'resolution',1000);
    parse(p,spikeTrain,varargin{:});
    bandwidth = p.Results.bandwidth;
    resolution = p.Results.resolution;
    duration = p.Results.duration;

    width = round(bandwidth*6);
    window = fspecial('gaussian',[width 1],bandwidth);
    idx = ceil(spikeTrain*resolution);
    binnedSpikes = zeros(ceil(duration)*resolution,1);
    binnedSpikes(idx) = 1;
    firingRate = conv(binnedSpikes, window, 'same');
end
