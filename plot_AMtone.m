function [hax] = plot_AMtone(hax,fm,fc,Mu,Ac)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(hax), hax = gca; end
if nargin < 2, fm = 100; end   % message signal frequency
if nargin < 3, fc = 5000; end  % carrier frequency
if nargin < 4, Mu = 0.9; end   % modulation index (modulation depth / 100)
if nargin < 5, Ac = 1; end     % carrier Amplitude

%fs = 100*fm; % sampling frequency with oversampling factor 100
fs = 20*fc;

t = 0:1/fs:.1;

% compute the AM signal
x_am = Ac*(1+Mu*cos(2*pi*fm*t-pi)).*cos(2*pi*fc*t); % Am equation

% compute envelope
x_env = abs(Ac*(1+Mu*cos(2*pi*fm*t-pi))); % equation of envelope

% plot
plot(hax,t,x_am,'k')
hold on;
plot(hax,t,x_env,'m--','LineWidth',3);
%plot(hax,t,-x_env,'m--','LineWidth',3);
%grid on;
xlabel('time (s)');
ylabel('amplitude')
makeFig4Screen;

end
