function [EstMdl,EstParamCov,logL,E,bic] = seasonalArimaHelper(Y, p, d, q, s, sp, sq)
    Mdl = arima('AR',p,'D',d,'MA',q,'SAR',sp,'SMA',sq, 'Seasonality', s);
    [EstMdl,EstParamCov,logL, info] = estimate(Mdl,Y,'print',false);
    % print(EstMdl,EstParamCov)
    [E V] = infer(EstMdl, Y);
    [h prob] = archtest(E);
    [aic bic] = aicbic(logL, length(info.X), length(Y));
end
