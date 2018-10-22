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
## @deftypefn {} {@var{retval} =} plotunclusterssphericalproy (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-06-01

function [pltfig] = plotunclusterssphericalproy(trendPlungeArray, ...
    projectionType, symbolSize, polargridTrue)

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

%% Plotting the data in equal area.
pltWinTitle = ['Unclustered data in ', projectionType, '.'];

pltfig = figure('Color', ones(1,3), 'Name', pltWinTitle, 'NumberTitle', 'off'); hold on
plotplaneorientationdata(trendPlungeArray, projectionType, 's', false, symbolSize);
if polargridTrue == true
    createpolargrid(projectionType);
endif
plotgreatcircnorth(projectionType);
axis equal
hold off

endfunction
