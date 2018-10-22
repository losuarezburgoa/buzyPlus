function [ reducedAngleGrad ] = reduceminimal180angle( angleGrad )
%lsb code
%[ reducedAngleGrad ] = reduceminimal180angle( angleGrad )
%Description:
%Reduces an angle that has a magnitude greater to 180°, to an equivalent
%angle expressed inside 0° to 180°. Usefull for pitch angles
%
%Input(s):
%Angle o angle vector in hexagesimal agular grades (angleGrad).
%
%Output(s):
%Reduced angle in hexagesimal angular grades (reduceAngleGrad).
%%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleGrad ] = reduceminimal180angle( angleGrad )

reducedAngleGrad =angleGrad;
for i=1 :length( angleGrad )
    if angleGrad(i) >180
        reducedAngleGrad(i) =angleGrad(i) -floor(angleGrad(i) /180) *180;
    else
        if angleGrad(i) <-180
           reducedAngleGrad(i) =angleGrad(i) -ceil(angleGrad(i) /180) *180; 
        end
    end
end

end

reducedAngleGrad1  = reduceminimal180angle ( 270 )

reducedAngleGrad2  = reduceminimal180angle ( -360 )

reducedAngleGrad3  = reduceminimal180angle( [ 270 300 256 500 ] )

reducedAngleGrad4  = reduceminimal180angle( [-305 460 1256 ])

