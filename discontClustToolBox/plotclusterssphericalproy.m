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
## @deftypefn {} {@var{retval} =} plotclusterssphericalproy (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-06-01

function [h, pltfig] = plotclusterssphericalproy(knTParrayCell, projectionType, ...
    symbolSize, polargridTrue)

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

K = length(knTParrayCell);
if K > 12
  error('The dimension K should be less than 12!');
endif

kSymbCell = {'o', 'x', '^', '+', 'v', '.', '<', 'd', '>', '*'};
kNameCell = cell(1, K);
for i = 1 : K
  kNameCell{i} = sprintf('Cluster %d', i);
endfor

stringKwarks = '';
for i = 1 : K
  stringKwarks = strcat(stringKwarks, sprintf(', ''%s''', kNameCell{i}));
endfor

% Plotting in the spherical projection.
pltWinTitle = ['Clusters in ', projectionType, '.'];
pltfig = figure('Color', ones(1,3), 'Name', pltWinTitle, 'NumberTitle', 'off'); hold on
for i = 1 : K
  hn2Eval = sprintf( ...
    'h(%d) = plotplaneorientationdata(knTParrayCell{%d}, projectionType, kSymbCell{%d}, false, symbolSize);', ...
    [i, i, i]);
  eval(hn2Eval);
endfor

hn2Eval = sprintf('legendHandle = legend(h %s);', stringKwarks);
eval(hn2Eval);
set(legendHandle, 'Box', 'off');
set(legendHandle, 'Color', 'none');
if polargridTrue == true
    createpolargrid(projectionType);
endif
axis equal
plotgreatcircnorth(projectionType);
hold off

endfunction
