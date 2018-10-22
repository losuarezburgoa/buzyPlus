## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{intValCalArray} =} intvalhorzprojvertseccusphere (@var{expandedIntValArray})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-18

## Interval of a West to East vertical plane projected to an horizontal plane.

## Convert an interval expresend in angles in the vertical West-East plane
## to an interval useful for calculation in an horizontal plane, where the 
## West extreme is -90, center is 0 and the East extreme is +90.

## Example 1:
## Given an interval (of two parts) in that begins in the East with 70 in plunge
## and ends in the West with 10 in plunge, i.e. intVal = [90, 70; 270, 10].
## Find the interval in the scale (-90, 90).
## First we have to extend the interval [90, 70; 270, 10] with the function
## 'expandtrdplginterval'; i.e. 
## expdedIvalArray = expandtrdplginterval ([90, 70; 270, 10], 'counterclockwise');
## expdedIvalArray = expandtrdplginterval ([270, 10; 90, 70], 'clockwise');
## intValCalArray = intvalhorzplanewevertplane (expdedIvalArray);
## It gives:
## intValCalArray = [70, 90; -90, -80];

## Example 2:
## intvalhorzplanewevertplane ([90, 70; 90, 90; 270, 90; 270, 70]);
## It gives: 
## intValCalArray = [20, 0; 0, -20];

function [intValCalArray] = intvalhorzplanewevertplane (expandedIntValArray, ...
      wantplot)

## Input management.
if nargin < 2
  wantplot = false;
endif
  
## Using for each simple interval the function 'dotthefunction'-
intValCalArray = nan(size(expandedIntValArray, 1) / 2, 2);
for k = 1 : 2 : size (expandedIntValArray, 1)
    intValCal2Rows = dothefunction (expandedIntValArray(k : k+1, :));
    intValCalArray((k + 1) / 2, :) = intValCal2Rows;
endfor

## Plotting
if wantplot
    hold on
    for k = 1 : 2 : size (expandedIntValArray, 1)
        plotintvalvertseccusphere (expandedIntValArray(k : k + 1, :));
    endfor
    for k = 1 : size(intValCalArray,1)
        plot(intValCalArray(k,:)/90, zeros(1,2), 'c-', 'LineWidth', 2);
        plot(intValCalArray(k,:)/90, zeros(1,2), 'ko', 'MarkerFaceColor', 'r');
    endfor
    plotframevertseccusphere (0);
endif
endfunction

## Her we do the linear transformation of pluge angle (expressed as angle)
## to a number with the same magnitude; but when it trends to the East it is
## positive and when it trends to the West it is negative.
function [intValCal] = dothefunction (intVal)

if and (intVal(1,1) == 90, intVal(2,1) == 90)
    intValCal = 90 - [intVal(1,2), intVal(2,2)];
elseif and (intVal(1,1) == 270, intVal(2,1) == 270)
    intValCal = [intVal(1,2), intVal(2,2)] - 90;
else
    error('The trends of the intervals should be 90 or 270!');
endif

endfunction
