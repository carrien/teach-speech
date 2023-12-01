function [toneInt] = play_freqSelect2I2AFC(tone,toneAmp,masker,fs,isi,plotParams,maskerGain)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1, tone = 400; end
if nargin < 2, toneAmp = .01; end
if nargin < 3, masker = 800; end
if nargin < 4 || isempty(fs), fs = 11025; end % sampling frequency
if nargin < 5, isi = .3; end   % interstimulus interval in seconds
if nargin < 6, plotParams = []; end
if nargin < 7 || isempty(maskerGain), maskerGain = 1; end % gain

defaultParams.bPlot = 1;
defaultParams.figpos = [100 100 1300 780]; %[100 100 940 420];
defaultParams.hfig = [];
defaultParams.plotDelay = []; % delay in seconds (if empty, wait for keypress)
plotParams = set_missingFields(plotParams,defaultParams,0);

% set up plot
if plotParams.bPlot
    if ~isempty(plotParams.hfig) && ishandle(plotParams.hfig)
        hfig = plotParams.hfig;
        clf(hfig);
    else
        hfig = figure('Position',plotParams.figpos);
    end
    nowplaying = annotation('textbox', [0.25, 0.25, 0.5, 0.5], 'String', 'Now playing...', 'FontSize',36, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'LineStyle','none');
end

% play intervals
nInts = 2;
toneInt = randi(nInts); % choose random interval for tone
y = cell(1,nInts);      % preallocate signal array
for i = 1:nInts
    if i == toneInt
        y{i} = play_maskedTone(tone,toneAmp,masker,fs,maskerGain);
    else
        y{i} = play_maskedTone(tone,0,masker,fs,maskerGain);
    end
    pause(isi)
end

% plot
if plotParams.bPlot
    delete(nowplaying)
    q1 = annotation('textbox', [0.2, 0.2, 0.25, 0.5], 'String', '?', 'FontSize',48, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'LineStyle','none');
    q2 = annotation('textbox', [0.6, 0.2, 0.25, 0.5], 'String', '?', 'FontSize',48, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'LineStyle','none');
    len = length(y{1});
    x = 0:1/fs:(len-1)/fs;
    if plotParams.plotDelay
        pause(plotParams.plotDelay);
    else
        pause;
    end
    delete(q1);
    delete(q2);

    tiledlayout(hfig,2,nInts);
    for i = 1:nInts
        %% plot waveform
        nexttile(i);
        plot(x,y{i},'Color',[.3 .3 .3]);
        xlabel('time (s)')
        ylabel('amplitude')
        %ylim([-1 1]);
        if i == toneInt
            hold on;
            text(x(len/2),0.75,'*','HorizontalAlignment','center','FontSize',48,'Color','m');
        end
        makeFig4Screen;

        %% plot spectra
        nexttile(nInts+i);
        %plot(pspectrum(y{i},fs));
        [p, f] = pwelch(y{i}, 1024, 768, 1024, fs);
        semilogx(f, 10*log10(p))
        %ylim([-90 -30])
        xlabel('frequency (Hz)')
        ylabel('dB')
        %axis([0 20000 -90 -30])
        xlim([0 20000])

        % fix xticklabels (no scientific notation)
        curtick = get(gca, 'XTick');
        set(gca, 'XTickLabel', cellstr(num2str(curtick(:))));
        makeFig4Screen;
    end
end
