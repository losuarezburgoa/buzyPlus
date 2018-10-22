function [ angleRad ] = grad2rad( angleGrad )
%lsb code
%Description:
%Transforms an angle expressed in hexadecimal angular grades to an
%angle expressed radians.
%
%Input:
%Angle in hexagesimal angular grades (angleGrad)
%Output:
%Angle in radians (angleRad)
%
angleRad= angleGrad;
angleRad(:) =angleGrad(:) *pi /180;
end

