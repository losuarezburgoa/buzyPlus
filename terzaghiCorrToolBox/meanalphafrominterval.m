## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} meanalphaforinterval (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-19

## Calculates the mean alpha value of the Terzagui correction for a determined
## borehole plunge (oriented West to East) in an interval.

## Example 1:
## yItvalMean = meanalphafrominterval (30, [90, 45], 55)

## Example 2:
## bhPlg = 30;
## weTrdPlgOfCenter = [90, 90];
## coneAngle = 20;
## refAngDeg = 0;
## wantplot = true;
## yItvalMean = meanalphafrominterval (30, [90, 90], 20, 0, 1);

function [yItvalMean, x, y, interPlgAlphaCell] = meanalphafrominterval ...
    (bhPlg, weTrdPlgOfCenter, coneAngle, refAngDeg, wantplot)

## Input management.
if nargin < 4
    refAngDeg = 8;
    wantplot = false;
elseif nargin < 5
    wantplot = false;
endif

## Creating the function from the borehole.
plgAlphaArray = createalphavertplanefun (bhPlg, refAngDeg);
## Constructing the intervals from the 'interval cone'.
expandedIntval = weconeinterval (weTrdPlgOfCenter, coneAngle);
intValCal = intvalhorzplanewevertplane (expandedIntval);
## Obtaining the alpha values by interpolating.
[yItvalMean, interPlgAlphaCell] = interpolatisogonicplot ...
    (intValCal, plgAlphaArray);

## Plotting.
x = plgAlphaArray(:, 1);
y = plgAlphaArray(:, 2);

if wantplot
    hold on
    # The curve.
    plot (x, y, 'k-', 'LineWidth', 2);
    # The text offset.
    xt = 0.02; yt = 0.02;
    # The intervals.
    numSubints = length (interPlgAlphaCell);
    lblArray = zeros (numSubints*2, 2);
    for k = 1 : 1 : numSubints
        plot (interPlgAlphaCell{k}(:,1), interPlgAlphaCell{k}(:,2), 'r-', ...
            'LineWidth', 3);
        lblArray((2*k + 1)-2 : (2*k + 1)-1, :) = ...
            [interPlgAlphaCell{k}(1, 1), interPlgAlphaCell{k}(1, 2); ...
             interPlgAlphaCell{k}(end, 1), interPlgAlphaCell{k}(end, 2)];
        plot (lblArray(:,1), lblArray(:,2), 'ko');
    endfor
    # The lables of numbers.
    n = size(lblArray, 1);
    a = [1:n]'; b = num2str(a);
    labelStr = cellstr(b);
    text (lblArray(:,1) + xt, lblArray(:,2) + yt, labelStr, 'Fontsize', 10);
    # The legend.
    lgndStr2 = sprintf ('With blind threshold of %d °.', refAngDeg);
    legend ('Without blind threshold', lgndStr2, 'Intervals.');
    legend ('boxoff');
    # Managing scales and axes.
    xlabel ('\alpha [°].');
    ylabel ('sin{(\alpha)} [1].');
    set (gca, 'xtick', [-90 : 15 : 90]); 
    set (gca, 'ytick', [0 : 0.2 : 1]);
    set (gca,'TickDir','out');
    xlim ([-90 , 90]);
    ylim ([0, 1]);
endif

endfunction
