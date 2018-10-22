function [ neCircleArcPointMat ] = calpointsnecirculararcpol...
    ( radius, arcAngleRad, initialArcAngleRad, resolution, want2see )
%lsb code
% [ neCircleArcPointMat ] = calpointsnecirculararcpol...
%    ( radius, arcAngleRad, initialArcAngleRad, resolution, want2see )
%Description:
%Calculates the polar coordinaaes in the north-east coordinate system of a
%circular arc to be drawn in a stereoplot of spherical radius of one (i.e.
%maximum radius for the arch is 1). 
%
%Nested function(s):
%polar2nepolar
%
%Input(s):
%Radius of the circular arc (radious).
%Circular arc angle in radians (arcAngleRad).
%Angle of the initial circular arc point in radians (initialArcAngleRad).
%Resolution given in number of segments per total circunference
%(resolution).
%Logical true value if it is wanted to see the resulting circular arc, else
%put 'false'. 
%
%Output(s):
%An n x 3 matrix given the polar coordinates of the arc 
%
%Example:
%[ circleArcPointMat ] = calpointsnecirculararcpol( 3, 180*pi/180,
%  30*pi/180, 72, true )
%%%%%%%%%%%%%%%%%
% [ neCircleArcPointMat ] = calpointsnecirculararcpol...
%    ( radius, arcAngleRad, initialArcAngleRad, resolution, want2see )



%In the case where arcAngleRad is negative
if arcAngleRad <0
    arcAngleRad = -arcAngleRad;
    %Verifiying that arc is less or equal to 2*pi
    if arcAngleRad >2*pi
        arcAngleRad =arcAngleRad -2*pi;
    end
    initialArcAngleRad =initialArcAngleRad +(2 *pi +arcAngleRad);
    initialArcAngleRad =grad2rad( reduceminimal360angle( rad2grad(initialArcAngleRad) ) );
else
    %Verifiying that arc is less or equal to 2*pi
    if arcAngleRad >2*pi
        arcAngleRad =arcAngleRad -2*pi;
    end
end
%Calculating number of sides according to resolution
numberSides =floor(arcAngleRad ./(2 *pi) *resolution) +1;
%Calculating number of points
numberPoints =numberSides +1;
initialPoint =initialArcAngleRad;
finalPoint =initialArcAngleRad +arcAngleRad;

%Generating the circular arc
theta =linspace(initialPoint ,finalPoint ,numberPoints);
rho =ones(1 ,numberPoints) *radius;

neCircleArcPointMat(: ,1) =theta;
neCircleArcPointMat(: ,2) =rho;

%Displaying the resulting figure
if want2see ==true
    hold on;
    %Constants
    graphOptions ='k-';
    sphereRadius =1;
    centerVec =[ 0 , 0 ];
    %Transforing coordinates to north east sysytem
    toPlotMat(:,1) =polar2nepolar( theta );
    toPlotMat(:,2) =rho;
    %Plotting the arc
    polar(toPlotMat(:,1), toPlotMat(:,2), graphOptions);
    %Ploting the center
    polar(centerVec(1), centerVec(2), 'k+');
    %Adjustiing the axes
	axis( [centerVec(1)-sphereRadius ,centerVec(1)+sphereRadius ,centerVec(2)-sphereRadius ,centerVec(2)+sphereRadius] ,'square' );
end

end

