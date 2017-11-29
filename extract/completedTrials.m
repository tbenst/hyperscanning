function [idx newTrialInfoMat] = completedTrials(trialInfoMat)
    % idx = find(trialInfoMat(:,1)>0 & trialInfoMat(:,2)>0);
    idx = find(trialInfoMat(:,6)==1);
    newTrialInfoMat = trialInfoMat(idx);
end
