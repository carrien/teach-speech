function [] = play_tuningCurve(tone,toneAmp,masker,fs,isi,plotParams,maskerGain)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1, tone = 400; end
if nargin < 2, toneAmp = .01; end
if nargin < 3, masker = 400; end
if nargin < 4 || isempty(fs), fs = 11025; end % sampling frequency
if nargin < 5, isi = .3; end   % interstimulus interval in seconds
if nargin < 6, plotParams = []; end
if nargin < 7 || isempty(maskerGain), maskerGain = 1; end % gain

fprintf('Masker gain starting at %.3f\n',maskerGain)
deltaGain = maskerGain*(2/10);

while 1
    play_freqSelect2I2AFC(tone,toneAmp,masker,fs,isi,plotParams,maskerGain)
    txt = input("Correct?","s");
    switch txt
        case 'y'
            maskerGain = maskerGain + deltaGain;
        case 'n'
            maskerGain = maskerGain - deltaGain;
        otherwise
    end
    fprintf('Masker gain set to %.3f\n',maskerGain)
    close;

end