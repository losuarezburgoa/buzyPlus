function [trendPlungeArray] = dipdirdip2polearray (dipDirDipArray)
%
%Description:
% Transforms dip-direction and dip pairs in an array to pole trend-plunge
% pairs in another array.
% 
% Nested functions:
% dipdirdip2pole.
% 
% Input(s):
% Dip-direction and Dip array, where each row has a pair, (dipDirDipArray).
%
% Output(s):
% Trend-Plunge array, where each row has the trend and plunge of the pole
% of the plane, (trendPlungeArray).
%
% Example1:
% Given the dip-Dir and Dip array calculate the trend and plunge array.
%  dipDirDipArray =[ 23, 56; 105, 63; 205, 12; 295, 80 ];
% Answer: [ 203, 34; 285, 27; 25, 78; 115, 10 ].
%

warning('This function is deprecated, use instead ''dipdirdip2pole'' function!');

%% The code
numData =size(dipDirDipArray,1);
trendPlungeArray =zeros(numData ,2);
for i=1 : numData
    trendPlungeArray(i,:) =dipdirdip2pole( dipDirDipArray(i,:) ); 
endfor
endfunction
% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 
