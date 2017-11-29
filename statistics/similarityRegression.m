 function reg = similarityRegression(trialInfoMat, similarity, valueMap)
    %plusOutcomes should be a cell containing conditions that are binary 1 in :
    % regression  e.g. {'CC', 'DD'}

    [CC CD DC DD] = getOutcomes(trialInfoMat);
    allIdx = horzcat([CC; CD; DC; DD]);
    synchrony = -1*ones(1,max(allIdx));
    synchrony(CC) = valueMap('CC');
    synchrony(DC) = valueMap('DC');
    synchrony(CD) = valueMap('CD');
    synchrony(DD) = valueMap('DD');

    X = similarity(allIdx);
    x = X - mean(X);
    Y = synchrony(allIdx);
    reg = fitlm(Y, x);
end
