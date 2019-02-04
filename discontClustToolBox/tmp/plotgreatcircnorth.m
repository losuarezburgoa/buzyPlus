function [ ] = plotgreatcircnorth (projType, tickProp, equalTrendPrinMatR, ...
    equalTrendSecondMatR)
## -*- texinfo -*- 
## @deftypefn {} {@var{plotHandle} =} plotgreatcircnorth
##    (@var{projType}, @var{tickProp}, @var{equalTrendPrinMatR}, 
##     @var{equalTrendSecondMatR})
##
## Descrition:
## Plots the great external ccircle of the spherical projection. Do not
## confuse with the function @var{plotgreatecircle} wich plots a great inclined
## circle inside this great circle. 
##
## Input(s):
## String of the type of the spherical projection, @var{projType}.
## Tick length proportinal to the grate circle radius (@var{tickProp}, e.g. 
## 0.05 means that the tick length will be 5 % of the great circle radius.
## Array with the principal grid, @var{equalTrendPrinMatR}.
## Array with the secondary grid, @var{equalTrendSecondMatR}.
##
## @seealso{plotgreatccircle, plotradialtrendextticks}
## @end deftypefn

## Input management.
if nargin < 2
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 3
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
endif

[equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
circleRadius = equalTrendPrinMatR(1, 2);

## Creating the great circle.
greatCirclPrinRowArray = equalTrendPrinMatR(1, :);
greatCirclScndRowArray = equalTrendSecondMatR(1, :);

thetaRadGcPrin = greatCirclPrinRowArray(1:2:length(greatCirclPrinRowArray));
thetaRadGcScnd = greatCirclScndRowArray(1:2:length(greatCirclScndRowArray));

thetaRadGc = sort ([thetaRadGcPrin, thetaRadGcScnd]);
thetaRadGreatC = [thetaRadGc, thetaRadGc(1)];
rhoGreatC = ones(1, length(thetaRadGreatC)) * circleRadius;
[xGreatC, yGreatC] = pol2cart (thetaRadGreatC, rhoGreatC);

## Creating the north and its tick.
xNt = zeros(1, 2);
yNt = circleRadius *[1, (1 + tickProp)];

## Creating the center of the circle.
xCtv = zeros(1, 2);
yCtv = circleRadius * tickProp * 0.4 * [-1, 1];

xCth = circleRadius * tickProp * 0.4 * [-1, 1];
yCth = zeros(1, 2);

## Plotting.
limitsVec = ones(1,4);
limitsVec([1:2:end]) = -1;

hold on
# The great circle.
plot (xGreatC, yGreatC, 'k-', 'Linewidth', 2);
# The cener.
plot (xCtv, yCtv, 'k-', 'Linewidth', 1);
plot (xCth, yCth, 'k-', 'Linewidth', 1);
# The north tick.
plot (xNt, yNt, 'k-', 'Linewidth', 2);
text (xNt(2), (yNt(2) + tickProp * 2 / 3), 'N', 'Color', 'k', 'FontSize', 12, ...
    'FontWeight', 'bold', 'FontName', 'Roman', ...
    'HorizontalAlignment','center');
%axisBox = circleRadius * (1 + tickProp * 1.2) * limitsVec;
%axis(axisBox, 'equal', 'off');

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