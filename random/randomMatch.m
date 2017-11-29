function matching = randomMatch(M)
    [nrows ncols] = size(M);
    assert(nrows>=ncols);
    matching = zeros(1,nrows);
    matching(1:ncols) = 1:ncols;
    matching(randperm(nrows)) = matching;
end
