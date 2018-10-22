function [closedCurveMat2, closedCurveMat1, polarMatrix2, polarMatrix1] = ...
    particioned_clusterwindow (trendPlungeVec, coneSemiAngleGrad, ...
    projectionType, want2see)
#
## Description:
# Creates the trend and plunge data of poits that are part of a circular
# cluster cone which is partitioned in two curves because of its proximitiy to
# the extremes to the greatcircle of plunge 0.
# 
# Nested function(s):
# first_point_cluster_greatcircle_intersection, reduceminimal360angle,
#   rot_orient_arnd_northernstrike, rot_orient_arnd_verticalaxs,
#   equalanglepolar2planepolar, plotplaneorientationdata
# 
## Input(s)
# Vector of the trend and plunge data of the cone axis (trendPlungeVec)
# 
# Semi-angle of the the cone in hexagesimal grades (coneSemiAngleGrad)
# 
# Type of projection to display the resultant cluster (projectionType)
#
# Logical option if is desired to see the results (want2see)
# 
## Output(s):
# Matrix of trend and plunge values that defines the steepest part of the
# circular cluster (closedCurveMat2)
# 
# Matrix of trend and plunge values that defines the other part of the
# circular cluster (closedCurveMat1)
# 
# Matrix of polar coordiantes of values that defines the steepest part of
# the circular cluster (polarMatrix2)
#
# Matrix of polar coordiantes of values that defines the other part of the
# circular cluster (polarMatrix1)
#
## Example1:
# [rotatedConeMat, polarMatrix] = particioned_clusterwindow ([45, 10], 20, ...
#      'equalangle', true);

## Example 2:
## rotatedConeMat = particioned_clusterwindow ([270, 15], 20, 'equalarea', 1);

a = trendPlungeVec(2) - coneSemiAngleGrad;
if a >= 0
    error('The function "particioned_clusterwindow" only performas cases where the cluster is partitioned');
end

%CURVE PARAMETERS
%Resolution in number of sides per complete circle
resolution = 72;

%OBTAINING THE CIRCLE EXTREMES IN INCLINED POSITION
% First point
firstPointIntVec = first_point_cluster_greatcircle_intersection ...
    (trendPlungeVec(2), coneSemiAngleGrad);
firstPointIntVec(2) = 0;

% Second point
secondPointIntVec = zeros(1, 2);
secondPointIntVec(1) = 180 - firstPointIntVec(1);

%Third point
thirdPointIntVec = zeros(1, 2);
thirdPointIntVec(1) = 180 + firstPointIntVec(1);

%Fourth point
fourthPointIntVec = zeros(1, 2);
fourthPointIntVec(1) = 180 + secondPointIntVec(1);

%Rotating first and second point to vertical position
if trendPlungeVec(2) == 0
    vertFirstPointIntVec = [0, (90 - coneSemiAngleGrad)];
    vertSecondPointIntVec = [180, (90 - coneSemiAngleGrad)];
else
    rotationAngleGrad =90 - trendPlungeVec(2);
    vertFirstPointIntVec = rot_orient_arnd_northernstrike ...
        (firstPointIntVec, rotationAngleGrad);
    vertSecondPointIntVec = rot_orient_arnd_northernstrike ...
        (secondPointIntVec, rotationAngleGrad); 
endif
    
% GENERATING THE VERTICAL CONE.
% First curve.
initialTrendRad1 = vertFirstPointIntVec(1) * pi / 180;
finalTrendRad1 = vertSecondPointIntVec(1) * pi / 180;
interval1 = finalTrendRad1 - initialTrendRad1;
numberPoints1 = floor(interval1 / (2 * pi) * resolution) + 2;

verticalTrendVec1 = linspace (initialTrendRad1, finalTrendRad1, numberPoints1) * 180 / pi;
verticalPlungeVec1 = ones (size(verticalTrendVec1));
verticalPlungeVec1 = verticalPlungeVec1 * (90 - coneSemiAngleGrad);
verticalConeMat1 = [transpose(verticalTrendVec1), transpose(verticalPlungeVec1)];

% Second curve.
initialTrendRad2 = 0;
finalTrendRad2 = (initialTrendRad1 + 2 * pi) - finalTrendRad1;

interval2 = finalTrendRad2 - initialTrendRad2;
numberPoints2 = floor(interval2 / (2 *pi) * resolution) + 2;

verticalTrendVec2 = linspace(initialTrendRad2, finalTrendRad2, numberPoints2);
verticalTrendVec2 = (verticalTrendVec2 + finalTrendRad1) * 180 / pi;
verticalTrendVec2 = reduceminimal360angle (verticalTrendVec2);

verticalPlungeVec2 = ones(size (verticalTrendVec2));
verticalPlungeVec2 = verticalPlungeVec2 * (90 - coneSemiAngleGrad);
verticalConeMat2 = [transpose(verticalTrendVec2), transpose(verticalPlungeVec2)];

% TRANSFORMING THE VERTICAL CONE TO INCLINED POSITION.
angle01 = -(90 - trendPlungeVec(2));

% First curve.
inclinedConeMat1 = zeros(size (verticalConeMat1));
a = size (verticalConeMat1, 1);
for i = 1 : a
    inclinedConeMat1(i, :) = rot_orient_arnd_northernstrike ...
        (verticalConeMat1(i, :), angle01);
endfor

