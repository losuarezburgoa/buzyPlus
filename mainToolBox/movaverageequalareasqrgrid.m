function [conAxsTrdPlgArray, clusteredVals, totNumData, evCntAreaPercnt] = ...
    movaverageequalareasqrgrid (trdPlgArray, cntAreaPercnt)

## Description:
## Calculates the moving averages of equal-size circular windows that moves
## on a square grid of equal area (in the equal area projected plane).
## The angle of the cone axis varies in steps accordingly to the trend and
## plunge angles found by back-calculating the coordinates of the grid from
## the projected angle to the reference sphere. 
## This time the points of the grid that are outside, but near the major
## great circle, is transferred to the boundary of the major great circle in
## the same diameter.
## 
## Input(s):
## Matrix containing the orientation data from which the movng averages is
## want to find (trdPlgArray)
## 
## Area of the counting circle expressed in percentaje of the total projeted
## area (cntAreaPercnt)
## 
## Output(s):
## Matrix having the trend-plunge values of the orientation of the cone-axis
## used to evaluate the moving average values (conAxsTrdPlgArray)
## 
## Vector having the quantities of points encountered in each circualar
## window whose axis are reffered in the 'conAxsTrdPlgArray' (clusteredVals).
## 
## Recalculated area value of the cluster window in percentaje of the total
## projected area (evCntAreaPercnt)
## 
## Example 1.
## Given the following trdPlgArray, obtain the number of data clustered in
## each moving cluster that have an area of 2##  the maximum great circle area.
## trdPlgArray = [353, 11; 166, 85; 11, 77; 116, 66; 139, 72; 329, 31; 4, 49; ...
##     9, 85; 113, 67; 263, 10; 315, 33; 263, 10; 152, 72; 158, 84; 126, 48];
##
## Example 2.
## See example script 08.

## Maximum great circle radius, i.e. radius of the reference sphere
greatCircleRadius = 1;
## Area of the maximum great-circle (globalGcArea)
globalGcArea = pi * greatCircleRadius^2;

## Area and radius of the equal-area counting circle (countingEaCircleArea,
## countinigEaCircleRadius)
countingEaCircleArea = cntAreaPercnt / 100 * globalGcArea;
countingEaCircleRadius = sqrt(countingEaCircleArea / pi);

## Obtaining the 'pixelAreaInPercent' to use the
## 'create_pixelgrid_any_homogeneus_value' function to generate the grid
iniPxsSide = 2 * countingEaCircleRadius;
iniPxsArea = iniPxsSide^2;
iniPxsAreaPecnt = iniPxsArea / globalGcArea * 100;

## Creating the pixleGrid matrix
[pixelsGrid, pixelSide] = create_pixelgrid_any_homogeneus_value ...
    (true, iniPxsAreaPecnt);
evaluatedEaCircleRadius = pixelSide / 2;
## Re-evaluating the counting circle area and the percentage value
## (evCntAreaPercnt) 
evaluatedCountingEaCircleArea = pi * evaluatedEaCircleRadius.^2;
evCntAreaPercnt = evaluatedCountingEaCircleArea / globalGcArea * 100;

## Obtaining the cone semiangle for the equal-area counting circle
## (countingConeSemiangleGrad) 
tpv = planepolar2equalareapolar (0, evaluatedEaCircleRadius);
resultOfBetaGrad = tpv(2);
evtedCountingConeSemiangDeg = 90 - resultOfBetaGrad;

## CREATING THE XY MATRIX
## Obtaining the cuadrandt information
a = size(pixelsGrid, 1) / 2;
upperLeftQuadrant = pixelsGrid(1 : a, 1 : a);

## Creating one quadrant matrix
[X, Y] = find(upperLeftQuadrant ==1);
xyQuadrantPointsMat = [X(:)-1 ,Y(:)-1] * pixelSide;
xyQuadrantPointsMat(: ,1) = 1 - xyQuadrantPointsMat(:,1);
xyQuadrantPointsMat(: ,2) = 1 - xyQuadrantPointsMat(:,2);

## Creating axis matrices
xyVerticalAxisMat = [zeros(a,1), transpose(linspace(1, a, a) * pixelSide)];
xyHorizontalAxisMat = fliplr(xyVerticalAxisMat);

## Creating the four quadrant matices
xyPtsUpLeft = [xyQuadrantPointsMat(:,1) * -1, xyQuadrantPointsMat(:,2)];
xyPtsUpRigth = xyQuadrantPointsMat;
xyPtsDownLeft = xyQuadrantPointsMat * -1;
xyPtsDownRigth = xyPtsUpLeft * -1;

## Creating the xy matrix
xyAxisMat = [xyPtsUpLeft; xyVerticalAxisMat; [0,0]; xyPtsUpRigth; ...
    -xyHorizontalAxisMat; xyHorizontalAxisMat; xyPtsDownLeft; ...
    -xyVerticalAxisMat; xyPtsDownRigth];

## CREATING THE CIRCUNSCRIBED POLAR MATRIX
[theta, rho] = cart2nepolnuevo (xyAxisMat(:,1), xyAxisMat(:,2));
polPointsMat = [theta, rho];
numberPoints = size(polPointsMat ,1);
for k = 1 : numberPoints
    if polPointsMat(k, 2) > 2 / sqrt(2)
        polPointsMat(k, 2) = 2 / sqrt(2);
    endif
endfor
polPointsMat = sortorientations (polPointsMat);

## TRANSFERING THE GRID POINTS THAT ARE OUTSIDE BUT NEAR THE MAJOR GREAT
## CIRCLE TO THE BOUNDARY OF THE MAJOR GREAT CIRCLE
numberPoints = size(polPointsMat, 1);
for k = 1 : numberPoints
    if polPointsMat(k, 2) > 1
        polPointsMat(k, 2) = 1;
    endif
endfor

## CREATING THE CIRCUMSCRIBED POLAR MATRIX
circumsPolPtsArray = sortorientations (polPointsMat);

## CREATING THE TREND-PLUNGE MATRIX
## Back calculation of trend-plunge from polar matrix
conAxsTrdPlgArray = planepolar2equalareatrendplunge_array (circumsPolPtsArray);
conAxsTrdPlgArray = sortorientations (conAxsTrdPlgArray);

## OBTAINING THE CLUSTER VECTORS
## Filling the 'clusteredVals' vector 
clusteredVals = zeros (size(conAxsTrdPlgArray, 1), 1);
for k = 1 : size(conAxsTrdPlgArray ,1)
    clustMat = clusterwithcircularwindowmanually (conAxsTrdPlgArray(k, :), ...
        evtedCountingConeSemiangDeg, 0, trdPlgArray, 0);
    clusteredVals(k) = size(clustMat, 1);
endfor

## Calculating the total number of data for further calculatios of the
## relative values cluster vector
totNumData = length(trdPlgArray);

endfunction

