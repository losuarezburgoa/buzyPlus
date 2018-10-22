## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} weconeinterval (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Description:
##
## West to East cone interval 'w-e-cone-interval'
## This is a plane calculus, in the vertical plane (Pv) whose strike is oriented
## from West to East.
## But the reasoning is in the lower hemisfere unit sphere. Suppose I have a cone
## whose vertex coincides the center of the unit sphere, and the cone expands
## downwards with a generatrix-to-axis angle of 'coneAngleDeg'.
## Also, the cone-axis can have any inclination downwards from the horizontal
## plane, i.e. a plunge angle; but the trend (horizontal angle from north to
## the vertical projection of the axis) can only be at the West or at the East
## in the plane Pv.
##
## As the cone intersects the lower hemisphere of the unit sphere it forms a
## circle and also the cone intersects the vertical plane. 
## If the cone axis is close to the downwards vertical line and the 'coneAngleDeg'
## is not to big, then the intersection with the vertical plane will fall
## as two points in the West or East line, or one point in the West branch
## and the other in the East one.
## If the cone axis is close to an horizontal line and the 'coneAngleDeg' is big,
## then one of the points will pass to the other branch.
##
## This function calculates the points that indicantes the initial and final
## points of intersection of the cone with the vertical plane and the surface of
## the unit sphere.

## Input(s):
## A 1 x 2 array indicating the trend and plunge (in hexagesinal angle degrees)
## of the cone-axis orientation (coneAxisWeTrdPlg).
##
## A single number indicating the angle between the cone axis and the cone 
## generatrix (coneAngleDegDeg).

## Output(s):
## A 2 x 2 array with the data of the intervals 'expandedIntvalArray'. Each pair of data
## is stored in one row. In some cases the array will have one row with numbers 
## and the other as row with NaN (not a numbers), this will depend on them 
## situation when the interval is divided by two intervals when the cone-axis 
## is near the horizontal plane.
## For example, an array [33, 90; -90, -88] indicates the plunge angle interval
## starts with 33 and ends 90 ° in the East and continues in the West with -90
## and -88.
## An array [45, 66; NaN, NaN] indicates that the interval starts at 45 and
## finishes at 66 in the East.
## An array [-70, -13; NaN, NaN] indicates that the interval start at -70 and
## ends at -13 Westwards.
##

## Example 1:
## expandedIntvalArray = weconeinterval ([90, 45], 15, 1)
## expandedIntvalArray = weconeinterval ([90, 85], 15, 1)
## expandedIntvalArray = weconeinterval ([90, 05], 15, 1)
## coneAxisWeTrdPlg = [90, 05]; coneAngleDeg = 15; wantplot = 1;

## expandedIntvalArray = weconeinterval ([90, 45], 55, 1)

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-16

function expandedIntvalArray = weconeinterval (coneAxisWeTrdPlg, coneAngleDeg, ...
    wantplot)

## Input management.
if nargin < 3
    wantplot = false;
endif

## The trend should be 90 or 270, for thhis analysis
trdGral = coneAxisWeTrdPlg(1);
plgGral = coneAxisWeTrdPlg(2);

if ~or(trdGral == 90, trdGral == 270)
    error('Trend should be 90 or 270 onlt!');
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

expandedIntvalArray = [infLimsarray; supLimsarray];

## Plotting
if wantplot
    hold on
    for k = 1 : 2 : size (expandedIntvalArray,1)
        plotintvalvertseccusphere (expandedIntvalArray(k:k+1,:));
    endfor
    plotframevertseccusphere (0);
endif

endfunction


