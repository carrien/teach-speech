function [h] = plot_bandpass(sigstruct)

fs = sigstruct(1).fs;
nsigs = length(sigstruct);

cmap = flipud(jet(nsigs+1));

h = figure;
t = tiledlayout(nsigs,3);
plotinds = fs*.25:fs*2.75;
taxis = 1/fs:1/fs:length(plotinds)/fs;

winsize = 2000;

for i=1:nsigs
    y = sigstruct(i).y(plotinds);
    thiscolor = cmap(i,:);
    
    hax = nexttile;
    plot(taxis,y,'Color',thiscolor);
    hax.YLim = [-1 1];
    if i < length(sigstruct)
        hax.XTickLabel = [];
    end
    hax.TickLength(1) = .005;
    makeFig4Screen;
    
    hax = nexttile;
    pspectrum(y);
    if i < length(sigstruct)
        hax.XTickLabel = [];
    end
    title('');
    xlabel('');
    ylabel('');
    makeFig4Screen;
    
    hax = nexttile;
    amp = zeros(1,length(y));
    for j=1:length(y)-winsize
        ywin = y(j:j+winsize);
        amp(j) = rms(ywin);
    end
    plot(amp,'Color',thiscolor);
    hax.YLim = [-1 1];
    if i < length(sigstruct)
        hax.XTickLabel = [];
    end
    hax.TickLength(1) = .005;
    makeFig4Screen;
    
end

t.TileSpacing = 'none';
t.Padding = 'none';
