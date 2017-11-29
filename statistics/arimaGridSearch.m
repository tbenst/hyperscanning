hefunction BICs = arimaGridSearch(Y,varargin)
    p = inputParser;
    differenceDefault = 0;
    addOptional(p,'difference',differenceDefault);
    parse(p,varargin{:});
    d = p.Results.difference;

    maxP = 3;
    maxQ = 3;
    varNames = {};
    rowNames = {};
    for i=0:maxP
        rowNames{i+1} = ['p' num2str(i)];
    end
    for i=0:maxQ
        varNames{i+1} = ['q' num2str(i)];
    end
    BICs = array2table(zeros(maxP+1, maxQ+1),'VariableNames',varNames, ...
        'RowNames', rowNames);


    for p=0:maxP
        for q=0:maxQ
            Mdl = arima(p,d,q);
            [EstMdl,EstParamCov,logL, info] = estimate(Mdl,Y,'print',false);
            [E V] = infer(EstMdl, Y);
            [h prob] = archtest(E);
            [aic bic] = aicbic(logL, length(info.X), length(Y));
            BICs{p+1,q+1} = bic;
        end
    end

end
