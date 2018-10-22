function [rotatedTrendPlungeVec] = rot_orient_arnd_verticalaxs ...
    (trendPlungeVec, rotationAngleGrad)

## Description:
## Rotates an orientation, around a vertical axis a given rotation angle. If
## the rotation angle is positive the rotation is clockwise, else is
## couterclockwise. 
## 
## Nested function(s):
## none
## 
## Input(s):
## Vector of trend and plunge values of the orientation (trendPlungeVec).
## 
## Rotation angle in hexadecimal angular grades. If it is positie it rotates
## clockwise when seeing northwards, if negative it rotates counterclockwise
## (rotationAngleGrad). 
## 
## Output(s):
## Vector of trend and plunge values that indicates the rotated orientation
## (rotatedTrendPlungeVec)

rotatedTrendPlungeVec = zeros(1, 2);

rotatedTrendPlungeVec(1) = trendPlungeVec(1) + rotationAngleGrad;
rotatedTrendPlungeVec(2) = trendPlungeVec(2);

rotatedTrendPlungeVec = prepareorientationangles (rotatedTrendPlungeVec);

endfunction

