dataFile = myFile.dataFile;
adminIdx = myFile.adminIdx;
monkeyNames = myFile.monkeyNames;
conditionA = myFile.conditionA;
conditionB = myFile.conditionB;
expDate = myFile.expDate;

load(dataFile);
taskCodesStruct = taskCodesPDconfigurationFile();
[trialWordCodeCell, trialWordCodeTSCell] = buildTrialWordCodeCell(WordCodes, WordEventTS);
[trialInfoMat, trialInfoMatColumnDescription] = buildTrialInfoMat(trialWordCodeCell, trialWordCodeTSCell, taskCodesStruct);
izzyReward = trialInfoMat(:,8);
peytonReward = trialInfoMat(:,9);


if isfield(myFile, 'swapChannels') & myFile.swapChannels
    Spikes = swapSpikes(Spikes);
end

if isfield(myFile, 'removeOutlierTrials');
    display('not implemented')
    assert(false)
    removeOutlierTrials = myFile.removeOutlierTrials;
    for i=1:length(removeOutlierTrials)
        idx = removeOutlierTrials(i);
        if onlyPreOT & idx<=adminIdx
            trialInfoMat(idx,:) = [];
            trialWordCodeCell(idx) = [];
            trialWordCodeTSCell(idx) = [];
        end
    end
end


if isfield(myFile, 'toggleShuffleSpikes') & myFile.toggleShuffleSpikes
    Spikes = shuffleSpikes(Spikes);
    % Spikes = cellfun(@(u) 1:1:2000, Spikes, 'UniformOutput', false);
end


ntrials = size(trialInfoMat,1);
trialFeedbackTime = feedbackTime(trialWordCodeCell, trialWordCodeTSCell);
firstRewardTime = rewardTime(trialWordCodeCell, trialWordCodeTSCell);

if onlyPreOT
    trialInfoMat = trialInfoMat(1:adminIdx,:);
    trialFeedbackTime = trialFeedbackTime(1:adminIdx,:);
    firstRewardTime = firstRewardTime(1:adminIdx,:);
end

[startTimes endTimes seasons] = getTimePeriod(timePeriod, trialInfoMat, ...
    trialFeedbackTime, firstRewardTime);

if strcmp(shuffleBy,'outcome')
    [shuffledTrialInfoMat shuffledTrialFeedbackTime ...
        shuffledFirstRewardTime] = shuffleTimesByOutcome(trialInfoMat, ...
        trialFeedbackTime, firstRewardTime);
    [shuffledStartTimes shuffledEndTimes] = getTimePeriod(timePeriod, shuffledTrialInfoMat, ...
        shuffledTrialFeedbackTime, shuffledFirstRewardTime);

elseif strcmp(shuffleBy,'trial')
    [shuffledTrialInfoMat shuffledTrialFeedbackTime ...
        shuffledFirstRewardTime] = shuffleTimesByTrial(trialInfoMat, ...
        trialFeedbackTime, firstRewardTime);
    [shuffledStartTimes shuffledEndTimes] = getTimePeriod(timePeriod, shuffledTrialInfoMat, ...
        shuffledTrialFeedbackTime, shuffledFirstRewardTime);
end
