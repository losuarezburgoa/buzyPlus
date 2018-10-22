function [ angleGrad ] = rad2grad( angleRad )
%lsb code
%Description:
%Transforms an angle expressed in radians to an angle expressed in
%hexadecimal angular grades
%
%Input:
%Angle in radians (angleRad)
%
%Output:
%Angle in hexagesimal angular grades

angleGrad =angleRad;
angleGrad(:) =angleRad(:) /pi *180;
end

[ angleGrad ] = rad2grad( 3*pi )
angleGrad =  540 

[ angleGrad ] = rad2grad(pi )
angleGrad =  180 

[ angleGrad ] = rad2grad(-pi )
angleGrad = -180 