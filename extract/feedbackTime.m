function trialFeedbackTime = feedbackTime(trialWordCodeCell, trialWordCodeTSCell)
    trialNum = size(trialWordCodeCell,1);
    trialFeedbackTime = NaN(trialNum,1);
    for t = 1:size(trialWordCodeCell,1)
        idx = find(ismember(trialWordCodeCell{t},81:84));
        try
            assert(numel(idx)<=1)
        catch
            display(numel(idx))
            error()
        end
        if size(idx,1)
            trialFeedbackTime(t) = trialWordCodeTSCell{t}(idx(1));
        end
    end
end
