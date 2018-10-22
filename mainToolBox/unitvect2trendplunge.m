function [trendPlungeDegArray] = unitvect2trendplunge(orientUnitVectorArray)
%%%%%%%%%%%%%%%%%%%%
% [ trendPlungeRowarrayDeg ] =unitvect2trendplunge( orientUnitVector )
%%%%%%%%%%%%%%%%%%%%
%
%Description:
% Converts the orientation of a line expressed by its unit vector in the
% NED coordiante system to a paired array which expreses the trend and the
% plunge of a line on space (in hexagesimal grades). 
%
%Note(s):
% NED coordinate system is an orthogonal, dextrogire whose axes represent
% the north, the east and the nadir directions.
%
%Input(s):
% Vector expressing a direction (orientUnitVector).
%
%Output(s):
% Trend and pluge 1x2 row array (trendPlungeRowarrayDeg),where the first
% element is the trend and the second element is the plunge of the line on
% space, both in hexagesimal degrees.
%
%Example1:
% Obtain the trend/plunge values of the vector [0.2120 -0.1485 0.9659]' 
% By running v= unitvect2trendplunge([-0.2120 -0.1485 0.9659]) it is
% obtained a value of v =[215 75].
%
%%%%%%%%%%%%%%%%%%%%
% [ trendPlungeRowarrayDeg ] =unitvect2trendplunge( orientUnitVector )
%%%%%%%%%%%%%%%%%%%%

numData = size(orientUnitVectorArray, 1);
trendPlungeDegArray = zeros(numData, 2);

for  i = 1 : numData
    trendPlungeDegArray(i,:) =uvec2tp( orientUnitVectorArray(i,:) );
endfor
endfunction

function [trendPlungeRowarrayDeg] = uvec2tp( orientUnitVector )
# orientUnitVector = [0, 0];

%Verifiying zero elements vector
if nnz(orientUnitVector) == 0
    trendPlungeRowarrayDeg = [0, 0];
    %error('Vector should not have all their elements with zero value');
else

%Normalizing the input vector
unitOrientVec = orientUnitVector /norm(orientUnitVector);

%% Plunge calculation
plungeRadians = asin( unitOrientVec(3) );

%% Trend calculation
if unitOrientVec(1) ==0
    if unitOrientVec(2)>= 0
        trendRadians =pi /2;
    else
        trendRadians =pi *3 /2;
    endif
else
    relation =unitOrientVec(2) /unitOrientVec(1);
    if unitOrientVec(1) >=0
        if unitOrientVec(2) >=0
            trendRadians = atan(relation);
        else
            trendRadians =2 *pi - atan(-relation);
        endif
    else
        if unitOrientVec(2) >=0
            trendRadians =pi - atan(-relation);
        else
            trendRadians =pi + atan(relation);
        endif
    endif
endif
%% Converting to Degrees
trendDeg = trendRadians * 180 /pi;
plungeDeg = plungeRadians * 180 /pi;
trendPlungeRowarrayDeg = [trendDeg, plungeDeg];
endif

endfunction
% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 
