function [newtrialInfoMat newtrialFeedbackTime newfirstRewardTime] = ...
        shuffleTimesByOutcome(trialInfoMat, trialFeedbackTime, firstRewardTime)
    % randomize times for each trial index based on outcome
    % eg randomize neural responses in CC
    myShuffle = @(x) x(randperm(length(x)));
    randOrder = randperm(size(trialInfoMat,1));
    newtrialInfoMat = trialInfoMat;
    newtrialInfoMat(:,11:12) = trialInfoMat(randOrder,11:12);
    newtrialFeedbackTime = trialFeedbackTime(randOrder);
    newfirstRewardTime = firstRewardTime(randOrder);
end
