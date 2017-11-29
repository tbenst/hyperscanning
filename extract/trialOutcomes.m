function outcomes = trialOutcomes(trialInfoMat)
    outcomes = {};
    for i=1:length(trialInfoMat)
        outcomes{i} = trialOutcome(trialInfoMat(i,:));
    end
end

function outcome = trialOutcome(row)
    if row(1)==1 & row(2)==1;
        outcome = 'CC';
    elseif row(1)==2 & row(2)==2;
        outcome = 'DD';
    elseif row(1)==1 & row(2)==2;
        outcome = 'CD';
    elseif row(1)==2 & row(2)==1;
        outcome = 'DC';
    else
        outcome = 'N';
    end
end
