function [melody] = get_melody(f0,startFreq,harmonics)
%GET_MELODY Create array of pure tones/harmonic complexes.
%   GET_MELODY(F0,STARTFREQ,HARMONICS)

if nargin < 1 || isempty(f0), f0 = 200; end
if nargin < 2 || isempty(startFreq), startFreq = 6000; end
if nargin < 3 || isempty(harmonics), harmonics = 1; end

amp = 1;
dur = .2; %(1/f0)*1200; % 1200 cycles = 0.2 for 6000 Hz
fs = 44100;

%% pure tones

if length(harmonics)==1 && harmonics==1
    
    C = get_sine(f0,1,0,dur,fs);
    D = get_sine(get_noteInterval(f0,2),amp,0,dur,fs);
    E = get_sine(get_noteInterval(f0,3),amp,0,dur,fs);
    G = get_sine(get_noteInterval(f0,5),amp,0,dur,fs);
    rest = get_sine(get_noteInterval(f0,3),.001,0,dur,fs);
    z = zeros(1,100);
    
    %mhall = [E D C D E z E z E rest D z D z D rest E z G z G rest E D C D E z E z E z E D z D E D C];
    %mhall = [E z D z C z D z E z E z E z rest z D z D z D z rest z E z G z G z rest z E z D z C z D z E z E z E z E z D z D z E z D z C];
    mhall = [E D C D E E E E D D D D E G G G E D C D E E E E D D E D C];
    melody = mhall;
    
    %% unresolved harmonics
    
else
    
    amp = amp/4.7;
    
    for i=1:length(harmonics)
        harmonicNum = harmonics(i);
        C_unresolved(i,:) = get_sine(f0*harmonicNum,amp,0,dur,fs);
        D_unresolved(i,:) = get_sine(get_noteInterval(f0,2)*harmonicNum,amp,0,dur,fs);
        E_unresolved(i,:) = get_sine(get_noteInterval(f0,3)*harmonicNum,amp,0,dur,fs);
        G_unresolved(i,:) = get_sine(get_noteInterval(f0,5)*harmonicNum,amp,0,dur,fs);
    end
    
    C = sum(C_unresolved);
    D = sum(D_unresolved);
    E = sum(E_unresolved);
    G = sum(G_unresolved);
    
    mhall_unresolved = [E D C D E E E E D D D D E G G G E D C D E E E E D D E D C];
    
    %melody = mhall;
    melody = mhall_unresolved;
    
end
