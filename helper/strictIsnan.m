function bool = strictIsnan(x)
    % a strict isnan
    % necessary because Matlab ignores 30 years of PLT research
    bool = all(size(x)==[1 1]) & isnan(x(1));
end
