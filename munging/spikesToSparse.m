function sparseMat = spikesToSparse(Spikes, varargin)
    % optional parameter 'Resolution'
    if length(varargin)==1
        resolution = varargin(1);
    else
        resolution = 1000;
    end


    spikes = nonEmptyCell(Spikes)
    maxes = cellfun(@max, spikes, 'UniformOutput', false);
    lastTime = max(cell2mat(maxes(:)));

    sparseMat = sparse(ceil(lastTime*resolution), length(spikes));

    for unit = 1:length(spikes)
        idx = ceil(spikes{unit}*resolution);
        sparseMat(idx,unit) = 1;
    end
end
