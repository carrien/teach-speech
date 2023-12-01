function [y,fs] = get_narrowbandNoise(cf,bw,dur,fs,gain)
%GET_NARROWBANDNOISE Create narrowband noise.
%   GET_NARROWBANDNOISE(CF,BW,DUR,FS)

if nargin < 1 || isempty(cf), cf = 2000; end  % center frequency
if nargin < 2 || isempty(bw), bw = 0.25; end  % bandwidth in octaves
if nargin < 3 || isempty(dur), dur = 1; end   % duration in seconds
if nargin < 4 || isempty(fs), fs = 11025; end % sampling frequency
if nargin < 5 || isempty(gain), gain = 1; end % gain

low_f = cf/2^(bw/2);      % lower limit of freq range
high_f = cf*2^(bw/2);     % upper limit of freq range

% generate a gaussian white signal
n = round(dur*fs);  % number of samples
x = randn(n,1);

% apply bandpass filter
y = bandpass(x, [low_f high_f],fs).*gain;
%[p, f] = pwelch(y, 1024, 768, 1024, fs);
%plot(f, 10*log10(p))

end
