function [pairs distances] = greedyPairDistance(distanceMat)
    % rows and columns represent neurons on different brains
    % Pairs by maximum similarity score
    npairs = min(size(distanceMat));
    pairs = zeros(2,npairs);
    distances = zeros(1,npairs);

    remaining = distanceMat;
    for i=1:npairs
        [row col val] = indexOfMin(remaining);
        pairs(:,i) = [row col];
        distances(i) = val;
        remaining(row,:) = Inf;
        remaining(:,col) = Inf;
    end
end
