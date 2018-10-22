## Copyright (C) 2018 Ludger O. Suarez-Burgoa


## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} interpolatisogonicplot (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-19

## Interpolate at isogonic plot.
## intValCal = [-80, -90; 0, 90; 0  -10];
## plgAlphaArray = createalphavetplanefun (45);
## wantplot = true;

function [yItvalMean, interPlgAlphaCell] = interpolatisogonicplot (intValCal, ...
    plgAlphaArray, wantplot)

if nargin < 3
    wantplot = false;
endif

x = plgAlphaArray(:, 1);
y = plgAlphaArray(:, 2);

idxs = ~any(isnan(intValCal), 2);
intValCal = intValCal(idxs, :);

numSubints = size (intValCal, 1);
ySum = zeros (1, numSubints);
nSum = 0;
interPlgAlphaCell = cell (1, numSubints);

itvalDeg = 0.2;
for k = 1 : numSubints
    if intValCal(k, 1) > intValCal(k, 2)
        itvalDeg = -itvalDeg;
    endif
    itvalCalArray = intValCal(k, 1) : itvalDeg : intValCal(k, 2);
    yValArray = interp1 (x, y, itvalCalArray);
    
    itvalCalArray = itvalCalArray(~isnan (yValArray));
    yValArray = yValArray(~isnan (yValArray));
    
    interPlgAlphaCell{k} = [itvalCalArray', yValArray'];
    
    nSum = nSum + numel (yValArray);
    ySum(k) = sum (yValArray);
    
    itvalDeg = abs(itvalDeg);
endfor
yItvalMean = sum (ySum) / nSum;

if wantplot
    hold on
    # The text offset.
    xt = 0.02;
    yt = 0.02;
    # The intervals.
    numSubints = length (interPlgAlphaCell);
    lblArray = zeros (numSubints*2, 2);
    for k = 1 : 1 : numSubints
        plot (interPlgAlphaCell{k}(:,1), interPlgAlphaCell{k}(:,2), 'r--', ...
            'LineWidth', 3);
        %legend ('Interval.');
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
endif

endfunction
