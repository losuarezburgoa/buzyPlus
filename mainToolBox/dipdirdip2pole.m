function [trendPlungeArray] = dipdirdip2pole (dipDirDipArray)

%
%Description:
% Transforms the information of a geological plane given by the dip-
% direction and dip row-vector (dDirDipVec) to their correspondent pole
%  vector (poleVec) proyected to the southern hemisfere.
%
%Input(s):
% Dip-direction \ Dip row-vector of the plane given in degrees, (dDirDipVec).
%
%Output(s):
% Trend \ Plunge pole row vector of the line normal to the plane in
% degrees, (poleVec).
%
## Example1:
## The corresponding dip-direction dip vector [350 ,12] is in polar vector equal
## to [170 ,78].

numData = size(dipDirDipArray,1);
trendPlungeArray = zeros(numData ,2);
for i=1 : numData
    trendPlungeArray(i,:) = ddd2p (dipDirDipArray(i,:)); 
endfor
endfunction

function [poleVec] = ddd2p (dDirDipVec)

%% The code
dipDirection = dDirDipVec(1);
dip = dDirDipVec(2);
% Plunge of the pole
polePlunge = 90 - dip;
% Trend of the pole
dDirr = dipDirection + 180;
    if dDirr > 360
        poleTrend = dDirr - floor(dDirr / 360) * 360;
    else
        poleTrend = dDirr;
    endif
poleVec = [poleTrend, polePlunge];
endfunction
% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 

