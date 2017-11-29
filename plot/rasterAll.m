function rasterAll(Spikes, trialInfoMat, trialFeedbackTime, folder, theTitle)
    endTime = trialInfoMat(end,12);
    % endTime = 500;
    results = cell(length(trialInfoMat),1);
    CC = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==1);
    DD = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==2);
    CD = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==2);
    DC = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==1);
    results(CC) = {'CC'};
    results(DD) = {'DD'};
    results(DC) = {'DC'};
    results(CD) = {'CD'};
    step = 240*3;
    for t=0:step:endTime
        fig = figure('units','inches','Visible','off');
        subplot(3,1,1)
        rasterSpikes(Spikes,t,t+step/3,trialInfoMat(:,11), ...
            trialFeedbackTime, trialInfoMat(:,12), results)
        h = title(theTitle);
        P = get(h,'Position');
        set(h,'Position',[P(1) P(2)-3 P(3)]);
        subplot(3,1,2)
        rasterSpikes(Spikes,t+step/3,t+2*step/3,trialInfoMat(:,11), ...
            trialFeedbackTime, trialInfoMat(:,12), results)
        subplot(3,1,3)
        rasterSpikes(Spikes,t+2*step/3,t+step,trialInfoMat(:,11), ...
            trialFeedbackTime, trialInfoMat(:,12), results)
        pos = get(gcf,'pos');
        set(gcf,'pos',[0 0 8.5 11])
        saveas(gcf,horzcat(folder,'/',num2str(t),'.pdf'),'pdf')
        close(fig)
    end
end
