function [matchedA matchedB] = getMatchedNeurons(matches, neuronsA, neuronsB)
    matchedA = {};
    matchedB = {};
    m = 1;
    for i=1:length(matches)
        j = matches(i);
        if j==0
            continue
        else
            matchedA(m) = neuronsA(i);
            matchedB(m) = neuronsB(j);
            m = m+1;
        end
    end
end
