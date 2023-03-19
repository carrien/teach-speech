function [h] = plot_AMtoneGrid(fms,mus,fc)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(fms), fms = [10 50 100; 0 50 0; 0 50 0]; end %fms = [10 50 100]; end
if nargin < 2 || isempty(mus), mus = [1 1 1; 0 0.5 0; 0 0.25 0]; end %mus = [1 .25 .1]; end
if nargin < 3 || isempty(fc), fc = 1000; end

h = figure;

tl = tiledlayout(size(fms,1),size(fms,2));
%tl.TileSpacing = 'none';
%tl.TileSpacing = 'compact';
tl.Padding = 'none';
%tl.Padding = 'compact';

hax2del = [];
for i = 1:size(fms,1)
    for j = 1:size(fms,2)
        fm = fms(i,j);
        mu = mus(i,j);
        nexttile;
        if fm
            plot_AMtone([],fm,fc,mu);
        else
            hax2del = [hax2del gca];
        end
    end
end
delete(hax2del);
