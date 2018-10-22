function [ planePolarMat ] =equalangletrendplunge2planepolar_array( trendPlungeMat )
%
%Description:
%Performs the same calculations as the 'equalanglepolar2planepolar' but for
%a trendPlungeMat and not for a single vector.
%
%Nested Function(s):
%equalanglepolar2planepolar
%
%Input(s):
%Matrix of trend-plunge values (trendPlungeMat)
%
%Output(s):
%Matrix of polar points represented in a equalangle projection plane.

warning("This function is deprecated, use instead 'equalanglepolar2planepolar'!";

dataNumber = size(trendPlungeMat, 1);
planePolarMat = zeros(size(trendPlungeMat));

for i = 1 : dataNumber
    [planePolarMat(i ,1), planePolarMat(i ,2)] = ...
        equalanglepolar2planepolar (trendPlungeMat(i ,:));
endfor

endfunction

