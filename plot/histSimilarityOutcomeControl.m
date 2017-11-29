function fig = histSimilarityOutcome(trialInfoMat, similarity, varargin)
    p = inputParser;
    myTitleDefault = 'Histogram of trials with result ';
    addOptional(p,'myTitle',myTitleDefault, @(x) true);
    addOptional(p,'control',[]);
    parse(p,varargin{:});
    myTitle = p.Results.myTitle;
    control = p.Results.control;

    [CC CD DC DD] = getOutcomes(trialInfoMat);
    allIdx = horzcat([CC; CD; DC; DD]);

    fig = figure('units','inches');
    set(gcf,'pos',[0 0 6.5 9])
    subplot(4,1,1)
    helper(similarity,CC,'CC',myTitle, control)

    subplot(4,1,2)
    helper(similarity,CD,'CD',myTitle, control)

    subplot(4,1,3)
    helper(similarity,DC,'DC',myTitle, control)

    subplot(4,1,4)
    helper(similarity,DD,'DD',myTitle, control)

    if size(control,1)>0
        lh = legend('Izzy - Peyton', 'Control');
        lh.Orientation ='horizontal';
        set(lh,'Position', [0.5 0.01 0.05 0.05], 'Units', 'normalized');
    end
end

function helper(similarity, AB, condition, myTitle, control)
    ntrials = length(AB);
    if ntrials<=1
        return
    end
    % try
    if size(control,1)>0
        h = customHistFit(similarity(AB), ntrials);
    else
        h = histfit(similarity(AB), ntrials);
    end
    set(h(2),'color','b')

    theMin = min(similarity);
    theMax = max(similarity);
    title([myTitle condition])
    ylabel('# trials')
    xlabel('Firing Rate')
    if size(control,1)>0
        % remove bars
        delete(h(1))
        hold on
        theMin = min([min(control) theMin]);
        theMax = max([max(control) theMin]);
        scaleFactor = length(AB);
        h = customHistFit(control(AB), ntrials);
        delete(h(1))
        set(h(2),'color','r')
    end

    xlim([theMin theMax])
end

function h = customHistFit(data, area)
    % normalize to n area under curve
    pd = fitdist(data, 'kernel');

    % Find range for plotting
    q = icdf(pd,[0.0013499 0.99865]); % three-sigma range for normal distribution
    x = linspace(q(1),q(2));
    if ~pd.Support.iscontinuous
        % For discrete distribution use only integers
        x = round(x);
        x(diff(x)==0) = [];
    end

    n = numel(data);
    nbins = ceil(sqrt(n));
    % Do histogram calculations
    [bincounts,binedges] = histcounts(data,nbins);
    bincenters = binedges(1:end-1)+diff(binedges)/2;

    % Plot the histogram with no gap between bars.
    hh = bar(bincenters,bincounts,1);

    % Normalize the density to match the area
    binwidth = binedges(2)-binedges(1); % Finds the width of each bin
    y = area * pdf(pd,x);

    % Overlay the density
    np = get(gca,'NextPlot');
    set(gca,'NextPlot','add')
    hh1 = plot(x,y,'r-','LineWidth',2);
    set(gca,'NextPlot',np)
    if nargout == 1
        h = [hh; hh1];
    end
end
