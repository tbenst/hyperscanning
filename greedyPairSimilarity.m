function [pairs similarities] = greedyPairSimilarity(distanceMat)
    % rows and columns represent neurons on different brains
    % Pairs by maximum similarity score
    npairs = min(size(distanceMat));
    pairs = zeros(2,npairs);
    similarities = zeros(1,npairs);

    remaining = distanceMat
    for i=1:npairs
        [row col] = indexOfMax(remaining);
        pairs(:,i) = [row col];
        similarities(i) = val;
        remaining(row,:) = 0;
        remaining(:,col) = 0;
    end
end
