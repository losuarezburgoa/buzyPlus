function [  ] =plotstereoequalangleequatorialgrid( sphereRadius, circResolution, ...
    gridResolutionDeg )
%
% Description:
% Plots the grid for an equalangle spherical equatorial projection
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
% Create a equalangle spherical projection equatorial grid, which has a
% great-circle radius of 1 unit. The grids ares spaced each 10º. The
% polylines that are part of the grid, each has 72 points.
% sphereRadius =1; circResolution =72; gridResolutionDeg =10;
% plotstereoequalanglegrid( 1, 72, 10 ).
%
%%%%%%%%%%%%%%%%%
% plotstereoequalangleequatorialgrid(sphereRadius, circResolution, gridResolutionDeg)
%%%%%%%%%%%%%%%%%

%% Angle calculations should be made in radianas
gridResolutionRad =gridResolutionDeg *pi /180;

hold on;
% Axis off and equal
axis (sphereRadius *[-1 ,1 ,-1 ,1], 'equal', 'off');

%% Drawing the external circle
externalCirc =calculatepointscirculararc...
    ( sphereRadius, 2 *pi, 0, [0 ,0], circResolution, false );
plot(externalCirc(:,1), externalCirc(:,2), 'k-');

%% Drawing the great circles

% Defining the angles
% from (-90 +Delta) to (0 -Delta)
dipAnglesRad1 =(-pi /2 +gridResolutionRad) :gridResolutionRad :(0 -gridResolutionRad);
% from (0 +Delta) to (90 -Delta)
dipAnglesRad2 =(0 +gridResolutionRad) :gridResolutionRad :(pi/2 -gridResolutionRad);
% from (-90 +Delta) to (90 -Delta), without the 0
dipAnglesRad =[ dipAnglesRad1, dipAnglesRad2 ];

greatCircCentersX =-sphereRadius *tan(dipAnglesRad);
greatCircRadii =sphereRadius ./cos(dipAnglesRad);
greatCircArcAnglesRad =2 *asin(sphereRadius ./greatCircRadii);

for i=1 :length(dipAnglesRad) /2;
    greatCircPoints =calculatepointscirculararc( greatCircRadii(i), ...
        greatCircArcAnglesRad(i), (-greatCircArcAnglesRad(i)/2 +pi), ...
        [ greatCircCentersX(i), 0 ], circResolution, false );
    plot(greatCircPoints(:,1), greatCircPoints(:,2), 'k-');
end
for i=(length(dipAnglesRad)/2 +1) :length(dipAnglesRad);
    greatCircPoints =calculatepointscirculararc( greatCircRadii(i), ...
        greatCircArcAnglesRad(i), (-greatCircArcAnglesRad(i)/2), ...
        [ greatCircCentersX(i), 0 ], circResolution, false );
    plot( greatCircPoints(:,1), greatCircPoints(:,2), 'k-' );
end

%% Drawing the small circles

pitchAnglesRad1 =(-pi/2 +gridResolutionRad):gridResolutionRad :(0 -gridResolutionRad);
pitchAnglesRad2 =(0 +gridResolutionRad):gridResolutionRad :(pi/2 -gridResolutionRad);
pitchAnglesRad =[ pitchAnglesRad1 ,pitchAnglesRad2 ];

smallCircCentersY =sphereRadius ./cos(pitchAnglesRad);
smallCircRadious =sphereRadius .*tan(abs(pitchAnglesRad));
smallCircArcAngleRad =2 *atan(sphereRadius ./smallCircRadious);

for i=1 :length(pitchAnglesRad) /2;
    smallCircPoints =calculatepointscirculararc(smallCircRadious(i), smallCircArcAngleRad(i),...
        -smallCircArcAngleRad(i) /2 -pi/2 , [0, smallCircCentersY(i)] ,circResolution ,false);
    plot(smallCircPoints(:,1), smallCircPoints(:,2), 'k-');
end
for i=length(pitchAnglesRad) /2 +1 :length(pitchAnglesRad);
    smallCircPoints =calculatepointscirculararc(smallCircRadious(i), smallCircArcAngleRad(i),...
        -smallCircArcAngleRad(i) /2 +pi/2, [0 ,-smallCircCentersY(i)] ,circResolution ,false);
    plot(smallCircPoints(:,1), smallCircPoints(:,2), 'k-');
end

%% Drawing the center cross lines
verticalLine =sphereRadius *[0 ,-1; 0 ,1];
horizontalLine =sphereRadius *[-1, 0; 1, 0];
plot(verticalLine(:,1), verticalLine(:,2), 'k-');
plot(horizontalLine(:,1), horizontalLine(:,2), 'k-')

%% Drawing the center
plot(0, 0, 'kx');
hold off;

end

