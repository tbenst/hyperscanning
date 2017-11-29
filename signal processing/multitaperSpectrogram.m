function [S t f data] = multitaperSpectrogram(x, varargin)
    lastTime = max(x);
    p = inputParser;
    addRequired(p,'x');
    addOptional(p,'duration',lastTime);
    addOptional(p,'resolution',1000);
    addOptional(p,'plot',false);
    parse(p,x,varargin{:});
    resolution = p.Results.resolution;
    duration = p.Results.duration;
    
    T = 1
    movingwin = [T .5*T]
    bandwidth = 10
    params = struct('tapers', [bandwidth T 2*bandwidth*T-1], 'Fs', resolution)
    
    data = histcounts(x,0:1/resolution:duration);
    [S t f] = mtspecgrampb(data,movingwin,params);
    if p.Results.plot

        h1 = figure;
        imagesc(t,f,10*log(S))
        ylabel('time [sec]'); xlabel('Frequency');
        xlim([5,100])
        view(-90,90)
        title('Multitaper Spectrogram');
        colorbar
    end
end
