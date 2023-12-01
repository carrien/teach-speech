function [h] = plot_spectrum(freq,amp,plotParams)
%PLOT_SPECTRUM  Plot power spectrum given frequencies and amplitudes.

defaultAmp = 1;
if nargin < 1, freq = 100:100:1000; end
if nargin < 2, amp = []; end
if isempty(amp) || ~isnumeric(amp)
    warning('Amplitude must be numeric. Setting default amplitude of %d.',defaultAmp)
    amp = defaultAmp;
end
if nargin < 3, plotParams = struct; end

defaultParams.freqUnits = 'Hz';
plotParams = set_missingFields(plotParams,defaultParams,0);
if strcmp(plotParams.freqUnits,'kHz')
    freq = freq*1000;
end

% xlim
minfreq = min(freq);
maxfreq = max(freq);
if maxfreq <= 300,      xmax = 300;
elseif maxfreq <= 600,  xmax = 600;
elseif maxfreq <= 1000, xmax = 1000;
elseif maxfreq < 10000, xmax = maxfreq + minfreq; %xmax = 1000*(1+ceil(maxfreq/1000));
else,                   xmax = 20000;
end
if strcmp(plotParams.freqUnits,'kHz')
    freq = freq/1000;
    xmax = xmax/1000;
end
defaultParams.xmax = xmax;
defaultParams.xlabel = sprintf('frequency (%s)',plotParams.freqUnits);

% ylim
maxamp = max(amp);
if maxamp < 3,  ymax = 3;
else,           ymax = maxamp+10;
end
defaultParams.ymax = ymax;
defaultParams.ylabel = {'level (dB SPL)'}; % {'amplitude'}; % 
defaultParams.bGrid = 1;
defaultParams.bGridMinor = 1;
defaultParams.numMinorGridlines = [];
defaultParams.bBlank = 0;
defaultParams.bLogFreq = 0;
defaultParams.lineColor = [0 0 0];
defaultParams.figpos = [100 100 700/2 400/2];
plotParams = set_missingFields(plotParams,defaultParams,0);

if length(amp) == 1
    amp = amp*ones(1,length(freq));
elseif length(amp) < length(freq)
    amp = [amp defaultAmp*ones(1,length(freq)-length(amp))];
end

%% plot
if ~isfield(plotParams,'hax')
    h = figure;
else
    hax = plotParams.hax;
    axes(hax);
    h = gcf;
end

xlabel(plotParams.xlabel);
ylabel(plotParams.ylabel);
axis([0 plotParams.xmax 0 plotParams.ymax]);

% plot grid
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
    set(gca,'Xscale','log');
end

% plot lines
if ~plotParams.bBlank
    ylims = get(gca,'YLim');
    for i=1:length(freq)
        line([freq(i) freq(i)],[ylims(1) amp(i)],'Color',plotParams.lineColor,'LineWidth',4);
    end
end

set(gcf,'Position',plotParams.figpos)
makeFig4Screen
