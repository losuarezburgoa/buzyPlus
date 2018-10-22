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
## @deftypefn {} {@var{retval} =} spectralclustering (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-05-31

function [knTParrayCell, lCell, knNormEigVecCell] = spectralclustering ...
    (trendPlungeArray, K, sigma)

## Example
# trendPlungeArray = [294, 46; 288, 40; 288, 49; 282, 42; 276, 40; 276, 49; 241, 68; 208, 74; 262, 45; 258, 37; 252, 40; 240, 50; 240, 42; 250, 24; 250, 15; 244, 28; 242, 32; 242, 24; 236, 35; 230, 50; 230, 47; 222, 52; 184, 64; 170, 64; 165, 55; 154, 52; 180, 45; 201, 50; 195, 48; 198, 48; 201, 46; 188, 44; 192, 40; 205, 43; 214, 44; 218, 48; 230, 38; 231, 36; 225, 37; 220, 36; 212, 34; 210, 34; 202, 34; 198, 30; 205, 25; 210, 30; 210, 22; 214, 13; 220, 20; 222, 10; 225, 14; 226, 30; 232, 32; 234, 30; 234, 26; 234, 23; 236, 20; 238, 15; 234, 16; 230, 20; 230, 8; 236, 8; 240, 5; 338, 24; 344, 7; 348, 2; 350, 10; 354, 15; 0, 18; 2, 14; 5, 14; 8, 8; 10, 1; 14, 3; 14, 10; 15, 20; 10, 25; 8, 37; 8, 34; 22, 50; 41, 52; 48, 24; 44, 25; 25, 36; 22, 36; 31, 30; 20, 25; 18, 24; 30, 19; 34, 8; 30, 5; 22, 18; 22, 14; 22, 12; 20, 12; 150, 10; 158, 2; 170, 1; 175, 4; 180, 4; 185, 1; 184, 4; 185, 6; 190, 2; 190, 5; 170, 10; 160, 15; 178, 8; 179, 11; 180, 10; 178, 15; 170, 26; 173, 24; 178, 24; 184, 14; 185, 16; 188, 21; 190, 15; 192, 15; 194, 24; 195, 20; 196, 16; 204, 20; 200, 10; 202, 6; 210, 8; 212, 9; 144, 28; 140, 25; 120, 33; 128, 18; 114, 32; 110, 26; 110, 19; 95, 24; 76, 8; 80, 8; 82, 1; 85, 8; 95, 14; 96, 13; 95, 5; 98, 4; 98, 10; 100, 9; 100, 12; 105, 15; 105, 9; 108, 4; 110, 5; 112, 5; 114, 6; 118, 7; 120, 12; 122, 5; 128, 1; 130, 4; 130, 5; 134, 2; 312, 4; 310, 6; 304, 5; 295, 9; 292, 8; 290, 5; 287, 4; 278, 2; 274, 5; 286, 10; 290, 15; 282, 16; 278, 15; 274, 21; 280, 27];

% Transform to trend-plunge values ti univt vector. values
unitVectorArray = trendplunge2unitvect(trendPlungeArray);

% The scaling parameter sigma2.
if nargin < 2
  K = 3;
  sigma = 0.12;
elseif nargin < 3
  sigma = 0.12;
endif

% The numner of clusters should not be greater than 12.
if K > 12
  error('The dimension K should be less than 12!');
endif
% Using the square of sigma.
sigmaP2 = sigma^2;

% The affinity matrix (enumeration 1) at Cluster algoritm ss 3.
numData = size(unitVectorArray, 1);
afftyMat = zeros(numData);
for i = 1 : numData
  for j = 1 : numData
    a = sinebasesimdistance(unitVectorArray(i,:)', unitVectorArray(j,:)');
    if i==j
      afftyMat(i,j) = 0;
    else
      afftyMat(i,j) = exp(-a / 2 / sigmaP2);
    endif
  endfor
endfor

% Sum of rows of the affinity matrix.
sumRowsAfftyMat = sum(afftyMat, 2);
dMat = diag(sumRowsAfftyMat);
dOver05 = dMat ^(-1/2);

% The normalized affinity matrix.
normAfftyMat = dOver05 * afftyMat * dOver05;

% The spectral descomposition of the normalized affinity matrix.
[eigVecMat, eigValMat] = eig(normAfftyMat);
[eigVecMat, eigValMat] = sortem(eigVecMat, eigValMat);

% The sorted eigenvector matrix in R^K.
vColVec = zeros(numData, 1);
for i = 1 : numData
  vColVec(i) = sqrt(dot(eigVecMat(i, 1:K), eigVecMat(i, 1:K)'));
endfor

% The normalized eigenvector matrix.
normEigVecMat = zeros(numData, K);
for i = 1 : numData
  normEigVecMat(i,1:K) = eigVecMat(i, 1:K) ./ vColVec(i);
endfor

% Clustering the normalized eigenvector matrix with the k-means clustering method.
[idx, cent] = kmeans(normEigVecMat(:,1:K), K);
lCell = cell(1, K);
for i = 1 : K
  lCell{i} = [zeros(1, K); cent(i,:)];
endfor

% Clustered trend and plunge data.
knTParrayCell = cell(1, K);
for i = 1 : K
  knTParrayCell{i} = trendPlungeArray(idx==i, :);
endfor

% Clustered eigen vectors.
knUVarrayCell = cell(1, K);
for i = 1 : K
  knNormEigVecCell{i} = normEigVecMat(idx==i, :);
endfor

endfunction
