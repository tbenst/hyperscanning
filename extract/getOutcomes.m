function [CC CD DC DD] = getOutcomes(trialInfoMat)
    CC = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==1);
    DD = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==2);
    CD = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==2);
    DC = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==1);
end
