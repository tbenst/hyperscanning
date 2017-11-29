% add 1 day of blank to in-between experiments
seperationTime =60*60*24;

allTrialInfoMatColumnDescription =  {'izzyResp' 'peytonResp' ...
'izzyRespFirst' 'izzyRT' 'peytonRT' 'completedTrial' ...
'trialType' 'izzyReward' 'peytonReward' 'izzyRewardFirst' ...
'trialStartTS' 'trialEndTS'};

%% First File
% must have dimensions of Spikes >= all other files
dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-21/PDilemma_trust-IzzyOTandPeytonOT-07-21-2014_SPIKE.mat'
adminIdx = 158;
monkeyNames = {'Izzy', 'Peyton'};
conditionA = 'OT';
conditionB = 'OT';

load(dataFile);
run('setup.m');
allTrialWordCodeCell = trialWordCodeCell;
allTrialWordCodeTSCell = trialWordCodeTSCell;
allTrialInfoMat = trialInfoMat;
allSpikes = Spikes;

%% Rest of files
dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-23/PDilemma_trust-PeytonOTAndIzzyOT-07-23-2014_SPIKE.mat'
adminIdx = 160;
monkeyNames = {'Peyton', 'Izzy'};
conditionA = 'OT';
conditionB = 'OT';
load(dataFile);
run('setupAndConcat.m');

%
% dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-28/PDilemma_trust-PeytonOTAndIzzyOT-07-28-2014_SPIKE.mat'
% adminIdx = 160;
% monkeyNames = {'Peyton', 'Izzy'};
% conditionA = 'OT';
% conditionB = 'OT';
% load(dataFile);
% run('setupAndConcat.m');

dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-30/PDilemma_trust-IzzyOTandPeytonOT-07-30-2014_SPIKE.mat'
adminIdx = 207;
monkeyNames = {'Izzy', 'Peyton'};
conditionA = 'OT';
conditionB = 'OT';
load(dataFile);
run('setupAndConcat.m');
