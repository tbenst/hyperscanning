function [VPdms pairings distancesOverTime] = matchingOverTime(Spikes)
    stepSize = 60;
    steps = 12;

    aNeurons = nonEmptyCell(Spikes(1:48,:));
    alength = length(aNeurons);
    bNeurons = nonEmptyCell(Spikes(49:96,:));
    blength = length(bNeurons);
    npairs = min(alength, blength);
    pairings = zeros(2,npairs, 12);
    distancesOverTime = zeros(npairs,12);
    VPdms = zeros(alength, blength, 12);
    figure
    for i=1:12
        A = spikesBetween(aNeurons, (i-1)*60, i*60);
        B = spikesBetween(bNeurons, (i-1)*60, i*60);
        VPdm = distanceBetween(@(a,b) victorPurpura(a,b,1), A, B);
        VPdms(:,:,i) = VPdm;
        [pairs distances] = greedyPairDistance(VPdm);
        pairings(:,:,i) = pairs;
        distancesOverTime(:,i) = distances;
        subplot(3,4,i)
        imshow(VPdm/max(max(VPdm)), 'Colormap', parula)
    end
end
