function [ ] = plotgreatecircle (dipdirDipArray, projType, graphOptStr, wantplot)

## Description:
## Plot a great circle of a plane. Do not confuse with plotgreatcircnorth.
##
## See also: plotgreatcircnorth.
##
## Example 1:
## projType = 'equalarea';
## graphOptStr = 'bo-';
## dipdirDipVec = [270, 45];
## plotgreatecircle (dipdirDipVec, 'equalangle', 'r:',  1);
##

## Input management.
if nargin < 2
    projType = 'equalarea';
    graphOptStr = 'k-';
    wantplot = true;
elseif nargin < 3
    graphOptStr = 'k-';
    wantplot = true;
elseif nargin < 4
    wantplot = true;
endif

numData = size(dipdirDipArray, 1);
%hCell = cell(1, numData);
for k = 1 : numData
    pltgrtcirc (dipdirDipArray(k,:), projType, graphOptStr, wantplot);
endfor
endfunction

function [ ] = pltgrtcirc (dipdirDipVec, projType, graphOptStr, wantplot)
    
## Number of points to drwa the curve.
## Output variables
## [pitchesTrendPlungeArray, pitchesPolarArray]

pitchNumPoints = 18;

dipdirGrad = dipdirDipVec(1);
dipGrad = dipdirDipVec(2);

## Creating the trend-series and the plunge-series vectors
pitchGrad = linspace(0, 180, pitchNumPoints);
numPoints = length(pitchGrad);

## Transformation data formed by pitch and dipdirDip to trend and plunge.
pitchesPolarArray = zeros(numPoints, 1);
pitchesTrendPlungeArray = zeros(numPoints, 2);
for j = 1 : numPoints
    [pitchesTrendPlungeArray(j ,1), pitchesTrendPlungeArray(j ,2)] = ...
        pitchdipdirdip2trendplunge (pitchGrad(j), [dipdirGrad, dipGrad]);
    switch projType
        case {'equalarea'}
            %[pitchesPolarArray(j,1), pitchesPolarArray(j,2)] = ...
            ptchPolArray = ...
                equalareapolar2planepolar ([pitchesTrendPlungeArray(j, 1), ...
                pitchesTrendPlungeArray(j, 2)]);
            pitchesPolarArray(j, 1) = ptchPolArray(1);
            pitchesPolarArray(j, 2) = ptchPolArray(2);
        case {'equalangle'}
            %[pitchesPolarArray(j,1), pitchesPolarArray(j,2)] = ...
            ptchPolArray = ...
                equalanglepolar2planepolar ([pitchesTrendPlungeArray(j, 1), ...
                pitchesTrendPlungeArray(j, 2)]);
            pitchesPolarArray(j, 1) = ptchPolArray(1);
            pitchesPolarArray(j, 2) = ptchPolArray(2);
        otherwise
            error(['Option', projType, 'is wrong typed!']);
    endswitch
endfor

## Plotting.
if wantplot
    hold on
    plotnortheastpolarpoints (pitchesPolarArray, 2, graphOptStr);
endif

endfunction

