function STS = spikesToSTS(Spikes,varargin)
    % convert M x N Cell array of row vectors to
    % Cell{M,1}[Cell{n,1}[row vectors]] for use with cSpike
    p = inputParser;
    defaultEnd = cellMapReduce(@max, @max, Spikes);

    addOptional(p,'startTime',0,@isnumeric);
    addOptional(p,'endTime',defaultEnd, @isnumeric);
    parse(p,varargin{:});
    startTime = p.Results.startTime;
    endTime = p.Results.endTime;
    %
    % new = {};
    % [nChannels nUnits] = size(Spikes);
    % for i=1:nChannels
    %     new{1,i} = {};
    %     for j=1:nUnits
    %         new{1,i}{1,j} = Spikes{i,j}';
    %     end
    % end
    new = cellfun(@(unit) unit',Spikes(:)', 'UniformOutput', false);
    STS = SpikeTrainSet(new,startTime,endTime);
end
