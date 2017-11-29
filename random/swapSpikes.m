function newSpikes = swapSpikes(Spikes)
    nrows = size(Spikes,1);
    newRows = vertcat([49:nrows 1:48]);
    newSpikes = Spikes(newRows,:);
end