% Second curve.
inclinedConeMat2= zeros( size(verticalConeMat2) );
b =size(verticalConeMat2 ,1);
for i=1 :b
    inclinedConeMat2(i,:) =rot_orient_arnd_northernstrike...
        ( verticalConeMat2(i,:) ,angle01 );
end

% Resolving extreme points conflicts.
pointOneVec1 = fourthPointIntVec;
pointTwoVec1 = thirdPointIntVec;
pointOneVec2 = firstPointIntVec;
pointTwoVec2 = secondPointIntVec;

% First curve.
inclinedConeMat1(1, :) = pointTwoVec1;
inclinedConeMat1(end, :) = pointOneVec1;
% Second curve.
inclinedConeMat2(1, :) = pointTwoVec2;
inclinedConeMat2(end, :) = pointOneVec2;

% CREATING THE COMPLEMENTARY PART OF EACH.
% First curve.
inclinedComplementTrend1 = linspace (inclinedConeMat1(end, 1), ...
    inclinedConeMat1(1, 1), numberPoints1);
inclinedComplementPlunge1 = zeros(size (inclinedComplementTrend1));
inclinedComplementMat1 = [transpose(inclinedComplementTrend1), ...
    transpose(inclinedComplementPlunge1)];
% Second curve.
inclinedComplementTrend2 = linspace(inclinedConeMat2(1, 1), ...
    inclinedConeMat2(end, 1), numberPoints2);
inclinedComplementPlunge2 = zeros (size (inclinedComplementTrend2));
inclinedComplementMat2 = [transpose(inclinedComplementTrend2), ...
    transpose(inclinedComplementPlunge2)];

% JOINING PARTS.
inclinedConeMat1 = flipud (inclinedConeMat1);
inclinedComplementMat1 = flipud (inclinedComplementMat1);
closedCurveMat1 = [inclinedConeMat1(1: end-1, :); inclinedComplementMat1(1: end, :)];

inclinedComplementMat2 = flipud (inclinedComplementMat2);
closedCurveMat2 = [inclinedComplementMat2(1: end-1, :); inclinedConeMat2(1: end, :)];

% ROTATING ALL CURVES BY THE TREND.
angle02 = -90 + trendPlungeVec(1);

% First closed curve.
for i = 1 : size (closedCurveMat1, 1)
    closedCurveMat1(i, :) = rot_orient_arnd_verticalaxs (closedCurveMat1(i, :), angle02);
endfor

%Second closed curve
for i = 1 : size(closedCurveMat2, 1)
    closedCurveMat2(i, :) = rot_orient_arnd_verticalaxs (closedCurveMat2(i, :), angle02);
endfor

% CREATING THE POLAR MATRIX.
% First curve.
matrixSize1 = size (closedCurveMat1);
polarMatrix1 = zeros(matrixSize1(1), 2);
switch lower(projectionType)
    case {'N', 'equalaNgle', 'equalangle'}
        for i = 1 : matrixSize1(1)
           % Calculate NE polar coordinates from equalangle projection.
           %[polarMatrix1(i,1), polarMatrix1(i,2)] = ...
           polMat1 = ...
           equalanglepolar2planepolar ([closedCurveMat1(i, 1), closedCurveMat1(i,2)]);
           polarMatrix1(i,1) = polMat1(1);
           polarMatrix1(i,2) = polMat1(2);
        endfor
    case {'R', 'equalaRea', 'equalarea'} 
        for i = 1 : matrixSize1(1)
           % Calculate NE polar coordinates from equalarea projection.
           %[polarMatrix1(i, 1), polarMatrix1(i,2)] = ...
           polMat1 = ...
           equalareapolar2planepolar ([closedCurveMat1(i, 1), closedCurveMat1(i, 2)]);
           polarMatrix1(i,1) = polMat1(1);
           polarMatrix1(i,2) = polMat1(2);
        endfor
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
endswitch

% Second curve.
matrixSize2 = size (closedCurveMat2);
polarMatrix2 = zeros (matrixSize2(1), 2);
switch projectionType 
    case {'N', 'equalaNgle', 'equalangle'}
        for i = 1 : matrixSize2(1)
           % Calculate NE polar coordinates from equalangle projection.
           %[polarMatrix2(i, 1), polarMatrix2(i, 2)] = ...
           polMat2 = ...
           equalanglepolar2planepolar ([closedCurveMat2(i, 1), closedCurveMat2(i,2)]);
           polarMatrix2(i, 1) = polMat2(1);
           polarMatrix2(i, 2) = polMat2(2);
        endfor
    case {'R', 'equalaRea', 'equalarea'} 
        for i = 1 : matrixSize2(1)
           % Calculate NE polar coordinates from equalarea projection.
           %[polarMatrix2(i, 1), polarMatrix2(i,2)] = ...
           polMat2 = ...
           equalareapolar2planepolar ([closedCurveMat2(i, 1), closedCurveMat2(i,2)]);
           polarMatrix2(i, 1) = polMat2(1);
           polarMatrix2(i, 2) = polMat2(2);
        endfor
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
endswitch

## PLOTING.
if want2see == true;
    hold on;
    plotplaneorientationdata (closedCurveMat1, projectionType, '-', false, 3, 'b', 'b' );
    plotplaneorientationdata (closedCurveMat2, projectionType, '-', false, 3, 'b', 'b' );
    plotplaneorientationdata (trendPlungeVec, projectionType, 'x', true, 7, 'b', 'b');
endif

endfunction