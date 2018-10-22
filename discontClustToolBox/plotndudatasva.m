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
## @deftypefn {Function File} {@var{retval} =} plotndudatasva (@var{input1}, @var{input2})
##
## For more than the three dimensions, it plots a CVA biplot under a Canonical 
## Variate Analysis (CVA); which is a biplot used in clustered data.
## See Gower.etal2011.book for more details (Chapter 4, page 145).
## The number of clusteres (number of dimension) to be displayed is limited to
## ten only, because more clusteres could be uncesessarily detailed.
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-06-03

function [] = plotndudatasva(knNormEigVecCell, lCell, symbolSize)

display('Plot in K^n with n other than 2 or 3 is not presented!');
display('I will develop the proper tool for displaying clustered data in K^n.');
        
% This is under development.
% I will use bi-plots, which is a generalization of the scatterplot 
% of two variables to the case of many variables.

if nargin < 3
  symbolSize = 5;
end

K = length(knNormEigVecCell);
if and(K <= 1, K > 10)
  error('The dimension K should be greater than 1 and less than 11!');
endif

cent = zeros(K);
for i = 1  : K
  cent = lCell{i}(2,:);
endfor

kSymbCell = {'o', 'x', '^', '+', 'v', '.', '<', 'd', '>', '*'};
kNameCell = cell(1, K);
for i = 1 : K
  kNameCell{i} = sprintf('Cluster %d', i);
endfor

stringKwarks = '';
for i = 1 : K
  stringKwarks = strcat(stringKwarks, sprintf(', ''%s''', kNameCell{i}));
endfor

uNameCell = cell(1, K);
for i = 1 : K
  uNameCell{i} = sprintf('U_%d', i);
endfor

# Plotting for the biplot.
# I will prepare the data in order to be used in a R program for Biplots.
totnumDataVec = zeros(1,K);
for i = 1 : K
    totnumDataVec(i) = size(knNormEigVecCell{i}, 1);
endfor
totnumDataVec = [0, totnumDataVec];

cumsumDataVec = cumsum(totnumDataVec);
A = zeros(cumsumDataVec(end), K+1);

for i = 1 : K
    numData = size(knNormEigVecCell{i}, 1);
    A(cumsumDataVec(i)+1 : cumsumDataVec(i+1), 1) = ones(numData,1) * i;
    A(cumsumDataVec(i)+1 : cumsumDataVec(i+1), 2:K+1) = knNormEigVecCell{i};
endfor
A = [transpose(1:1:sum(totnumDataVec)), A];

totNumData = sum(totnumDataVec);
file_id = fopen('data4R.dat', 'w');
for i = 1 : totNumData
    fdisp(file_id, sprintf('%d\t%d\t%.4f\t%.4f\t%.4f\t%.4f', A(i,:)));
endfor
fclose(file_id);

endfunction
