function [] = arimaHelper(Y, p, d, q)
    Mdl = arima(p,d,q);
    [EstMdl,EstParamCov,logL, info] = estimate(Mdl,Y,'print',false);
    [E V] = infer(EstMdl, Y);
    [h prob] = archtest(E);
    [aic bic] = aicbic(logL, length(info.X), length(Y));
end
