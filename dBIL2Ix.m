function [Ix] = dBIL2Ix(dBIL)

Iref = 10^-12;
Ix = Iref*10^(dBIL/10);
