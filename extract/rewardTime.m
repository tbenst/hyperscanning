function [firstReward secondReward] = rewardTime(trialWordCodeCell, trialWordCodeTSCell)
    trialNum = size(trialWordCodeCell,1);
    firstReward = NaN(trialNum,1);
    secondReward = NaN(trialNum,1);
    for t = 1:size(trialWordCodeCell,1)
        firstIdx = find(ismember(trialWordCodeCell{t},[60 64]));
        if size(firstIdx,1)
            firstReward(t) = trialWordCodeTSCell{t}(firstIdx(1));
        secondIdx = find(ismember(trialWordCodeCell{t},[62 66]));
        if size(secondIdx,1)
            secondReward(t) = trialWordCodeTSCell{t}(secondIdx(1));
        end
    end
end
