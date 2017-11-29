function [rdmA rdmB similarity] = behaviorRDM(Spikes, trialInfoMat, varargin)
    p = inputParser;
    defaultPlot = false;
    ntrials = size(trialInfoMat,1);
    firstTick = floor(ntrials/3);
    secondTick = firstTick+floor(ntrials/3);
    defaultTrialOrder = {[1:1];[2:firstTick];[firstTick+1:secondTick]; ...
        [secondTick+1:ntrials]};
    defaultLabels = {'','';'',''};

    addOptional(p,'plot',defaultPlot,@islogical);
    addOptional(p,'trialOrder',defaultTrialOrder,@iscell);
    addOptional(p,'monkeyNames',{'Monkey A', 'Monkey B'},@iscell);
    addOptional(p,'labels',defaultLabels,@iscell);
    parse(p, varargin{:});
    trialOrder = p.Results.trialOrder;
    labels = p.Results.labels;
    monkeyNames = p.Results.monkeyNames;

    frA = trialsFiringRate(trialInfoMat, Spikes(1:48,:));
    frB = trialsFiringRate(trialInfoMat, Spikes(49:96,:));

    trialFR_a = cell2mat(cellfun(@(idx) frA(idx,:), trialOrder, ...
        'UniformOutput', false));
    trialFR_b = cell2mat(cellfun(@(idx) frB(idx,:), trialOrder, ...
        'UniformOutput', false));
    rdmA = RDM(trialFR_a);
    rdmB = RDM(trialFR_b);

    similarity = zeros(ntrials,1);
    % time-series RSA
    autocorrLag = 8;
    autocorrLead = 0;
    % only calculate valid for sliding window
    start_t = 1 + autocorrLag;
    end_t = ntrials-1-autocorrLead;

    for i = start_t:end_t
        s = i - autocorrLag;
        e = i+autocorrLead;
        if e>end_t
            break
        end

        similarity(i) = RSA(rdmA(s:e,s:e), rdmB(s:e,s:e));
    end

    if p.Results.plot
        % count number of trials per group
        tmp = cellfun(@(x) size(x,2), trialOrder);
        ticks = cumsum(tmp)';

        midwayTick = arrayfun(@(a,b) (a+b)/2, ...
            paren(horzcat([0],ticks), 1, 1:size(ticks,2)), ticks);

        nlabels = size(labels,2);

        subplot(2,1,1);
        plot(similarity);
        title('Representational Similarity Analysis')
        xlabel('trial #')
        ylabel('Similarity')
        addTrialResults(trialInfoMat);
        ylim([-1.2,1.2])
        legend('Cooperate', 'Defect', 'location', 'southoutside')
        text(-40,1.1,monkeyNames{1})
        text(-40,-1.1,monkeyNames{2})

        p1 = subplot(2,2,3);
        imshow(rdmA, 'Colormap', parula)
        xticks(ticks)
        yticks(ticks)
        xl = xlabel('trial #');
        xaxis_height = xl.Position(2)-25;
        xlabel('trial #')
        title(horzcat(monkeyNames{1}, ' RDM'))
        text(-20*ones(nlabels,1),midwayTick, ...
             labels(1,:),'horizontalalign','right', 'fontweight', 'bold')
        text(midwayTick,xaxis_height*ones(nlabels,1), ...
             labels(1,:),'horizontalalign','right', 'fontweight', 'bold')
        axis on

        p2 = subplot(2,2,4);
        imshow(rdmB, 'Colormap', parula)
        xticks(ticks)
        yticks(ticks)
        xl = xlabel('trial #')
        title(horzcat(monkeyNames{2}, ' RDM'))
        text(-20*ones(nlabels,1),midwayTick, ...
        labels(2,:),'horizontalalign','right', 'fontweight', 'bold')
        text(midwayTick,xaxis_height*ones(nlabels,1), ...
        labels(2,:),'horizontalalign','right', 'fontweight', 'bold')
        originalSize = get(gca, 'Position');
        colorbar
        axis on
        set(p2, 'Position', originalSize)
    end

end
