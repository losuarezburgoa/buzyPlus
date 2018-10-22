function [ rotatedTrendPlungeVec ] =rotateorientationaroundaxis...
    ( trendPlungeVec ,rotationAxisTrendPlungeVec ,rotationAngleGrad )
%lsb code
% [ rotatedTrendPlungeVec ] =rotateorientationaroundaxis...
%    ( trendPlungeVec ,rotationAxisTrendPlungeVec ,rotationAngleGrad )
%Description:
%Rotates an orientation, given in trend and plunge format (pole), a determined
%rotation angle taken another orientation as rotation axis.
%
%Nested function(s):
%rot_orient_arnd_verticalaxs, rot_orient_arnd_northernstrike,
%prepareorientationangles
%
%Input(s):
%Vector of trend and plunge values of the orietation wanted to rotate
%(trendPlungeVec)
%
%Vector of trend and plunge values of the orietation used as rotation
%axis (rotationAxisTrendPlungeVec)
%
%Angle of rotation in hexagesimal grades (rotationAngleGrad).
%If angle is positive the orientation rotates clockwise, if it is negative
%the orientation rotates counterclockwise.
%
%Output(s):
%Rotated orientation vector in trend and plunge format (rotatedTrendPlungeVec)
%
%Example:
%This is the example 3.6 given in Priest(1985), page 23 of Chapter 3.
%A line of initial trend/plunge 339/51 is rotated about an axis of
%trend/plunge 236/37 by an amount 124° in an anticlockwise direction
%looking down the axis. What is the resulting orienttion of the line?
%In the command line write:
%[ rotatedTrendPlungeVec ] =rotateorientationaroundaxis( [339 ,51] 
% ,[236 ,37] ,124 );
%The calculation gives a rotated orientation of [72.3345 ,30.5170] which is
%a more precise value of the [236 , 30] result given in Priest(1985).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ rotatedTrendPlungeVec ] =rotateorientationaroundaxis...
%    ( trendPlungeVec ,rotationAxisTrendPlungeVec ,rotationAngleGrad )

%Preparing orienttions for the desired rotation
angle01 =270 -rotationAxisTrendPlungeVec(1);
rotatedTrendPlungeVec =rot_orient_arnd_verticalaxs...
    ( trendPlungeVec ,angle01 );

angle02 =rotationAxisTrendPlungeVec(2);
rotatedTrendPlungeVec =rot_orient_arnd_northernstrike...
    ( rotatedTrendPlungeVec ,angle02 );

angle03 =-90;
[ rotatedTrendPlungeVec ] =rot_orient_arnd_verticalaxs...
    ( rotatedTrendPlungeVec ,angle03 );

%Roating around the axis
angle04 =rotationAngleGrad;
rotatedTrendPlungeVec =rot_orient_arnd_northernstrike...
    ( rotatedTrendPlungeVec ,angle04 );

%Now returning to the initial state
angle05 =-angle03;
rotatedTrendPlungeVec =rot_orient_arnd_verticalaxs...
    ( rotatedTrendPlungeVec ,angle05 );

angle06 =-angle02;
rotatedTrendPlungeVec =rot_orient_arnd_northernstrike...
    ( rotatedTrendPlungeVec ,angle06 );

angle07 =-angle01;
rotatedTrendPlungeVec =rot_orient_arnd_verticalaxs...
    ( rotatedTrendPlungeVec ,angle07 );

%Adjusting the final result
rotatedTrendPlungeVec =prepareorientationangles( rotatedTrendPlungeVec );

end

