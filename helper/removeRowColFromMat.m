function newMat = removeRowColFromMat(mat, row, col)
    % remove the specified column and row from matrix
    newMat = zeros(size(mat)-1);
    iNew = 1;
    jNew = 1;
    for i=1:size(mat,1)
        if i==row
            continue
        else
            for j=1:size(mat,2)
                if j==col
                    continue
                else
                    newMat(iNew,jNew) = mat(i,j);
                    jNew = jNew + 1;
                end
            end
            iNew = iNew + 1;
            jNew = 1;
        end
    end
end
