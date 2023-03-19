function [noteOut] = get_noteInterval(noteIn,interval)
%GET_NOTEINTERVAL  Get note frequency for a specified interval.

switch interval
    case {2, 'second'}
        n = 2;
    case {2.5, 'minor third'}
        n = 3;
    case {3, 'third'}
        n = 4;
    case {4, 'fourth'}
        n = 5;
    case {5, 'fifth'}
        n = 7;
    case {6, 'sixth'}
        n = 9;
    case {7, 'seventh'}
        n = 11;
    otherwise
        n = 12;
end

noteOut = noteIn.*2^(n/12);
