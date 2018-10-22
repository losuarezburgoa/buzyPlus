## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} movaverageequalareawingrid (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-25

function [conAxsTrdPlgArray, clusteredVals, numData, evCntAreaPercnt, ...
    areaFactors] = movaverageequalareawingrid (trdPlgArray, cntAreaPercnt)


## Recognizing the data
[numData, numCols] = size (extdedDataArray);
if numCols == 2
    # Will analize only poles inside window, no frequencies, no terzahi correction.
    trdPlgArray = extdedDataArray;
    freqArray = ones(numData, 1);
    terzArray = ones(numData, 1);
else
    error ('Data array should have 2 columns!');
endif

## Creating the counting net.
[evCntAreaPercnt, areaFactorVec, ~, vtxTrdPlg3Darray, centerPtTrdPlgArray, ...
    areaFactorVecById] = createcountingequalareanet (cntAreaPercnt);
numWins = length (areaFactorVecById);

## The cell that will store the information.

conAxsTrdPlgArray = zeros(numWins, 2);
clusteredVals = zeros(numWins, 1);
areaFactors = zeros(numWins, 1);

for k = 1 : numWins
    [centerOfCountVec, numPoles, areaFactor] = movaverageforonewindow ...
        (trdPlgArray, k, vtxTrdPlg3Darray, centerPtTrdPlgArray, areaFactorVecById);
    conAxsTrdPlgArray(k, :) = transpose(centerOfCountVec);
    clusteredVals(k, 1) = numPoles;
    areaFactors(k, 1) = areaFactor;
endfor

endfunction

## The selection for each window is done for every data.

function [centerOfCountArray, numPoles, areaFactor] = movaverageforonewindow ...
    (trdPlgArr, netClusterId, vtxTrdPlg3Darray, centerPtTrdPlgArray, areaFactorVecById)

winCountArray = vtxTrdPlg3Darray(:, :, netClusterId);
centerOfCountArray = centerPtTrdPlgArray(:, netClusterId);

if winCountArray(1,1) == winCountArray(1,2)
    lowRgthTrdPlgeVec = [000, 90];
    winArc = 360;
else
    lowRgthTrdPlgeVec = [winCountArray(1,2), winCountArray(2,2)];
    winArc = mod(winCountArray(1,1) - winCountArray(1,2), 360);
endif

areaFactor = areaFactorVecById(netClusterId);
if and(winCountArray(2,1) == 0, areaFactor == 0.5)
    othExtrPlg = -winCountArray(2,2);
else
    othExtrPlg = winCountArray(2,1);
endif

[clMat, clusterIdVec] = clusterwithwindow (lowRgthTrdPlgeVec, winArc, ...
    othExtrPlg, trdPlgArr);
numPoles = length (clMat);

endfunction