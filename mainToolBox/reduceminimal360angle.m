function [ reducedAngleDeg ] =reduceminimal360angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleDeg ] =reduceminimal360angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%
%
%Description:
% Reduces an angle that has a magnitude greater to 360, to an equivalent
% angle expressed between 0 to 360.
%
%Input(s):
% Angle or angle vector in hexagesimal agular degrees (angleDeg).
%
%Output(s):
% Reduced angle in hexagesimal angular degrees (reduceAngleGrad).
%
%Example1:
% angleDeg =[ 0, 360, 400, 540, 850 ]
% Using this function one returns a reduced data of [ 0, 360, 40, 180, 130 ].
%
%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleDeg ] =reduceminimal360angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%

%% The code
reducedAngleDeg =angleDeg;
for i=1 :length( angleDeg )
    if angleDeg(i) >360
        reducedAngleDeg(i) =angleDeg(i) -floor(angleDeg(i) /360) *360;
    else
        if angleDeg(i) <-360
           reducedAngleDeg(i) =angleDeg(i) -ceil(angleDeg(i) /360) *360; 
        end
    end
end
end
% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 


 reducedAngleDeg1  =reduceminimal360angle( 700 )
 
  reducedAngleDeg2  =reduceminimal360angle( -500 )
  
   reducedAngleDeg3  =reduceminimal360angle( [700 450 -370 365] )
