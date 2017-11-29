function [row col val] = indexOfMin(mat)
    [m col] = min(min(mat));
    [val row] = min(mat(:,col));
end
