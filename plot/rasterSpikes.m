function rasterSpikes(Spikes, varargin)
    p = inputParser;
    addRequired(p,'Spikes');
    addOptional(p,'startTime',0);
    lastTime = max(cell2mat(Spikes(:)));
    addOptional(p,'stopTime',lastTime);
    addOptional(p,'trialStartTime',[]);
    addOptional(p,'feedbackTime',[]);
    addOptional(p,'trialEndTime',[]);
    addOptional(p,'result',[]);
    addOptional(p,'saveFile',[]);
    parse(p,Spikes,varargin{:});
    stopTime = p.Results.stopTime;
    startTime = p.Results.startTime;
    trialStartTime = p.Results.trialStartTime;
    idx = find(trialStartTime>=startTime & ...
        trialStartTime < stopTime);
    trialStartTime = trialStartTime(idx);
    trialEndTime = p.Results.trialEndTime(idx);
    feedbackTime = p.Results.feedbackTime(idx);
    result = p.Results.result(idx);

    nUnits = length(Spikes);
    hold on;
    for i = 1:nUnits
        if i>48
            i = i + 1;
        end
        spikes = spikesBetween(Spikes, startTime, stopTime);
        spikesSize = size(spikes{i});
        line(repmat(spikes{i}',2,1), ...
            [(i*ones(spikesSize)+.1)'; (i*ones(spikesSize)+.9)'], ...
            'Color','black');
    end
    line([startTime stopTime], [49 49], 'Color', 'red')
    if not(isempty(trialStartTime))
        startSize = size(trialStartTime);
        for i=1:startSize
            if i>length(feedbackTime)
                e1=stopTime;
            elseif feedbackTime(i)==-1
                e1=trialEndTime(i);
            else
                e1=feedbackTime(i);
                e2 = trialEndTime(i);
                if e2 > stopTime
                    e2 = stopTime;
                end
                p = patch([feedbackTime(i) feedbackTime(i) e2 ...
                    e2], [0 nUnits nUnits 0], [0 1 0]);
                set(p,'FaceAlpha',0.2);
                set(p,'EdgeColor','none');
                text(e1, -12, result(i))
            end
            if e1 > stopTime
                e1 = stopTime;
            end
            p = patch([trialStartTime(i) trialStartTime(i) e1 ...
                e1], [0 nUnits+2 nUnits+2 0], [0 0 1]);
            set(p,'FaceAlpha',0.2);
            set(p,'EdgeColor','none');
        end
    end
    xlim([startTime stopTime])
    ylim([0 nUnits+3])
    hold off;
end
