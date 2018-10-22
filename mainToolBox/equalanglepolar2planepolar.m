function [planePolarMat] = equalanglepolar2planepolar (trendPlungeMat)

## Description:
## Transforms the spatial orientation of a line represented by its trend and plunge
## into a plane polar representation in the NED coordinate system, which 
## represents an equal angle southern polar projetion.

## Inputs(s):
## Trend and plunge vector expressed in hexadecimal grades (trendPlungeVec)

## Output(s):
## Polar angle in the NED system in radians (angleThetaRad).
## Polar radius in the NED system (rho).

## Example:
## [theta, rho] = equalanglepolar2planepolar ([158, 45]);

dataNumber = size(trendPlungeMat, 1);

planePolarMat = zeros(size(trendPlungeMat));
for i = 1 : dataNumber
    [planePolarMat(i ,1), planePolarMat(i ,2)] = eangle2polar ...
        (trendPlungeMat(i ,:));
endfor
endfunction


function [angleThetaRad, rho] = eangle2polar (trendPlungeVec)
  
sphereRadius = 1;
trendPlungeVecRad = trendPlungeVec * pi / 180;

if trendPlungeVecRad(1) > 2 * pi
    angleThetaRad = trendPlungeVecRad(1) - ...
        floor(trendPlungeVecRad(1) ./ 2 ./ pi) * 2 * pi;
else
    angleThetaRad = trendPlungeVecRad(1);
endif

## This is a non exact solution (i.e. approximate solution)
##  kFactor =0;
##  rho =sphereRadius *(1 +kFactor) *cos(trendPlungeVecRad(2))...
##      ./ (1 +kFactor +sin(trendPlungeVecRad(2)));

rho = sphereRadius * tan((pi / 2 - trendPlungeVecRad(2)) / 2);

endfunction