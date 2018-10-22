function [ x ,y ] = nepol2cart( thetaRad ,rho )
%lsb code
%[ x ,y ] = nepol2cart( thetaRad ,rho )
%
%Description:
%Transforms the coordinates of a point specified in the north clockwise
%polar coordinates to cartesian coordintes.  
%The North-East system, has its first axis pointing forward and the second
%axis poiinting to the rigth. The positive angle displaces from its origin
%in the north-axis to the east-axis clockwise.
%The cartesian system is the conventional one, x-axis (i.e. first axis)
%pointing to the rigth and y-axis (i.e. second axis) pointing forward.
%Positive angles displace from its origin in the x-axis to the y-axis
%counterclockwise. 
%
%Input(s):
%The angular polar angle in radians (thetaRad) is a clockwise angular
%displacement from the positive North-axis. 
%The polar radius (rho) is the distance from the origin to a point in the
%North-East plane. 
%
%Output(s):
%Coordinate x of the point.
%Coordinate y of the point.
%%%%%%%%%%%%%%%%%%%%%%%%
%[ x ,y ] = nepol2cart( thetaRad ,rho )

if length(thetaRad) ~= length(rho) 
  error('vectors lengths must be equal');
end

for i =1:length(thetaRad)
    x =rho .*sin(thetaRad);
    y =rho .*cos(thetaRad);
end

end

