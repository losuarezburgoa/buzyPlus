function [ circleArcPointMat, numberPoints ] = calculatepointscirculararc...
    ( radius, arcAngleRad, initialArcAngleRad, centerVec, resolution, want2see )
%lsb code
% [ circleArcPointMat, numberPoints ] = calculatepointscirculararc...
%    ( radius, arcAngleRad, initialArcAngleRad, centerVec, resolution, want2see )
%Description:
%Draws an in plane circular arc
%Input(s):
%Radius of the circular arc (radious).
%Circular arc angle in radians (arcAngleRad).
%Angle of the initial circular arc point in radians (initialArcAngleRad).
%Center of the circular arc given in a 2D vector (centerVec).
%Resolution given in number of segments per total circunference
%(resolution).
%Logical true value if it is wanted to see the resulting circular arc, else put 'false'.
%Output(s):
%An n x 3 matrix given the x,y coordinates of the arc and the final column of
%ones
%Example:
%[ circleArcPointMat, numberPoints ] = calculatepointscirculararc( 2,
%45/180*pi, 0/180*pi, [0, 0], 72, true )
%%%%%%%%%%%%%%%%%
%[ circleArcPointMat, numberPoints ] = calculatepointscirculararc...
%    ( radius, arcAngleRad, initialArcAngleRad, centerVec, resolution, want2see )

%Controling circunference resolution
numberSides =floor(arcAngleRad ./(2 *pi) *resolution) +1;

numberPoints =numberSides +1;
initialPoint =-arcAngleRad /2;
finalPoint =arcAngleRad /2;

%Generating the circular arc
theta =linspace(initialPoint ,finalPoint ,numberPoints);
rho =ones(1 ,numberPoints)*radius;
[circleArcPointMat3(:,1), circleArcPointMat3(:,2)] =pol2cart(theta ,rho);

circleArcPointMat2= [circleArcPointMat3, ones(numberPoints, 1)];

%Rotating around center
angleRad =initialArcAngleRad +arcAngleRad ./ 2;

rotationTMat =[cos(angleRad), -sin(angleRad), 0; sin(angleRad), ...
    cos(angleRad), 0; 0 ,0 ,1 ];
circleArcPointMat1 =circleArcPointMat2 *transpose(rotationTMat);

%Changing center position
displacementTMat =[1, 0, centerVec(1); 0, 1, centerVec(2); 0, 0, 1];
circleArcPointMat =circleArcPointMat1 *transpose(displacementTMat);

%Displaying the resulting figure
if want2see ==true
    hold on;
    plot(circleArcPointMat(:,1), circleArcPointMat(:,2), 'k-');
    axis equal;
    hold off;
end
end

