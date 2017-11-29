function vector = upperTriangle(matrix)
    % Return upper triangle, excluding diagonal, as a vector
    vector = matrix(triu(true(size(matrix)),1));
end
