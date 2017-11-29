function elements = take(condition, x)
    idx = find(condition);
    elements = x(idx);
end
