function [aIdx bIdx] = splitSpikes(Spikes, aRows, bRows)
    nonemptyIdx = find(~cellfun(@isempty,Spikes(:)));
    [nrows ncols] = size(Spikes);
    assert(aRows+bRows==nrows);
    aIdx = 1:aRows;
    bIdx = (aRows+1):nrows;
    if ncols==1
        return
    else
        for i=1:(ncols-1)
            aIdx = horzcat(aIdx,i*nrows+(1:aRows));
            bIdx = horzcat(bIdx,i*nrows+((aRows+1):nrows));
        end
    end
    aIdx = take(ismember(aIdx,nonemptyIdx), aIdx);
    bIdx = take(ismember(bIdx,nonemptyIdx), bIdx);
end
