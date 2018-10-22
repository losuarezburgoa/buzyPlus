## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} clutserwithwindow (@var{input1}, @var{input2})
##

## Examples.
## all the examples will use this data.
## trendplungeMat = [353, 11; 166, 85; 11, 77; 116, 66; 139, 72; ...
##    329, 31; 4, 49; 9, 85; 113, 67; 263, 10; 315, 33; 263, 10; 152, 72; ...
##    158, 84; 126, 48];
## want2see = 1;

## Example 1:
## An annulus sector.
## lowerRigthTrendPlungeVec = [320, 70];
## windowArc = 50;
## otherExtremePlunge = 15;

## Example 2:
## An annulus sector that surpasses the other extreme of the boundary.
## With the same data except 'otherExtremePlunge', now try with this value in 
## negative value; this will move the lower part of the window to the other
## side of the net.
## lowerRigthTrendPlungeVec = [320, 70];
## windowArc = 50;
## otherExtremePlunge = -15;

## Example 3:
## An anulus wil be.
## lowRgthTrdPlgeVec = [000, 50];
## winArc = 360;
## othExtrPlg = 20;

## Example 4:
## A circle will be.
## lowRgthTrdPlgeVec = [000, 90];
## winArc = 360;
## othExtrPlg = 70;

## Example 5:
## A non symmetric annulus but that surpases the other extreme.
## lowRgthTrdPlgeVec = [000, 60];
## winArc = 180;
## othExtrPlg = -20;

## Example 6:
## A symmetrivc annulus  but that surpasses to the other extreme.
## lowRgthTrdPlgeVec = [000, 30];
## winArc = 180;
## othExtrPlg = -30;

## Example 7:
## lowerRigthTrendPlungeVec = [175, 10];
## windowArc =  15;
## otherExtremePlunge = -5;

## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-24

function [clusteredTrendPlungeMat, clusterIdVec] = ...
    clusterwithwindow (lowerRigthTrendPlungeVec, windowArc, otherExtremePlunge, ...
    trendplungeMat, want2see)

## Inputmanagement.
if nargin < 5
    want2see = false;
endif

## Definnig if the window splits in two parts.

if otherExtremePlunge < 0
    typeOfWindow = 'd';
    otherExtremePlunge = abs(otherExtremePlunge);
else 
    typeOfWindow = 's';
endif

## Usinhg the function 'clusterwithwindowmanually'.
clusterId = 1;
[clusteredTrendPlungeMat, clusterIdVec] = clusterwithwindowmanually ...
    (lowerRigthTrendPlungeVec, windowArc, otherExtremePlunge, typeOfWindow, ...
    clusterId, trendplungeMat, want2see);

endfunction
