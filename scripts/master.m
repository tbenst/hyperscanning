timePeriods = {'seasonal' 'start -> end' 'start -> feedback' 'feedback -> reward' ...
    'feedback -> end' 'reward -> end' 'start -> reward' 'start -> reward' };

shuffleByOptions = {'no' 'outcome' 'trial'};

%% Parameters
if ~exist('fileSelection','var')
    fileSelection = 0
end
if ~exist('onlyPreOT','var')
    onlyPreOT = 0
end
if ~exist('toggleShuffleSpikes','var')
    toggleShuffleSpikes = 0
end
if ~exist('shuffleBy','var')
    shuffleBy = 'no'
end
if ~exist('toggleRandomMatch','var')
    toggleRandomMatch = 0
end
if ~exist('timeSelection','var')
    timeSelection = 1
end

timePeriod = timePeriods{timeSelection}

if ~exist('scriptToRun','var')
    scriptToRun = 'analyze.m'
end

if ~exist('saveFig','var')
    saveFig = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/plots/'
    % saveFig = 'no'
end

files = {};
files{1} = struct();
files{1}.dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-21/PDilemma_trust-IzzyOTandPeytonOT-07-21-2014_SPIKE.mat';
files{1}.adminIdx = 158;
files{1}.expDate = '2014-07-21';
files{1}.monkeyNames = {'Izzy', 'Peyton'};
files{1}.conditionA = 'OT';
files{1}.conditionB = 'OT';

files{2} = struct();
files{2}.dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-23/PDilemma_trust-PeytonOTAndIzzyOT-07-23-2014_SPIKE.mat';
files{2}.adminIdx = 160;
files{2}.expDate = '2014-07-23';
files{2}.monkeyNames = {'Peyton', 'Izzy'};
files{2}.swapChannels = true;
files{2}.conditionA = 'OT';
files{2}.conditionB = 'OT';

files{3} = struct();
files{3}.dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-28/PDilemma_trust-PeytonOTAndIzzyOT-07-28-2014_SPIKE.mat';
% files{3}.adminIdx = 160;
% ignore irregular trials...
files{3}.adminIdx = 155;
files{3}.expDate = '2014-07-28';
files{3}.monkeyNames = {'Peyton', 'Izzy'};
files{3}.swapChannels = true;
files{3}.conditionA = 'OT';
files{3}.conditionB = 'OT';
% files{3}.removeOutlierTrials = [155];

files{4} = struct();
files{4}.dataFile = '/home/tyler/Dropbox/Shared/PDtrustOT_Tyler/data/2014-07-30/PDilemma_trust-IzzyOTandPeytonOT-07-30-2014_SPIKE.mat';
files{4}.adminIdx = 207;
files{4}.expDate = '2014-07-30';
files{4}.monkeyNames = {'Izzy', 'Peyton'};
files{4}.conditionA = 'OT';
files{4}.conditionB = 'OT';

if ~strcmp(saveFig,'no')
    set(0,'DefaultFigureVisible','off')
end

x____________________________START____________________________ = ''
if fileSelection==0
    for fnum=1:length(files)
        myFile = files{fnum};
        [pathstr,name,ext] = fileparts(myFile.dataFile);
        x______________________EXPERIMENT______________________ = name
        run(scriptToRun)
    end
elseif fileSelection>0
    fnum = fileSelection;
    myFile = files{fileSelection};
    [pathstr,name,ext] = fileparts(myFile.dataFile);
    x______________________EXPERIMENT______________________ = name
    run(scriptToRun)
end

clear x______________________START______________________  ...
x______________________EXPERIMENT______________________


if ~strcmp(saveFig,'no')
    set(0,'DefaultFigureVisible','on')
end
