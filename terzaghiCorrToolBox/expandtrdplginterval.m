## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## -*- texinfo -*- 
## @deftypefn {} {@var{expandedIntValArray} =} expandtrdplginterval (@var{intValArray}, @var{intValSense})

## Example 1:
## Given an interval (of two parts) in that begins in the East with 70 in plunge
## and ends in the West with 10 in plunge, i.e. intVal = [90, 70; 270, 10].
## Expand the interval [90, 70; 270, 10] with this function.
## intValCalArray = expandtrdplginterval ([90, 57; 270, 8], 'counterclockwise');
## It gives: [270, 8; 270, 0; 90, 0; 90, 57];
    
## Examples 2:
## For ...
##intValSense = 'clockwise';
## intValSense = 'counterclockwise';
## intValArray = [270, 10; 090, 70];
## intValArray = [270, 60; 090, 20];
## intValArray = [090, 20; 270, 70];
## intValArray = [090, 70; 270, 10];
## intValArray = [270, 60; 270, 10];
## intValArray = [270, 10; 270, 60];
## intValArray = [090, 60; 090, 20];
## intValArray = [090, 30; 090, 70];
## intValArray = [090, 90; 090, 90];
## intValArray = [270, 90; 270, 90];
## intValArray = [270, 60; 270, 60];
## display (intValArray);

## Example 3:
## Both intervals are equivalent when the sense is  established properly.
## a1 = expandtrdplginterval ([90, 70; 270, 10],  'counterclockwise');
## a2 = expandtrdplginterval ([270, 10; 90, 70],  'clockwise');

## @seealso{interval2meanaxisconeangle}, rotate180inwedireonly}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-22

function [expandedIntValArray] = expandtrdplginterval (intValArray, ...
    intValSense, wantplot)
% clear; clc;

## Input management.
if nargin < 2
    intvalSense = 'clockwise';
    wantplot = false;
elseif nargin < 3
    wantplot = false;
endif

# Size of the 'intValArray' should be 2 x 2
if ~all(size(intValArray) == [2,2])
    error('Interval should be of size 2 x 2!');
endif
# Trend angles should be opossite.
trdsCol = unique(intValArray(:,1));
if length (trdsCol) == 2
    if mod (trdsCol(1) + 360, 180) ~= mod (trdsCol(2) + 360, 180)
    error('Only to different trends are permited with a difference of 180 °!');
    endif
endif

## Given the (trd, plg) of the inferior and superior interval (in a vertical plane)
## Find the mean direction (trdGral, plgGRal) and the interval angle (coneAngleDeg).

[trdGral, plgGral, coneAngleDeg] = interval2meanaxisconeangle ...
    (intValArray, intValSense);
%display (trdGral);
%display (plgGral);
%display (coneAngleDeg);

if coneAngleDeg == 0
    expandedIntValArray = [trdGral, plgGral; nan(1,2)];
    break
endif
            
## Adding the cone angle to the cone axis.
plgLimSup = plgGral + coneAngleDeg;
plgLimInf = plgGral - coneAngleDeg;

# Inferior limits.
[trdLimInf, plgLimInf] = rotate180inwedireonly (trdGral, plgLimInf);
if trdGral ~= trdLimInf
    infLimsarray = [trdLimInf, plgLimInf; trdLimInf, 0; trdGral, 0];
else
    infLimsarray = [trdLimInf, plgLimInf];
endif

# Superior limits.
[trdLimSup, plgLimSup] = rotate180inwedireonly (trdGral, plgLimSup);
if trdGral ~= trdLimSup
    supLimsarray = [trdGral, 90; trdLimSup, 90; trdLimSup, plgLimSup];
else
    supLimsarray = [trdLimSup, plgLimSup];                
endif

## Arranging the expanded intervals array.
expandedIntValArray = [infLimsarray; supLimsarray];

## Plotting
if wantplot
    hold on
    for k = 1 : 2 : size (expandedIntValArray, 1)
        plotintvalvertseccusphere (expandedIntValArray(k : k + 1, :));
    endfor
    plotframevertseccusphere (0);
endif

endfunction
%display (expandedIntValArray);