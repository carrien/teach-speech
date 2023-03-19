function [h] = plot_SHMparams()
%PLOT_SHMPARAMS  Plot parameters of simple haromnic motion. [In progress]

amps = [.5 1 2 4];
freqs = [500 1000 2000 4000];
phases = [0 pi/2 pi 3*pi/2];

h = figure;
tiledlayout(3,3)
for i=1:length(amps)
nexttile
[sinewave,t] = get_sine(freq,amp,phaseoffset);
plot(t,sinewave)
end