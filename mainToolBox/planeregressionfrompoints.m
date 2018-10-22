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
## @deftypefn {} {@var{retval} =} planeregressionfrompoints (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-08

function [poleVec, planeVec] = planeregressionfrompoints (trendPlungeArray, ...
    wantplot, projType)

## Input management.
if nargin < 2
    wantplot = false;
    projType = 'equalangle';
elseif nargin < 3
    projType = 'equalangle';
endif

%% Transforming orientations to unit vectors.
numData = size (trendPlungeArray, 1);

unitVecArray = zeros(numData, 3);
for i = 1 : numData
    unitVecArray(i, :) = trendplunge2unitvect (trendPlungeArray(i,:));
endfor

%% Creating tensors from vectors.
sumedTransformationTensor = zeros(3);
for i = 1 : numData
    transformationTensor = unitVecArray(i,:)' * unitVecArray(i,:);
    sumedTransformationTensor = sumedTransformationTensor + ...
        transformationTensor;
endfor

%% Doing the spectral decompositioin of the summed tensor.
[V, D] = eig (sumedTransformationTensor);

prinTrendPlungeArray = zeros(3,2);
for i = 1 : 3
    a = unitvect2trendplunge (transpose(V(:, i)));
    prinTrendPlungeArray(i, :) = prepareorientationangles (a);
endfor

## Determine which of the values is the minimum.
[~, sidx] = sort (diag(D), 'ascend');

%% Obtaining the axis-fold orientation.
amin = unitvect2trendplunge (transpose(V(:, sidx(1))));
poleVec = prepareorientationangles (amin);
planeVec = dipdirdip2pole (poleVec);

if wantplot
    hold on
    plotplaneorientationdata (trendPlungeArray, projType, 'kx', false, 4);
    plotplaneorientationdata (poleVec, projType, 'ko', false, 5);
    plotgreatecircle (planeVec, projType);
endif

endfunction
