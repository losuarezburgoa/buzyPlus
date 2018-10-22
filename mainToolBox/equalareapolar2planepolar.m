function [planePolarMat] = equalareapolar2planepolar (trendPlungeMat)

## Description:
## Transforms the spatial orientation of a line represented by its trend and plunge
## into a plane polar representation in the NED coordinate system, which
## represents an equal area southern polar projetion.
## 
## Inputs(s):
## Trend and plunge vector expressed in hexadecimal grades (trendPlungeVec)
## 
## Output(s):
## Polar angle in the NED system in radians (angleThetaRad).
## Polar radius in the NED system (rho).
## 
## Example1:
## planePolarMat = equalareapolar2planepolar ([215, 15]);
##
## Example2:
## planePolarMat = equalareapolar2planepolar ([215, 15; 236, 25; 024, 13]);

dataNumber = size(trendPlungeMat, 1);

planePolarMat = zeros(size(trendPlungeMat));
for k = 1 : dataNumber
    [planePolarMat(k, 1), planePolarMat(k, 2)] = earea2polar (trendPlungeMat(k, :));
endfor

endfunction


function [angleThetaRad, rho] = earea2polar (trendPlungeVec)

sphereRadius = 1;
trendPlungeVecRad = trendPlungeVec * pi / 180;

if trendPlungeVecRad(1) > 2 * pi
    angleThetaRad = trendPlungeVecRad(1) - ...
        floor(trendPlungeVecRad(1) ./2 ./pi) * 2 * pi;
else
    angleThetaRad = trendPlungeVecRad(1);
endif

## This is a non exact equation (i.e. approximation solution)
##  kFactor =sqrt(2);
##  rho =sphereRadius *(1 +kFactor) *cos(trendPlungeVecRad(2))...
##      ./ (1 +kFactor +sin(trendPlungeVecRad(2)));

rho = sphereRadius * sqrt(2) * cos((pi / 2 + trendPlungeVecRad(2)) / 2);

endfunction