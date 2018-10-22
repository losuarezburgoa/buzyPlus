function [unitVectorArray] = trendplunge2unitvect (trendPlungeDegArray)

%
%Description:
% Transforms trend/plunge orientation angles expressed in hexagesimal
% degrees to an unitary vector expressed in the NED coordinate system.
%Note(s):
% If the line plunges upwards the horizontal plane, specify a negative
% value. If the line plunges downwards the horizontal plane, specify a
% positive value.
% Plunge varies from -90 to 90 and trend varies from 0 to 360.
% If any of those values are specified outside this range, the program will
% convert properly.
% All vertical plunge has a zero trend by convention.
% 
%Nested functions:
% reduceminimal360angle, reduceminimal90angle.
% 
%Input(s):
% The trend and plunge 1x2 array (tpArray), where values are
% given in sexagesinmal degrees.
%
%Output(s):
% Unit row vector of 1x3 which represents the line direcction in the NED
% coordinate.
%
%Example1:
% tpArray = [235 ,12]
% A line direction expressed with their trend and plunge of 235 and 12
% degrees, respectively has an unit vector of [ -0.5610, -0.8013, 0.2079 ].
%

numData = size(trendPlungeDegArray, 1);
unitVectorArray = zeros(numData, 3);
for i = 1 : numData
    unitVectorArray(i,:) = tp2uvec (trendPlungeDegArray(i,:));
endfor
endfunction

function [uVec] = tp2uvec (tpArray)

trendDeg = tpArray(1);
plungeDeg = tpArray(2);

trendRad = (pi / 180) * reduceminimal360angle (trendDeg);
plungeRad = (pi / 180) * reduceminimal90angle (plungeDeg);

orientVector = [ ...
    cos(trendRad) * cos(plungeRad); ...
    sin(trendRad) * cos(plungeRad); ...
    sin(plungeRad)];

uVec = orientVector / norm(orientVector);
endfunction

% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 