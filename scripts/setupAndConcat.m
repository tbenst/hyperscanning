nrows = size(Spikes,1);
ncols = size(Spikes,2);
[trialWordCodeCell, trialWordCodeTSCell] = buildTrialWordCodeCell(WordCodes, ...
    WordEventTS);
adjStartTime = max(allTrialWordCodeTSCell{end}) + seperationTime;
trialWordCodeTSCell =  cellfun(@(times) times + adjStartTime, ...
    trialWordCodeTSCell, 'UniformOutput', false);
trialInfoMat = buildTrialInfoMat(...
    trialWordCodeCell, trialWordCodeTSCell, taskCodesStruct);
if strcmp(monkeyNames{1},'Peyton')
    % swap electrode ordering
    Spikes = swapSpikes(Spikes);
end
Spikes = cellfun(@(spikeTrain) spikeTrain+adjStartTime, Spikes, ...
    'UniformOutput', false);

allTrialWordCodeCell = [allTrialWordCodeCell; trialWordCodeCell];
allTrialWordCodeTSCell = [allTrialWordCodeTSCell; trialWordCodeTSCell];
allTrialInfoMat = [allTrialInfoMat; trialInfoMat];
for i=1:size(allSpikes,1)
    for j=1:size(allSpikes,2)
        if i<=nrows & j<=ncols & ~isempty(Spikes(i,j))
            allSpikes{i,j} = [allSpikes{i,j}; Spikes{i,j}];
        end
    end
end

% not needed as Izzy is always top
% function trialInfoMat = swapColumnsToIzzyPeyton(PeytonIzzyTrialInfoMat)
%     % swap (1,2), (4,5), (8,9)
%     trialInfoMat = PeytonIzzyTrialInfoMat(:,[2,1,3,5,4,6,7,9.8,10,11,12]);
%     % NOT topRespFirst
%     trialInfoMat(3) = not(PeytonIzzyTrialInfoMat(3));
%     % NOT topRewardFirst
%     trialInfoMat(10) = not(PeytonIzzyTrialInfoMat(10));
% end
