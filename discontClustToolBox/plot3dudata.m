function [pltfig] = plot3dudata (knNormEigVecCell, lCell, symbolSize, ...
    viewVec, kSymbCell)

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{pltfig} =} plot3dudata ...
##    (@var{knNormEigVecCell}, @var{lCell}, @var{symbolSize}, @var{viewVec}, 
##     @var{kSymbCell})
##
## Input(s):
## @var{knNormEigVecCell}, a (a x K) cell containing the eigen vectors.
## @var{lCell}, a (1 x K) cell that contains the centers of the clusters obtaiend
## by the kmeans statistical method.
## @var{symbolSize}, a natural number that defines the size in pt of the symbols 
## in the plot.
## @var{viewVec}, a (1 x 2) vector that contains the point of view of the 3D 
## plot; same as used in the function @ff{view}; by dafault is [30, 20].
## @var{kSymbCell}, a (1 x 3) cell with string that defines the symbols of each
## K cluster; By default is {'o', 'x', '^'}.
##
## Output(s):
## @var{pltfig} is a figure handle that contains all the plot.
##
## @seealso{plotudata}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
## Created: 2018-06-03

K = length (knNormEigVecCell);
if K ~= 3
    error ('This plot is only for three dimensions!');
endif

if nargin < 3
    symbolSize = 5;
    viewVec = [30, 20];
    kSymbCell = {'o', 'x', '^'};
elseif nargin < 4
    viewVec = [30, 20];
    kSymbCell = {'o', 'x', '^'};
else
    kSymbCell = {'o', 'x', '^'};
endif

kNameCell = cell(1, K);
for i = 1 : K
  kNameCell{i} = sprintf ('Cluster %d', i);
endfor

cent = zeros(K);
for i = 1  : K
  cent = lCell{i}(2,:);
endfor

stringKwarks = '';
for i = 1 : K
  stringKwarks = strcat (stringKwarks, sprintf(', ''%s''', kNameCell{i}));
endfor

uNameCell = cell(1, K);
for i = 1 : K
  uNameCell{i} = sprintf ('U_%d', i);
endfor

pltWinTitle = ['Clusters in the transformed ', sprintf('K^%d', K), 'space.'];
pltfig = figure('Color', ones(1,3), 'Name', pltWinTitle, 'NumberTitle', 'off'); hold on

h(1) = plot3 (knNormEigVecCell{1}(:,1), knNormEigVecCell{1}(:,2), knNormEigVecCell{1}(:,3), 'color', 'k', kSymbCell{1}, 'MarkerSize', symbolSize);
h(2) = plot3 (knNormEigVecCell{2}(:,1), knNormEigVecCell{2}(:,2), knNormEigVecCell{2}(:,3), 'color', 'k', kSymbCell{2}, 'MarkerSize', symbolSize);
h(3) = plot3 (knNormEigVecCell{3}(:,1), knNormEigVecCell{3}(:,2), knNormEigVecCell{3}(:,3), 'color', 'k', kSymbCell{3}, 'MarkerSize', symbolSize);
h(4) = plot3 (cent(:,1), cent(:,2), cent(:,3), 'rp', 'MarkerSize', 1.5*symbolSize, 'MarkerFaceColor', 'r');
for i = 1 : K
  plot3 (lCell{i}(:,1), lCell{i}(:,2), lCell{i}(:,3), 'k-');
endfor
view(viewVec);
hn2Eval = sprintf('legendHandle = legend(h %s, ''Centers'');', stringKwarks);
eval(hn2Eval);
set(legendHandle, 'Box', 'off');
set(legendHandle, 'Color', 'none');
xlabel(uNameCell{1});
ylabel(uNameCell{2});
zlabel(uNameCell{3});

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