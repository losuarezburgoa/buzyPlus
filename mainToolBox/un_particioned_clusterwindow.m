function [rotatedConeMat, polarMatrix] = un_particioned_clusterwindow...
    (coneAxisTrendPlungeVec, coneSemiAngleGrad, projectionType, want2see)
#
# Description:
# Creates the trend and plunge data of poits that are part of a circular
# cluster cone.
# 
# Input(s)
# Row array of the trend and plunge data of the cone axis (trendPlungeVec).
#
# Semi-angle of the the cone in hexagesimal grades (coneSemiAngleGrad).
#
# Output(s):
# Matrix of trend and plunge values that defines the circular cluster
# 
# Example1:
# [rotatedConeMat, polarMatrix] = un_particioned_clusterwindow([45 ,60], 20, ...
#    'equalangle', true);

## Input management.
if nargin < 3
   projectionType = 'equalangle';
   want2see = false;
elseif nargin < 4
   want2see = false;
endif

## Evaluating the possibility to be a unpartitioned cluster.
a = coneAxisTrendPlungeVec(2) - coneSemiAngleGrad;
if a < 0
    error('The function ''non_particioned_clusterwindow'' only performs cases where the cluster is not partitioned');
endif

## Creating the cone with a vertical downward axis
# Resolution in number of sides per complete circle
resolution = 72;
# Initial temporal parameters.
numberPoints = resolution + 1;
calculationInterval = 2 * pi / resolution;

a = pi * (0.5 - 1 ./ resolution);
w = floor(a ./ calculationInterval) + 1;
c = a - w * calculationInterval;

% GENERATING THE VERTICAL CONE.
verticalTrendVec = linspace(-c , 2 * pi - c, numberPoints) * 180 / pi;
verticalPlungeVec = ones(size(verticalTrendVec));
verticalPlungeVec = verticalPlungeVec * (90 - coneSemiAngleGrad);
verticalConeMat = [transpose(verticalTrendVec), transpose(verticalPlungeVec)];

% TRANSFORMING THE VERTICAL CONE.
rotatedConeMat = zeros(size(verticalConeMat));
a = size(verticalConeMat, 1);

angle01 = -(90 - coneAxisTrendPlungeVec(2));
angle02 = -90 + coneAxisTrendPlungeVec(1);
for i = 1 : a
    rotatedConeMat(i,:) = rot_orient_arnd_northernstrike ...
        (verticalConeMat(i,:), angle01);
    rotatedConeMat(i,:) = rot_orient_arnd_verticalaxs ...
        (rotatedConeMat(i,:), angle02);
endfor

% CREATING THE POLAR MATRIX.
% Number of data
matrixSize = size(rotatedConeMat);

% Creating the NE polar matrix.
polarMatrix = zeros(matrixSize(1), 2);
% Filling the polar matrix.
switch projectionType 
    case {'N', 'equalaNgle', 'equalangle'}
        for i = 1 : matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           [polarMatrix(i,1) ,polarMatrix(i,2)] = equalanglepolar2planepolar ...
               ([rotatedConeMat(i, 1), rotatedConeMat(i,2)]);
        endfor
    case {'R','equalaRea', 'equalarea'} 
        for i=1:matrixSize(1)
           % Calculate NE polar coordinates from equalarea projection
           [polarMatrix(i,1) ,polarMatrix(i,2)] = equalareapolar2planepolar ...
               ([rotatedConeMat(i, 1), rotatedConeMat(i, 2)]);
        endfor
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
endswitch

## Ploting.
if want2see ==true;
    hold on
    plotplaneorientationdata(rotatedConeMat, projectionType, '-', false, 3, 'b', 'b');
    plotplaneorientationdata(coneAxisTrendPlungeVec, projectionType, 'x', true, 7, 'b', 'b');
endif

endfunction

