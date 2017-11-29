function newFunc = f_maybe(f)
    % wrap f such that if its argument is NaN, return NaN
    % otherwise, f might raise an error
    function new = helper(varargin)
        new = wrapper(f,varargin{:});
    end
    newFunc = @helper;

end




function y = wrapper(f, varargin)
    nargs = length(varargin);
    for i=1:nargs
        if ~iscell(varargin{i}) & isnan(varargin{i})
            y = NaN;
            return
        end
    end
    y = f(varargin{:});
end
