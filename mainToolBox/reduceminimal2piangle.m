function [ reducedAngleRad ] = reduceminimal2piangle( angleRad )
%lsb code
%[ reducedAngleRad ] = reduceminimal2piangle( angleRad )
%Description:
%Reduces an angle that has a magnitude greater to 2*pi, to an equivalent
%angle expressed inside 0° to 2*pi.
%
%Input(s):
%Angle o angle vector in hexagesimal agular grades (angleRad).
%
%Output(s):
%Reduced angle in hexagesimal angular grades (reduceAngleRad).
%%%%%%%%%%%%%%%%%%%%%
%[ reducedAngleGrad ] = reduceminimal2piangle( angleRad )

reducedAngleRad =angleRad;
for i=1 :length( angleRad )
    if angleRad(i) >2*pi
        reducedAngleRad(i) =angleRad(i) -floor(angleRad(i) /2 /pi) *2 *pi;
    else
        if angleRad(i) <-2*pi
           reducedAngleRad(i) =angleRad(i) -ceil(angleRad(i) /2 /pi) *2 *pi; 
        end
    end
end

end
 reducedAngleRad1  = reduceminimal2piangle( 0.5*pi )

reducedAngleRad2  = reduceminimal2piangle( [ pi 270 80 0.5*pi ] )

 reducedAngleRad3  = reduceminimal2piangle( -270 )
