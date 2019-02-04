function [pltfig] = plotunclusterssphericalproy (trendPlungeArray, ...
    projectionType, symbolSize, polargridTrue)
## -*- texinfo -*- 
## @deftypefn {} {@var{pltfig} =} plotunclusterssphericalproy 
## (@var{trendPlungeArray}, @var{projectionType}, @var{symbolSize}, @var{polargridTrue})
##
## Plot the unclustered data stored in the @var{trendPlungeArray} in a specified
## spherical projection. By default is used the equalarea spherical projection.
## spherical projection and does not plots the grid. Returns a figure handle that
## can be manipulated by the user.
##
## Input(s):
## @var{trendPlungeArray}, is a (n x 2) array that represent in the first column
## the trend angle, and in the second column the plunge angle.
## @var{projectionType} , is a string specifying the type of projection you want
## to plot, can be 'equalarea' or 'equalangle'.
## @var{symbolSize} is an interger in pt units of the size of the symbols in 
## the plot;  by default is of size 5.
## @var{polargridTrue}, is a boolean value if true plots the polar grid in the 
## plot. By default is false.
##
## Output(s):
## @var{pltfig} is a figure handle that contains all the plot.
##
## @seealso{buzyPlus_toolbox}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2018-06-01

## Input management, default values.
if nargin < 2
  projectionType = 'equalarea';
  symbolSize = 5;
  polargridTrue = false;
elseif nargin < 3
  symbolSize = 5;
  polargridTrue = false;
elseif nargin < 4
  polargridTrue = false;
end

## Plotting the data in the select spherical projection.
pltWinTitle = ['Unclustered data in ', projectionType, '.'];

pltfig = figure('Color', ones(1,3), 'Name', pltWinTitle, 'NumberTitle', 'off');
hold on
plotplaneorientationdata (trendPlungeArray, projectionType, 's', false, symbolSize);
if polargridTrue == true
    createpolargrid (projectionType);
endif
plotgreatcircnorth (projectionType);
axis equal
hold off

endfunction

## Copyright (C) 2018 Ludger O. Suarez-Burgoa & Universidad Nacional de Colombia.
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