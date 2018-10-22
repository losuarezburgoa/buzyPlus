function [averageValuesGrid, notes_string] = visualizemovingaverages ...
    (coneAxisTrendPlungeArray, clusteredValues, circAreaPercent, ...
    projectionType, want2plot, symbolSize, symbolEdgeColor)
##
## Description:
% Plot the number of data encountered in each moving cluster in a raster
% approximate graphic. In each position a number letter is put indicating
% the data encountered.
%
% Nested function(s):
% equalareapolar2planepolar, equalanglepolar2planepolar, nepol2cart
%
% Related function(s):
% calculatemovingaverages
%
% Input(s):
% Matrix having the trend-plunge values of the orientation of the cone-axis
% used to evaluate the moving average values (coneAxisTrendPlungeArray)
%
% Vector having the quantities of points encountered in each circualar
% window whose axis are reffered in the 'coneAxisTrendPlungeArray' (clusteredValues).
%
% Recalculated area value of the cluster window in percentaje of the total
% projected area (circAreaPercent)
%
% Type of projection: 'equalarea' or 'equalangle' (projectionType)
%
% Logical value if it is desired to plot (want2plot)
%
% Output(s):
% Matix nx3 containing the x-coordinate, y-coordnate ans the numer of data
% for each evaluated point, used for plotting (averageValuesGrid)
%
% String where special notes about the grphic and data are given
% (notes_string)

## Input management.
if nargin < 4
    projectionType = 'equalarea';
    want2plot = true;
    symbolSize = 4;
    symbolEdgeColor = 'b';
elseif nargin < 5
    want2plot = true;
    symbolSize = 4;
    symbolEdgeColor = 'b';
elseif nargin < 6
    symbolSize = 4;
    symbolEdgeColor = 'b';
elseif nargin < 7
    symbolEdgeColor = 'b';
endif

## Selecting the projetion type.
numberValues = length(clusteredValues);
nePolarMatRad = zeros(length(clusteredValues), 2);
switch projectionType
    case 'equalarea'
        for i = 1 : numberValues
            %[nePolarMatRad(i,1), nePolarMatRad(i,2)] = ...
            nePolMat = ...
            equalareapolar2planepolar (coneAxisTrendPlungeArray(i,:));
            nePolarMatRad(i,1) = nePolMat(1);
            nePolarMatRad(i,2) = nePolMat(2);
        endfor
    case 'equalangle'
        for i = 1 : numberValues
            %[nePolarMatRad(i,1), nePolarMatRad(i,2)] = ...
            nePolMat = ...
            equalanglepolar2planepolar(coneAxisTrendPlungeArray(i,:));
            nePolarMatRad(i,1) = nePolMat(1);
            nePolarMatRad(i,2) = nePolMat(2);
        endfor
    otherwise
        error('Projetion type option bad written!');
endswitch

valuesXYmat = zeros(length(clusteredValues), 2);
for i = 1 : numberValues
            [valuesXYmat(i, 1), valuesXYmat(i,2)] = nepol2cart ...
            (nePolarMatRad(i,1), nePolarMatRad(i,2));
endfor
averageValuesGrid = [valuesXYmat, clusteredValues];

## Creating the string at the bottom.
string1 = sprintf('Projection Type: %s. ', projectionType);
string2 = sprintf('Counting area: %.2f %%. ', circAreaPercent);
notes_string = strcat(string1, '; ', string2);

## PLOTTING.
if want2plot == true
    clusterValsText = num2str(clusteredValues);
    m = size(clusterValsText ,2);
    
    hold on
    sphereRadius = 1;
    axis(sphereRadius *[-1 ,1 ,-1 ,1], 'equal', 'off');
    plot(averageValuesGrid(:,1), averageValuesGrid(:,2), 'linestyle', 'none', ...
    'marker' ,'x', 'markersize', symbolSize, 'markeredgecolor', symbolEdgeColor);
    letterSpace = 0.04;
    lineSpace = 0.1;
    lettersPositionMat = averageValuesGrid(:, 1:2);
    for j = 1 : m
        lettersPositionMat(:,1) = lettersPositionMat(:,1) + letterSpace*(j -m /2);
        text(lettersPositionMat(:,1), lettersPositionMat(:,2), ...
            clusterValsText(:,j), 'FontSize', 10, 'horizontalalignment', 'center');
    endfor
    text(-1 , (-1 - lineSpace), notes_string);
endif

endfunction

