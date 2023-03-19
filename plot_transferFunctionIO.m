function [h] = plot_transferFunctionIO(freq,amp,gain,plotParams)
%PLOT_TRANSFERFUNCTION Plot change in spectrum given transfer function.
%   PLOT_TRANSFERFUNCTION(FREQ,AMP,GAIN)

if nargin < 1 || isempty(freq), freq = [1 2 3 4].*1000; end
if nargin < 2 || isempty(amp), amp = [10 20 15 5]; end
if nargin < 3 || isempty(gain), gain = [7 15 20 18]; end
if nargin < 4, plotParams = struct; end

defaultParams.bBlank = 0;
plotParams = set_missingFields(plotParams,defaultParams,0);

plotParams.bLogFreq = 1;
xticklabs = {'100' '1000' '10000'};

% plot before
h(1) = plot_spectrum(freq,amp,'Hz',plotParams);
xlim([100 10000]);
xticklabels(xticklabs);

% plot transfer function
plot_transferFunction(freq,gain,plotParams);

% plot after
h(2) = plot_spectrum(freq,amp+gain,'Hz',plotParams);
xlim([100 10000]);
xticklabels(xticklabs);

end