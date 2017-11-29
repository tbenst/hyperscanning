function newMatches = topNmatches(costMatrix, matches, n)
    cost = [];
    for i=1:length(costMatrix)
        j = matches(i);
        if j > 0
            cost(i) = costMatrix(i,j);
        else
            cost(i) = Inf;
        end
    end
    [x i] = sort(cost);
    newMatches = zeros(size(matches));
    topN = i(1:n);
    newMatches(topN) = matches(topN);
end
