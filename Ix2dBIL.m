function [dBIL] = Ix2dBIL(Ix)

Iref = 10^-12;
dBIL = 10*log10(Ix/Iref);
