function [p tbl stats multcomp] = anovaByOutcome(trialInfoMat, signal)
   %plusOutcomes should be a cell containing conditions that are binary 1 in :
   % regression  e.g. {'CC', 'DD'}
   idx = find(~isnan(signal));
   [CC CD DC DD] = getOutcomes(trialInfoMat);
   CC = intersect(idx, CC);
   CD = intersect(idx, CD);
   DC = intersect(idx, DC);
   DD = intersect(idx, DD);
   allIdx = horzcat([CC; CD; DC; DD]);
   labels = {};
   labels(CC) = {'CC'};
   labels(DC) = {'DC'};
   labels(CD) = {'CD'};
   labels(DD) = {'DD'};
   x = signal(allIdx);
   % x = X - mean(X);
   y = labels(allIdx);
   [p tbl stats] = anova1(x,y);
   stats
   [c,m,h,names] = multcompare(stats);

   multcomp = num2cell(c);
   multcomp(:,[1 2]) = cellfun(@(x) names(x), multcomp(:,[1 2]));
   multcomp = cell2table(multcomp,...
      'VariableNames',{'Group1' 'Group2' 'CI_lower' 'Mean' 'CI_upper' 'p_val'});
end
