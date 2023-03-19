function [y,fs] = play_narrowbandNoise(cf,bw,dur,fs)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1 || isempty(cf), cf = 2000; end % center frequency
if nargin < 2 || isempty(bw), bw = 0.25; end % bandwidth in octaves
if nargin < 3 || isempty(dur), dur = 1; end  % duration in seconds
if nargin < 4, fs = 11025; end               % sampling frequency

[y,fs] = get_narrowbandNoise(cf,bw,dur,fs);
ap = audioplayer(y,fs);
playblocking(ap);

end
