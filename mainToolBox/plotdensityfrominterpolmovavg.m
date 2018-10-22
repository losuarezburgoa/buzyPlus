## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotdensityfrominterpolmovavg (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-26

function [uGrayColorMap] = plotdensityfrominterpolmovavg (finalDestineXmat, ...
    finalDestineYmat, finalDestineZmat)

## Input management.
%NEW COLOR MAPS
%Gray Tones Color Map 'grayi'
uGrayColorMap = ...
  [ 1.0000    1.0000    1.0000;
    0.9841    0.9841    0.9841;
    0.9683    0.9683    0.9683;
    0.9524    0.9524    0.9524;
    0.9365    0.9365    0.9365;
    0.9206    0.9206    0.9206;
    0.9048    0.9048    0.9048;
    0.8889    0.8889    0.8889;
    0.8730    0.8730    0.8730;
    0.8571    0.8571    0.8571;
    0.8413    0.8413    0.8413;
    0.8254    0.8254    0.8254;
    0.8095    0.8095    0.8095;
    0.7937    0.7937    0.7937;
    0.7778    0.7778    0.7778;
    0.7619    0.7619    0.7619;
    0.7460    0.7460    0.7460;
    0.7302    0.7302    0.7302;
    0.7143    0.7143    0.7143;
    0.6984    0.6984    0.6984;
    0.6825    0.6825    0.6825;
    0.6667    0.6667    0.6667;
    0.6508    0.6508    0.6508;
    0.6349    0.6349    0.6349;
    0.6190    0.6190    0.6190;
    0.6032    0.6032    0.6032;
    0.5873    0.5873    0.5873;
    0.5714    0.5714    0.5714;
    0.5556    0.5556    0.5556;
    0.5397    0.5397    0.5397;
    0.5238    0.5238    0.5238;
    0.5079    0.5079    0.5079;
    0.4921    0.4921    0.4921;
    0.4762    0.4762    0.4762;
    0.4603    0.4603    0.4603;
    0.4444    0.4444    0.4444;
    0.4286    0.4286    0.4286;
    0.4127    0.4127    0.4127;
    0.3968    0.3968    0.3968;
    0.3810    0.3810    0.3810;
    0.3651    0.3651    0.3651;
    0.3492    0.3492    0.3492;
    0.3333    0.3333    0.3333;
    0.3175    0.3175    0.3175;
    0.3016    0.3016    0.3016;
    0.2857    0.2857    0.2857;
    0.2698    0.2698    0.2698;
    0.2540    0.2540    0.2540;
    0.2381    0.2381    0.2381;
    0.2222    0.2222    0.2222;
    0.2063    0.2063    0.2063;
    0.1905    0.1905    0.1905;
    0.1746    0.1746    0.1746;
    0.1587    0.1587    0.1587;
    0.1429    0.1429    0.1429;
    0.1270    0.1270    0.1270;
    0.1111    0.1111    0.1111;
    0.0952    0.0952    0.0952;
    0.0794    0.0794    0.0794;
    0.0635    0.0635    0.0635;
    0.0476    0.0476    0.0476;
    0.0317    0.0317    0.0317;
    0.0159    0.0159    0.0159;
         0         0         0];

%PLOTTING
hold on
axis(1 * [-1 ,1 ,-1 ,1], 'equal', 'off');

## Contours.
# Number of countorns.
%maxValue = max(max(finalDestineZmat));
%numberCountorns = floor(maxValue / contourIntervalPercentaje) + 1;
%maxCountValue = numberCountorns * contourIntervalPercentaje;
# Monotonically increasing vector v for the contours lines
%v = linspace(1, maxCountValue, numberCountorns);
%drawfilledcontour(extendedAverageValuesGrid, contourIntervalPercentaje, ...
%    '2Dfilled', colorMap);
% contourMatrix = contour (finalDestineXmat, finalDestineYmat, finalDestineZmat, v);
%clabel(contourMatrix, contourHandle, 'LabelSpacing', 350, 'FontSize', 9, ...
%    'Color', 'white', 'Rotation', 0);

s = surf (finalDestineXmat, finalDestineYmat, finalDestineZmat);
set(s, 'EdgeColor', 'none');
%colormap(uGrayColorMap);
%view(2);

endfunction
