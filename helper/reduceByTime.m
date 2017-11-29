function accum = reduceByTime(reduceFunc, x, varargin)
    % assumes 3d matrix or cell of 2d matrix
    p = inputParser;
    addOptional(p,'initial','none');
    parse(p,varargin{:});
    accum = p.Results.initial;
    theSize = NaN;


    if strcmp(accum,'none')
        if iscell(x)
            for t=1:length(x)
                if ~isnan(x{t})
                    theSize = size(x{t});
                    break
                end
            end
        else
            for t=1:length(x)
                if ~isnan(x(t))
                    theSize = size(x(t));
                    break
                end
            end
        end
        if isnan(theSize)
            error('all NaN')
        end
        accum = zeros(theSize);
    end

    if iscell(x)
        for t=1:length(x)
            for i=1:size(x{1},1)
                for j=1:size(x{1},2)
                    accum(i,j) = reduceFunc(accum(i,j), x{t}(i,j));
                end
            end
        end
    else
        for t=1:length(x)
            for i=1:size(x(1),1)
                for j=1:size(x(1),2)
                    accum(i,j) = reduceFunc(accum(i,j), x(t,i,j));
                end
            end
        end
    end
end
