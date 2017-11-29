function [pxx f pxxc] = multitaper(x, varargin)
    p = inputParser;
    addRequired(p,'x');
    addOptional(p,'fs',1000);
    addOptional(p,'plot',false);
    parse(p,x,varargin{:});
    fs = p.Results.fs;

    [pxx f pxxc] = pmtm(x,3.5,5:120,fs,'ConfidenceLevel',0.95);

    if p.Results.plot
        figure
        plot(f,10*log10(pxx))
        % hold on
        % plot(f,10*log10(pxxc),'r-.')
        xlim([5 120])
        xlabel('Hz')
        ylabel('dB')
        title('Multitaper PSD Estimate')
        % title('Multitaper PSD Estimate with 95%-Confidence Bounds')
    end
end
