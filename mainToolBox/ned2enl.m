## Copyright (C) 2019 Ludger O. Suarez-Burgoa
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
## @deftypefn {} {@var{retval} =} ned2enl (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2019-01-17

function [nelUvectArray] = ned2enl (nedUvectArray)

T = [0, 1, 0; 1, 0, 0; 0, 0, -1];

numData = size(nedUvectArray, 1);
nelUvectArray = zeros(numData, 3);
for k = 1 : numData
    nelUvectArray(k,:) = transpose(T * nedUvectArray(k,:)');
endfor

endfunction
