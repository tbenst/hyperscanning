function [startTimes endTimes seasons] = getTimePeriod(timePeriod, trialInfoMat, trialFeedbackTime, firstRewardTime)
    seasons = {};
    if strcmp(timePeriod,'feedback -> reward')
        startTimes = trialFeedbackTime;
        endTimes = firstRewardTime;

    elseif strcmp(timePeriod,'reward -> end')
        startTimes = firstRewardTime;
        endTimes = trialInfoMat(:,12);


    elseif strcmp(timePeriod,'feedback -> end')
        startTimes = trialFeedbackTime;
        endTimes = trialInfoMat(:,12);

    elseif strcmp(timePeriod,'start -> feedback')
        startTimes = trialInfoMat(:,11);
        endTimes = trialFeedbackTime;

    elseif strcmp(timePeriod,'start -> reward')
        startTimes = trialInfoMat(:,11);
        endTimes = firstRewardTime;

    elseif strcmp(timePeriod,'start -> end')
        startTimes = trialInfoMat(:,11);
        endTimes = trialInfoMat(:,12);
    elseif strcmp(timePeriod,'seasonal')
        startTimes = [];
        endTimes = [];

        for t=1:length(trialInfoMat)
            if trialInfoMat(t,6)==1
                % completed trial
                ft = trialFeedbackTime(t);
                rt = firstRewardTime(t);
                try
                    assert(~strictIsnan(ft) & ~strictIsnan(rt))
                catch
                    error(['bad row ' num2str(t) '. FeedbackTime is ' ...
                        num2str(ft) ' and rewardTime is ' num2str(rt)])
                end

                newStarts = [trialInfoMat(t,11) ft ...
                    rt];
                newEnds = [ft rt ...
                    trialInfoMat(t,12)];
                newSeasons = {'start -> feedback' 'feedback -> reward' ...
                    'reward -> end'};
            else
                newStarts = [trialInfoMat(t,11) trialInfoMat(t,12) ...
                    trialInfoMat(t,12)];
                newEnds = [trialInfoMat(t,12) trialInfoMat(t,12) ...
                    trialInfoMat(t,12)];
                newSeasons = {'start -> end' 'none' ...
                    'none'};
            end
            startTimes = [startTimes newStarts];
            endTimes = [endTimes newEnds];
            seasons = [seasons newSeasons];
        end

    else
        display('no match for timePeriod')
        assert(false)
    end
end
