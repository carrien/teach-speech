function [h] = plot_loudness_intensity()
%PLOT_LOUDNESS_INTENSITY Plot relationship between intensity and loudness.
%   

h = figure('Position',[165.0000  124.3333  921.3333  342.0000]);
x = 0:1000; plot(x,x.^.3,'Color',[144 0 208]./255); makeFig4Screen;
hold on;
x1 = 10; plot([x1 x1],[0 x1.^.3],'k--'); plot([0 x1],[x1.^.3 x1.^.3],'k--');
x1 = 100; plot([x1 x1],[0 x1.^.3],'k--'); plot([0 x1],[x1.^.3 x1.^.3],'k--');
x1 = 1000; plot([x1 x1],[0 x1.^.3],'k--'); plot([0 x1],[x1.^.3 x1.^.3],'k--');
