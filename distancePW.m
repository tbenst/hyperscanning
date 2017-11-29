function distanceMat = distancePW(func, myCell)
    len = length(myCell);
    distanceMat = zeros(len,len);

    % assume diagonal is 0
    % calculate lower triangle first

    for i = 1:len
        if i>1
            for j = 1:(i-1)
                distanceMat(i,j) = func(myCell{i}, myCell{j});
            end
        end
    end

    % % copy to upper triangle
    for j = 2:len
        for i = 1:(j-1)
            distanceMat(i,j) = distanceMat(j,i);
        end
    end
end
