function [  ] =plotstereoequalanglepolargrid( sphereRadius, circResolution, ...
    gridResolutionDeg )
%
% Description:
% Plots the grid for an equalangle spherical polar projection
% representation. 
%
% External sub-function(s):
% Buzy+ toolbox: calculatepointscirculararc.
%
% Input(s):
% Radius of the reference sphere (sphereRadius).
% Resolution of the arc, given in number of segments in a whole
% cicumference (circResolution).
% Resolution of the stereografical representation,given in angular
% sexagesimal degrees. It varies from 0º to 90º, and normally 10º
% (gridResolutionDeg).
%
% Example1:
% Create a equalangle spherical projection polar grid, which has a
% great-circle radius of 1 unit. The grids ares spaced each 10º. The
% polylines that are part of the grid, each has 72 points.
% sphereRadius =1; circResolution =72; gridResolutionDeg =10;
% plotstereoequalanglegrid( 1, 72, 10 ).
%
%%%%%%%%%%%%%%%%%
% plotstereoequalanglegrid(sphereRadius, circResolution, gridResolutionDeg)
%%%%%%%%%%%%%%%%%

%% Angle calculations should be made in radianas
gridResolutionRad =gridResolutionDeg *pi /180;

hold on;
% Axis off and equal
axis (sphereRadius *[-1 ,1 ,-1 ,1], 'equal', 'off');

%% Drawing the external circle
externalCirc =calculatepointscirculararc...
    ( sphereRadius, (2 *pi), 0, [0 ,0], circResolution, false );
plot(externalCirc(:,1), externalCirc(:,2), 'k-');

%% Drawing the great circles

% Defining the angles
dipAnglesRad =(0 +gridResolutionRad) :gridResolutionRad :(pi/2 -gridResolutionRad);
% from (-90 +Delta) to (90 -Delta), with the 0
dipAnglesRad =[ 0, dipAnglesRad ];

greatCircRadii =sphereRadius *(sec(dipAnglesRad) -tan(dipAnglesRad));
for i=1 :length(dipAnglesRad)-1
    greatCircPoints =calculatepointscirculararc( greatCircRadii(i), ...
        (2 *pi), 0, [0, 0], circResolution, false );
    plot(greatCircPoints(:,1), greatCircPoints(:,2), 'k-');
end

%% Drawing the radials
dipdirAnglesRad =0: gridResolutionDeg*pi/180: 2*pi;
dipdirAnglesRad =dipdirAnglesRad(1:end-1);
[ x, y ] =pol2cart( dipdirAnglesRad, sphereRadius );

for i=1: length(dipdirAnglesRad)
    xyArray =[ 0, 0; x(i), y(i) ];
    plot( xyArray(:,1), xyArray(:,2), 'k-' );
end

%% Drawing the center
plot(0, 0, 'kx');
hold off;

end

