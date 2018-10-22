## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} calculatemovingaverages (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-23

function [clusteredValues, circAreaPercent] = calculatemovingaverages ...
    (trendPlungeArray, coneAxisTrendPlungeArray, circAreaPercent, wantplot, projType)

    ## Input management.
if nargin < 3
    wantplot = false;
    projType = 'equalarea';
elseif nargin < 4
    projType = 'equalarea';
endif

warning ('Replaces obsolte deprecate functions: calculatemovingaverages01, ...02, ...03 and ...04!');

## Calculating the number of values inside the moving window.
# It s a 'brute force' algorithm that should be improved.
clusteredValues = zeros(size(coneAxisTrendPlungeArray, 1), 1);

for i = 1 : size(coneAxisTrendPlungeArray, 1)
    # CASE 1
    %coneSTR = struct('axisTPvec', coneAxisTrendPlungeArray(i,:), ...
    %    'semiAngDeg', circAreaPercent);
    %clustMat = clusterwithcircularwindow (coneSTR, trendPlungeArray);
    # CASE 2
    clustMat = clusterwithcircularwindowmanually ...
        (coneAxisTrendPlungeMat(i,:), circAreaPercent , 0, trendPlungeMat, false);
    
    clusteredValues(i) =size(clustMat, 1);
endfor

endfunction
