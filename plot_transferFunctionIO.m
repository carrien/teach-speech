function [h] = plot_transferFunctionIO(freq,amp,gain,plotParams)
%PLOT_TRANSFERFUNCTION Plot change in spectrum given transfer function.
%   PLOT_TRANSFERFUNCTION(FREQ,AMP,GAIN)

if nargin < 1 || isempty(freq), freq = [1 2 3 4].*1000; end
if nargin < 2 || isempty(amp), amp = [10 20 15 5]; end
if nargin < 3 || isempty(gain), gain = [7 15 20 18]; end
if nargin < 4, plotParams = struct; end

defaultParams.freqUnits = 'Hz';
defaultParams.bBlank = 0;
plotParams = set_missingFields(plotParams,defaultParams,0);

plotParams.bLogFreq = 1;

% plot before
h(1) = plot_spectrum(freq,amp,plotParams);
xlim([100 10000]);
set(gca, 'XTickLabel',get(gca,'XTick')); % remove exponents
set(h(1),'Position',[100 100 450 433]);

% plot transfer function
plot_transferFunction(freq,gain,plotParams);
set(gca, 'XTickLabel',get(gca,'XTick')); % remove exponents

% plot after
h(2) = plot_spectrum(freq,amp+gain,plotParams);
xlim([100 10000]);
set(gca, 'XTickLabel',get(gca,'XTick')); % remove exponents
set(h(2),'Position',[100 100 450 433]);
ax2 = gca;
minorTix = ax2.YAxis.MinorTickValues;

copy_ax(h(2),h(1));
h(1)
ax1 = gca;
ax1.YAxis.MinorTickValues = minorTix;

end