sp = spikesBetween(Spikes, 0, 60);
izzyNeurons = nonEmptyCell(sp(1:48,:));
peytonNeurons = nonEmptyCell(sp(49:96,:));
VPdm = distanceBetween(@(a,b) victorPurpura(a,b,1), izzyNeurons, peytonNeurons);
pairedNeurons = greedyPairDistance(VPdm);
