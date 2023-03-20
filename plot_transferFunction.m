function [h] = plot_transferFunction(freq,gain,plotParams)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(freq), freq = [.25 .5 1 2 4 8]*1000; end
if nargin < 2 || isempty(gain), gain = [1 4 7 NaN 5 2]; end
if nargin < 3 || isempty(plotParams), plotParams = struct; end

% set default plotting params
defaultParams.freqUnits = 'kHz';
defaultParams.logBase = 10;
defaultParams.ylim = [-20 50];
defaultParams.bConnectLines = 1;
defaultParams.bLogFreq = 1;
defaultParams.bGrid = 1;
defaultParams.bGridMinor = 1;
defaultParams.numMinorGridlines = [];
defaultParams.bBlank = 0;
defaultParams.bKey = 0;
plotParams = set_missingFields(plotParams,defaultParams,0);

% plot transfer function
h = figure;

if ~plotParams.bBlank
    plot(freq,gain,'o')
    hold on;
    plot(freq,gain,'--');
end
if plotParams.bLogFreq
    set(gca,'Xscale','log');
end

ylim(plotParams.ylim);

if plotParams.bGrid
    grid on;
end
if plotParams.bGridMinor
    grid minor;
    if plotParams.numMinorGridlines
        ax = gca;
        ytix = yticks;
        majorTickIntervals = diff(ytix);
        minorTickInterval = majorTickIntervals(1)/plotParams.numMinorGridlines;
        minorTickValues = ytix(1):minorTickInterval:ytix(end);
        ax.YAxis.MinorTickValues = minorTickValues;
    end
end

if plotParams.bLogFreq
    switch plotParams.logBase
        case 2
            xtix = [.25 .5 1 2 4 8]*1000;
            xlim([200 10000]);
        case 10
            xtix = [.1 1 10]*1000;
            xlim([100 10000]);
    end
    xticks(xtix);
else
    xtix = xticks;
end
if strcmp(plotParams.freqUnits,'kHz')
    xticklabels(compose('%g',xtix/1000));
end
xlabel(['frequency (' plotParams.freqUnits ')']);

ylabel('gain (dB)');

makeFig4Screen;
set(h,'Position',[100 100 450 433]);
