function weights = matchToWeights(matches,nrows,ncols)
    weights = zeros(nrows,ncols);
    for i=1:length(matches)
        j = matches(i);
        if j==0
            continue
        else
            weights(i,j) = 1;
        end
    end
end
