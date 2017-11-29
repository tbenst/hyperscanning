function [trialIndices labels] = orderTrialsByDrug(trialInfoMat, ...
     adminIdx)
     % C=cooperate, D=defect, N=no choice
     CCpre = find(trialInfoMat(1:adminIdx,1)==1 & ...
                  trialInfoMat(1:adminIdx,2)==1);
     DCpre = find(trialInfoMat(1:adminIdx,1)==2 & ...
                  trialInfoMat(1:adminIdx,2)==1);
     CDpre = find(trialInfoMat(1:adminIdx,1)==1 & ...
                  trialInfoMat(1:adminIdx,2)==2);
     DDpre = find(trialInfoMat(1:adminIdx,1)==2 & ...
                  trialInfoMat(1:adminIdx,2)==2);

     NDpre = find(trialInfoMat(1:adminIdx,1)==-1 & ...
                  trialInfoMat(1:adminIdx,2)==2);
     NCpre = find(trialInfoMat(1:adminIdx,1)==-1 & ...
                  trialInfoMat(1:adminIdx,2)==1);
     CNpre = find(trialInfoMat(1:adminIdx,1)==1 & ...
                  trialInfoMat(1:adminIdx,2)==-1);
     DNpre = find(trialInfoMat(1:adminIdx,1)==2 & ...
                  trialInfoMat(1:adminIdx,2)==-1);
     NNpre = find(trialInfoMat(1:adminIdx,1)==-1 & ...
                  trialInfoMat(1:adminIdx,2)==-1);

     CCpost = find(trialInfoMat(adminIdx+1:end,1)==1 & ...
                  trialInfoMat(adminIdx+1:end,2)==1);
     DCpost = find(trialInfoMat(adminIdx+1:end,1)==2 & ...
                  trialInfoMat(adminIdx+1:end,2)==1);
     CDpost = find(trialInfoMat(adminIdx+1:end,1)==1 & ...
                  trialInfoMat(adminIdx+1:end,2)==2);
     DDpost = find(trialInfoMat(adminIdx+1:end,1)==2 & ...
                  trialInfoMat(adminIdx+1:end,2)==2);

     NDpost = find(trialInfoMat(adminIdx+1:end,1)==-1 & ...
                  trialInfoMat(adminIdx+1:end,2)==2);
     NCpost = find(trialInfoMat(adminIdx+1:end,1)==-1 & ...
                  trialInfoMat(adminIdx+1:end,2)==1);
     CNpost = find(trialInfoMat(adminIdx+1:end,1)==1 & ...
                  trialInfoMat(adminIdx+1:end,2)==-1);
     DNpost = find(trialInfoMat(adminIdx+1:end,1)==2 & ...
                  trialInfoMat(adminIdx+1:end,2)==-1);
     NNpost = find(trialInfoMat(adminIdx+1:end,1)==-1 & ...
                  trialInfoMat(adminIdx+1:end,2)==-1);

     trialIndices = {CCpre;DCpre;CDpre;DDpre;NDpre;NCpre;CNpre;DNpre;NNpre ...
             CCpost;DCpost;CDpost;DDpost;NDpost;NCpost;CNpost;DNpost;NNpost};
     labels = ['CCpre', 'DCpre', 'CDpre', 'DDpre', '', '', '', '', '', ...
               'CCpost', 'DCpost', 'CDpost', 'DDpost', '', '', '', '', ''];

end