function [y] = play_maskedTone(tone,toneAmp,masker,fs,maskerGain)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1, tone = []; end
if nargin < 2, toneAmp = []; end
if nargin < 3, masker = []; end
if nargin < 4 || isempty(fs), fs = 11025; end   % sampling frequency
if nargin < 5 || isempty(maskerGain), maskerGain = 1; end % gain

if ~isempty(tone) && isnumeric(tone)
    tone = struct('freq',tone);
    if ~isempty(toneAmp) && isnumeric(toneAmp)
        tone.amp = toneAmp;
    end
end
if isnumeric(masker)
    masker = struct('cf',masker);
end

defaultTone.freq = 1000;
defaultTone.amp = .01;
defaultTone.phaseOffset = 0;
defaultTone.dur = 1;
tone = set_missingFields(tone,defaultTone,0);
defaultMasker.cf = 2000;
defaultMasker.bw = 0.25;
defaultMasker.dur = 1;
masker = set_missingFields(masker,defaultMasker,0);

yTone = get_sine(tone.freq,tone.amp,tone.phaseOffset,tone.dur,fs);
yMasker = get_narrowbandNoise(masker.cf,masker.bw,masker.dur,fs,maskerGain);
yMasker = yMasker';
toneLen = length(yTone);
maskLen = length(yMasker);

if isempty(yTone)
elseif toneLen == maskLen
elseif toneLen > maskLen
    lendiff = toneLen - maskLen;
    yMasker = [nan(1,floor(lendiff/2)) yMasker nan(1,ceil(lendiff/2))];
elseif toneLen < maskLen
    lendiff = maskLen - toneLen;
    yTone = [nan(1,floor(lendiff/2)) yTone nan(1,ceil(lendiff/2))];
end
y = cat(1,yTone,yMasker);
y = nansum(y,1);

%ap = audioplayer(y,fs);
%playblocking(ap);
soundsc(y,fs);
dur = length(y)/fs;
pause(dur);

end
