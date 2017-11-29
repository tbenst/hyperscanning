function [newtrialInfoMat newtrialFeedbackTime newfirstRewardTime] = ...
        shuffleTimesByOutcome(trialInfoMat, trialFeedbackTime, firstRewardTime)
    % randomize times for each trial index based on outcome
    % eg randomize neural responses in CC
    [CC CD DC DD] = getOutcomes(trialInfoMat);
    myShuffle = @(x) x(randperm(length(x)));
    CCr = myShuffle(CC);
    CDr = myShuffle(CD);
    DCr = myShuffle(DC);
    DDr = myShuffle(DD);
    newtrialInfoMat = trialInfoMat;
    newtrialFeedbackTime = trialFeedbackTime;
    newfirstRewardTime = firstRewardTime;
    newtrialInfoMat([CCr; CDr; DCr; DDr],11:12) = trialInfoMat([CC; CD; DC; DD],11:12);
    newtrialFeedbackTime([CCr; CDr; DCr; DDr]) = trialFeedbackTime([CC; CD; DC; DD]);
    newfirstRewardTime([CCr; CDr; DCr; DDr]) = firstRewardTime([CC; CD; DC; DD]);
end
