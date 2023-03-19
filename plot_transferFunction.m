function [h] = plot_transferFunction(x,y,freqUnits,plotParams)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(x), x = [.25 .5 1 2 4 8]; end
if nargin < 2 || isempty(y), y = [1 4 7 NaN 5 2]; end
if nargin < 3 || isempty(freqUnits), freqUnits = 'kHz'; end
if nargin < 4 || isempty(plotParams), plotParams = struct; end

% set default plotting params
defaultParams.ylim = [-20 50];
defaultParams.bConnectLines = 1;
defaultParams.bLog = 1;
defaultParams.bGrid = 1;
defaultParams.bGridMinor = 1;
defaultParams.bBlank = 0;
defaultParams.bKey = 0;
plotParams = set_missingFields(plotParams,defaultParams,0);

% plot tuning curve
h = figure;
if plotParams.bLog
    semilogx(x,y,'o')
else
    plot(x,y,'o')
end
hold on;
if plotParams.bGrid
    grid on;
end
if plotParams.bKey
    plot(2,14,'o')
    y(x==2) = 14;
    plot(x,y,'--');
end

xlim([0 8]);
set(gca,'XTick',[.125 .25 .5 1 2 4 8]);
xlabel(['frequency (' freqUnits ')']);

ylim(plotParams.ylim);
ylabel('gain (dB)');

makeFig4Screen;
set(h,'Position',[100 100 450 433]);
