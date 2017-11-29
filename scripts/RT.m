run('setup.m')
RTc = NaN(ntrials,1);
RTd = NaN(ntrials,1);
izzyRTc = NaN(ntrials,1);
izzyRTd = NaN(ntrials,1);
peytonRTc = NaN(ntrials,1);
peytonRTd = NaN(ntrials,1);
for i=1:length(trialInfoMat)
    % top respond first
    if trialInfoMat(i,3)
        if trialInfoMat(i,1)==1
            RTc(i) = trialInfoMat(i,4);
            izzyRTc(i) = trialInfoMat(i,4);
        else
            RTd(i) = trialInfoMat(i,4);
            izzyRTd(i) = trialInfoMat(i,4);
        end
    else
        if trialInfoMat(i,2)==1
            RTc(i) = trialInfoMat(i,5);
            peytonRTc(i) = trialInfoMat(i,5);
        else
            RTd(i) = trialInfoMat(i,5);
            peytonRTd(i) = trialInfoMat(i,5);
        end
    end
end

RTc = take(~isnan(RTc),RTc);
RTd = take(~isnan(RTd),RTd);
izzyRTc = take(~isnan(izzyRTc),izzyRTc);
izzyRTd = take(~isnan(izzyRTd),izzyRTd);
peytonRTc = take(~isnan(peytonRTc),peytonRTc);
peytonRTd = take(~isnan(peytonRTd),peytonRTd);

totalCoop = length(RTc)
totalDefect = length(RTd)
totalIzzyCoop = length(izzyRTc)
totalIzzyDefect = length(izzyRTd)
totalPeytonCoop = length(peytonRTc)
totalPeytonDefect = length(peytonRTd)
meanCoopTime = mean(RTc)
meanDefectTime = mean(RTd)
meanPeytonCoopTime = mean(peytonRTc)
meanPeytonDefectTime = mean(peytonRTd)
meanIzzyCoopTime = mean(izzyRTc)
meanIzzyDefectTime = mean(izzyRTd)
[rejectNull pVal] = ttest2(RTc, RTd)
