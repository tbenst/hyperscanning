function [rdmA, rdmB] = trialRDM(trialInfoMat, Spikes)
    frA= trialsFiringRate(trialInfoMat, Spikes(1:48,:));
    frB = trialsFiringRate(trialInfoMat, Spikes(49:96,:));
    rdmA = RDM(frA);
    rdmB = RDM(frB);
end
