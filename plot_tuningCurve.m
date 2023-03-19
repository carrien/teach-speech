function [h] = plot_tuningCurve(cf,thresh,bw,freqUnits,plotParams)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(cf), cf = 4; end
if nargin < 2 || isempty(thresh), thresh = 10; end
if nargin < 3 || isempty(bw), bw = .4; end
if nargin < 4 || isempty(freqUnits), freqUnits = 'kHz'; end
if nargin < 5 || isempty(plotParams), plotParams = struct; end

% set default plotting params
defaultParams.bLog = 1;
defaultParams.bGrid = 1;
defaultParams.bGridMinor = 1;
defaultParams.bBlank = 0;
plotParams = set_missingFields(plotParams,defaultParams,0);

% plot tuning curve
h = figure;

%x = [.125 .25 1 2 4 8 16];
x = [.25 1 2 4 8 16];
%y = [90 80 60 60 60 80 90];
y = [75 50 50 60 75 100];
[x,ia] = setdiff(x,cf); % remove cf
y = y(ia);              % remove cf
xplus = [x cf-(bw/2) cf cf+(bw/2)];     % add back cf + bw
yplus = [y thresh+10 thresh thresh+10]; % add back cf + bw
[x,idx] = sort(xplus);
y = yplus(idx);
if plotParams.bLog
    semilogx(x,y,'.:')
    %plot(x,y,'.')
    %set(gca, 'XScale', 'log')
else
    plot(x,y,'.:')
end
hold on;
grid on;

if plotParams.bLog
    set(gca,'XTick',[.125 .25 .5 1 2 4 8 16]);
    xlim([.2 20]);
else
    set(gca,'XTick',[0:2:16]);
    xlim([.2 16]);
end
xlabel('frequency (kHz)')

ylim([0 max(y)]);
ylabel('level (dB SPL)')

hline(thresh,[.8 .8 .8],'--');
hline(thresh+10,[.8 .8 .8],'--');
plot([cf-(bw/2) cf+(bw/2)],[thresh+10 thresh+10],'r-','LineWidth',3);
arrowY = [.35 .28]; %[.3 .23]; % tail, head
if plotParams.bLog
    arrowX = [.35 .47]; %[.5 .65]; % tail, head
else
    arrowX = [.35 .25]; % tail, head
end
harrow = annotation('textarrow',arrowX,arrowY, ...
    'String',{'Bandwidth at',sprintf('%d dB SPL',thresh+10),sprintf('= %d Hz',bw*1000)}, ...
    'FontSize',14);

makeFig4Screen
set(h,'Position',[100 100 925 420])
