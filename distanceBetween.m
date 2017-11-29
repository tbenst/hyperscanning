function distanceMat = distanceBetween(func, cellA, cellB)
    % calc pairwise distance drawing one from A and one from B
    lenA = length(cellA);
    lenB = length(cellB);
    distanceMat = zeros(lenA,lenB);

    for a = 1:lenA
        for b = 1:lenB
            distance = func(cellA{a}, cellB{b});
            distanceMat(a,b) = distance;
        end
    end

end
