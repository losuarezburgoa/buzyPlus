function [ nePolarAngleRad ] =polar2nepolar( polarAngleRad )
%lsb code
%[ northCountAngleRad ] = eastcounter2northclockwise( eastCountAngleRad )
%
%Description:
%Transforms a radian angle that is measured from the east-axis and counter
%clockwise sense to an angle that need to be measured from the north-axis
%and clockwise sense.
%
%Input(s):
%East-axis and counterclockwise angle in radians
%(eastCountAngleRad).
%
%Output(s):
%North-axis and clockwise angle in radians
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ northCountAngleRad ] = eastcounter2northclockwise( eastCountAngleRad )

nePolarAngleRad =zeros(length(polarAngleRad));

for i =1 :length(polarAngleRad)
    if polarAngleRad > pi /2;
         nePolarAngleRad =(2 *pi +pi/2 -polarAngleRad)...
             -floor( (2 *pi +pi/2  -polarAngleRad) ./2 ./pi ) *2 *pi;
    else
        nePolarAngleRad =pi /2 -polarAngleRad;
    end
end

end

