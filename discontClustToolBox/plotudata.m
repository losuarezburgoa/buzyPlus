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
## @deftypefn {} {@var{retval} =} plotudata (@var{knTParrayCell}, ...
##     @var{lCell}, @var{knNormEigVecCell}, @var{projectionType}, @var{symbolSize})
##
## Description.
## This function plots the eigen vectors, which are the axes of the central 
## orientations of the clusters in two and three dimensions in the common
## Euclidean space. For more than the three dimension, it plots a CVA biplot 
## (to be implemented). A Canonical Variate Analysis (CVA) is a biplot used
## in clusteres. See Gower.etal2011.book for more details (Chapter 4, page 145).
## The number of clusteres (number of dimension) to be displayed is limited to
## twelve only because more clusteres could be uncesessary.
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-06-01

function [pltfig] = plotudata (knTParrayCell, knNormEigVecCell, lCell, symbolSize)

if nargin < 4
  symbolSize = 5;
end

K = length (knTParrayCell);
if and(K <= 1, K > 10)
  error ('The dimension K should be greater than 1 and less than 11!');
endif

% Plotting in the transformed K-space.
switch K
    case 2
        pltfig = plot2dudata (knNormEigVecCell, lCell, symbolSize);
    case 3
        pltfig = plot3dudata (knNormEigVecCell, lCell, symbolSize);
    otherwise
        plotndudatasva (knNormEigVecCell, lCell, symbolSize)
end

endfunction
