function [ reducedAngleDeg ] =reduceminimal90angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleDeg ] =reduceminimal180angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%
%
%Description:
% Reduces an angle that has a magnitude greater to 180 to an equivalent
% angle expressed between 0 to 90. Usefull for pitch angles.
%
%Input(s):
% Angle or angle vector in hexagesimal angular degrees, (angleDeg).
%
%Output(s):
% Reduced angle in hexagesimal angular degrees, (reduceAngleGrad).
%
%Example1:
% With angleDeg =[ 0 90 105 230 ], one returns a data of [0, 90, 15, 50].
%
%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleDeg ] =reduceminimal180angle( angleDeg )
%%%%%%%%%%%%%%%%%%%%

%%
reducedAngleDeg =angleDeg;
for i=1 :length( angleDeg )
    if angleDeg(i) >90
        reducedAngleDeg(i) =angleDeg(i) -floor(angleDeg(i) /90) *90;
    else
        if angleDeg(i) <-90
           reducedAngleDeg(i) =angleDeg(i) -ceil(angleDeg(i) /90) *90; 
        end
    end
end
end
% Written by: Ludger O. Suarez-Burgoa, Assistant Professor,
% Universidad Nacional de Colombia, Medellin
% Copyright (c) 2013, Universidad Nacional de Colombia and Ludger O.
% Suarez-Burgoa (See license.txt file) 


reducedAngleDeg1 =reduceminimal90angle( [0 90 180 230 260 300 350] )

reducedAngleDeg2 =reduceminimal90angle( -[0 90 180 230 260 300 350] )

reducedAngleDeg3 =reduceminimal90angle( 240 )

reducedAngleDeg4 =reduceminimal90angle( -160 )



