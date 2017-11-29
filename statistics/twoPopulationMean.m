function z = twoPopulationMean(A,B)
    % using pooled std
    nA = length(A);
    nB = length(B);
    SDp = sqrt(((nA-1)*var(A) + (nB-1)*var(B))/(nA+nB-2));
    z = (mean(A) - mean(B)) / (SDp * sqrt(1/nB + 1/nB));
end
