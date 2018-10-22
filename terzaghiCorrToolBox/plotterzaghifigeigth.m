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
## @deftypefn {} {@var{retval} =} plotterzaghifig8 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn
## Colored degraded plot of relative density plots.

## The problem.
## Based on the equation
##     N_\mathrm{\alpha} = \frac{L \sin{\alpha}}{d};
## where \(d\) id the discontinuity real spacinf and \(L\) and \(\alpha\)
## are respectively:
## For an horizontal scanline in an horizontal outcrop.
##   Scanline length and angle of the discontinuity plane to the outcrop plane;
## For a vertical borehole.
##   Borehole length and angle of the borehole axis and discontinuity plane.
## create in the equal-area great-circle space a colored degrated plot of 
## relative density of poles form them most external contour to the center.
## Similar to the Figure 8 (page 296) of Terzaghi1965.article, but smoothly degrated. 
## Use jet and gray color maps.

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2018-07-04

## Input(s):
##
## The Figure 8 of the Terzaghi article has two study cases, the case of data
## collecting in an horizontal outcrop (i.e. 'horizOutcrop') and the case o data
## collecting in a vertical borehole (i.e.'vertBorehole'). This to string may
## be put in the variable 'studyCase'.
##
## The projection type can be 'equalarea' or 'equalangle'.
##
## The interval angle in the calculation, is the minimum angle step in the 
## whole range, by thefault is 2° (angleIntervalDeg). 
##
## A boolean value of true in the 'wantplot' variable can be assign in order toascii
## have the results plotted with the 'surf' function.
##
## The color map in the plot (colomapStr) can be 'jet', 'gray', 'bone', 'hot'.
##

## Example1:
## [x, y, z] = plotterzaghifigeigth ('horizOutcrop', 'equalarea', 2, true, 'gray');
## 

function [x, y, z] = plotterzaghifigeigth (studyCase, projType, ...
      angleIntervalDeg, wantplot, colormapStr)

if nargin < 2
    projType = 'equalarea';
    angleIntervalDeg = 2;
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 3
    angleIntervalDeg = 2;
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 4
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 5
    colormapStr = 'jet';
endif

## The alpha angle varing from 0 to 90.
alphaRad = [0: angleIntervalDeg : 90] * pi / 180;

## Equal area spherical proyection distance correction.
switch projType
    case 'equalarea'
       alphaProy = sin(alphaRad / 2) / sqrt(2) * 2;
    case 'equalangle'
       alphaProy = tan(alphaRad / 2);
    otherwise
       error('Bad projection type!');
endswitch

## Creating the grid in polar coordiantes and then in cartesian.
trendRad = [0 : angleIntervalDeg : 360] * pi / 180;
[th, r] = meshgrid (trendRad, alphaProy);
[x, y] = pol2cart(th, r);

switch studyCase
    case 'horizOutcrop'
       ## Case of horizontal outcrop.
       z = sqrt(x.^2 + y.^2);
    case 'vertBorehole'
       ## Case of vertical borehole.
       z = 1 - sqrt(x.^2 + y.^2);
    otherwise
       error('Bas projection type!');
endswitch

## Ploting the result.
hold on
surf(x, y, z, 'EdgeColor', 'None');
colormap (colormapStr);
colorbar;
view(2);
axis([-1, 1, -1, 1]);
axis equal
axis off

endfunction
