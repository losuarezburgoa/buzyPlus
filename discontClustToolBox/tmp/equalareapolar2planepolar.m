function [planePolarMat] = equalareapolar2planepolar (trendPlungeMat)

## -*- texinfo -*- 
## @deftypefn {} {@var{planePolarMat} =} equalareapolar2planepolar 
##    (@var{trendPlungeMat})
##
## Description:
## Transforms the spatial orientation of a line represented by its trend and 
## plunge into a plane polar representation in the NED coordinate system, which
## represents an equal area southern polar projetion.
## 
## Inputs(s):
## Trend and plunge vector expressed in hexadecimal grades @var{trendPlungeVec}.
## 
## Output(s):
## Polar angle in the NED system in radians, qvar{angleThetaRad}.
## Polar radius in the NED system, @var{rho}.
## 
## Example 1:
## @code{equalareapolar2planepolar ([215, 15]);}
##
## Example 2:
## @code{equalareapolar2planepolar ([215, 15; 236, 25; 024, 13]);}
##
## @seealso{trendplunge2unitvect}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa qemail{losuarezb@unal.edu.co}
## Created: 2018-10-25

dataNumber = size (trendPlungeMat, 1);

planePolarMat = zeros (size(trendPlungeMat));
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

## Copyright (C) 2018 Ludger O. Suarez-Burgoa & Universidad Nacional de Colombia.
## 
## This program is free software; redistribution and use in source and
## binary forms, with or without modification, are permitted provided that
## the following conditions are met:
## 
##    1.Redistributions of source code must retain the above copyright
##      notice, this list of conditions and the following disclaimer.
##    2.Redistributions in binary form must reproduce the above copyright
##      notice, this list of conditions and the following disclaimer in the
##      documentation and/or other materials provided with the distribution.
## 
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
## ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
## FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
## DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
## OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
## LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
## OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
## SUCH DAMAGE.