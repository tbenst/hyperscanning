function dist = matchedDistance(matches, distanceMatrix)
    dist = 0;
    for i=1:length(matches)
        j = matches(i);
        if j==0
            continue
        else
            dist = dist+distanceMatrix(i,j);
        end
    end
end
