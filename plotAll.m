function plotAll(Spikes, trialInfoMat, adminIdx, conditionA, conditionB, monkeyNames)

    % plot chronological RDM
    ntrials = size(trialInfoMat,1);

    [rdmA rdmB similarity] = behaviorRDM(Spikes, trialInfoMat, 'plot', true, ...
        'trialOrder', {[1];[2:adminIdx+1];[(adminIdx+2):ntrials]}, ...
        'labels', {'','pre',conditionA;'','pre',conditionB}, ...
        'monkeyNames', monkeyNames);

    % plot outcome RDM
    % trialsByOutcome = orderTrialsByOutcome(trialInfoMat);
    % behaviorRDM(Spikes, trialInfoMat, 'plot', true,
        % 'trialOrder');
end
