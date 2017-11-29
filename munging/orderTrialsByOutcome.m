function [trialIndices labels] = orderTrialsByOutcome(trialInfoMat)
     % C=cooperate, D=defect, N=no choice
     CC = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==1);
     DC = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==1);
     CD = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==2);
     DD = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==2);

     ND = find(trialInfoMat(:,1)==-1 & trialInfoMat(:,2)==2);
     NC = find(trialInfoMat(:,1)==-1 & trialInfoMat(:,2)==1);
     CN = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==-1);
     DN = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==-1);
     NN = find(trialInfoMat(:,1)==-1 & trialInfoMat(:,2)==-1);

     trialIndices = {CC;DC;CD;DD;ND;NC;CN;DN;NN};
     labels = ['CC', 'DC', 'CD', 'DD', '', '', '', '', ''];

end
