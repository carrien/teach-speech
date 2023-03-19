function [px] = dBSPL2px(dBSPL)

pref = 2*10^-5;
px = pref*10^(dBSPL/20);
