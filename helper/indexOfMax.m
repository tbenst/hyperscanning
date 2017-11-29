function [row col val] = indexOfMax(mat)
    [m col] = max(max(mat));
    [val row] = max(mat(:,col));
end
