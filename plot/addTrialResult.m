function addTrialResults(trialInfoMat, bottom, top, height)
    CC = find(trialInfoMat(:,1)==1 & trialInfoMat(:,2)==1)';
    DD = find(trialInfoMat(:,1)==2 & trialInfoMat(:,2)==2)';
    aCoop = find(trialInfoMat(:,1)==1)';
    aDefect = find(trialInfoMat(:,1)==2)';
    aNoPlay = find(trialInfoMat(:,1)==-1)';
    bCoop = find(trialInfoMat(:,2)==1)';
    bDefect = find(trialInfoMat(:,2)==2)';
    bNoPlay = find(trialInfoMat(:,2)==-1)';
    line(repmat(aCoop,2,1),repmat([top; top-height/2],1,size(aCoop,1)), 'Color',[1 .8 0])
    line(repmat(CC,2,1),repmat([top; top-height],1,size(CC,1)), 'Color',[1 .8 0])
    line(repmat(aDefect,2,1),repmat([top; top-height/2],1,size(aDefect,1)), 'Color','blue')
    line(repmat(DD,2,1),repmat([top; top-height],1,size(DD,1)), 'Color','blue')
    line(repmat(aNoPlay,2,1),repmat([top; top-height/2],1,size(aNoPlay,1)), 'Color','red')

    line(repmat(bCoop,2,1),repmat([bottom; bottom+height/2],1,size(bCoop,1)), 'Color',[1 .8 0])
    line(repmat(CC,2,1),repmat([bottom; bottom+height],1,size(CC,1)), 'Color',[1 .8 0])
    line(repmat(bDefect,2,1),repmat([bottom; bottom+height/2],1,size(bDefect,1)), 'Color','blue')
    line(repmat(DD,2,1),repmat([bottom; bottom+height],1,size(DD,1)), 'Color','blue')
    line(repmat(bNoPlay,2,1),repmat([bottom; bottom+height/2],1,size(bNoPlay,1)), 'Color','red')
end
