## When the plunge is out of the bounds [0, 90] one have to rotate in the
## trend 180 ° and recalculate the plunge in order to have them inside the
## interval.
## This function rotates 180 in the vcase the trend is out of the limits [0, 90].

## Example 1:
## [ctrd, cplg] = rotate180inwedireonly (90, 55);
## display(sprintf('Initial trend: (%.1f / %.1f) [°].', trd, plg));
## display(sprintf('Corrected trend: (%.1f / %.1f) [°].', ctrd, cplg));

## Example 2:
## rotate180inwedireonly (90, 30, 1);
## rotate180inwedireonly (90, 160, 1);
## rotate180inwedireonly (90, 200, 1);
## rotate180inwedireonly (90, 290, 1);
## rotate180inwedireonly (90, -30, 1);
## rotate180inwedireonly (90, -160, 1);
## rotate180inwedireonly (90, -200, 1);
## rotate180inwedireonly (90, -290, 1);
## rotate180inwedireonly (270, 30, 1);
## rotate180inwedireonly (270, 160, 1);
## rotate180inwedireonly (270, 200, 1);
## rotate180inwedireonly (270, 300, 1);
## rotate180inwedireonly (270, -30, 1);
## rotate180inwedireonly (270, -160, 1);
## rotate180inwedireonly (270, -200, 1);
## rotate180inwedireonly (270, -290, 1);

## Example 3:
## plgArray = -110 : 10 : 100;
## nData = length(plgArray);
## trdArray = 90 * ones(1, nData);
## nplgArray = zeros(1, nData);
## ntrdArray = zeros(1, nData);
## a = [1:nData]'; b = num2str(a);
## labelStr = cellstr(b);
## figure()
## hold on
## for k = 1 : 1 : nData
##     [ntrdArray(k), nplgArray(k)] = rotate180inwedireonly (trdArray(k), plgArray(k), ...
##        1, labelStr(k), rand(1,3));
## endfor
## hold off

## Example 4:
## plgArray = rand(1, 12) * 2*360 - 360;
##
## nData = length(plgArray);
## trdArray = 270 * ones(1, nData);
## nplgArray = zeros(1, nData);
## ntrdArray = zeros(1, nData);
## a = [1:nData]'; b = num2str(a);
## labelStr = cellstr(b);
## figure()
## hold on
## for k = 1 : 1 : nData
##    [ntrdArray(k), nplgArray(k)] = rotate180inwedireonly (trdArray(k), plgArray(k), ...
##        1, labelStr{k}, rand(1,3));
## endfor
## hold off

function [ctrd, cplg] = rotate180inwedireonly (trd, plg, wantplot, ...
    idStr, colVecStr, plotpatch)
## Input management.
if nargin <  3
    wantplot = false;
    idStr = '1';
    colVecStr = 'y';
    plotpatch = false;
elseif nargin <  4
    idStr = '1';
    colVecStr = 'y';
    plotpatch = false;
elseif nargin < 5
    colVecStr = 'y';
    plotpatch = false;
elseif nargin < 6
    plotpatch = false;
endif
    
if and(trd ~= 90, trd ~= 270)
    error('The trend should be only 90 or 270, because is only in W or E!');
endif

## Doing the transformation.
[ctrd, cplg] = dothetransform (trd, plg);

## Ploting in the unit circle in a vertical view.
if wantplot
    hold on
    # The initial point.
    plotpointvertseccusphere ([trd, plg]);

    # The transformed point.
    plotpointvertseccusphere ([ctrd, cplg]);
    
    # The connecting line.
    [x, y] = trendplunge2xyvertsecc ([trd, plg]);
    [cx, cy] = trendplunge2xyvertsecc ([ctrd, cplg]);
    plot([x, cx], [y, cy], 'k--');
    # The unit circle, the horizontal line, axis off and equal.
    plotframevertseccusphere (1);
endif

endfunction

## Function that performs the transformation.
function [ctrd, cplg] = dothetransform (trd, plg)

switch (true)
    case (plg >= 360)
        plg = mod (plg, 360);
        [ctrd, cplg] = dothetransform (trd, plg);
    case (and (plg >= 270, plg < 360))
        cplg = 360 - plg;
        ctrd = trd + 180;
    case (and (plg >= 180, plg < 270))
        cplg = plg - 180;
        ctrd = trd + 360;
    case (and (plg >= 90, plg < 180))
        cplg = (180 - plg);
        ctrd = trd + 180;
    case (and (plg >= 0, plg < 90))
        cplg = plg;
        ctrd = trd;
    case plg < 0
        mplg = mod (plg, -360);
        plg = abs(mplg);
        [ctrd, cplg] = dothetransform (trd, 180 - plg);
endswitch
ctrd = mod (ctrd, 360);

endfunction