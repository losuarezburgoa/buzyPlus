function [Zc, mu] = centerRows (Z)
## -*- texinfo -*- 
## @deftypefn {Function File} {@var{Zc}, @var{mu} =} centerRows (@var{Z})
##
## Returns the centered (zero mean) version of the input data, i.e.
## Z = Zc + repmat(mu,1,n).
##
## Input(s):
## @var{Z} is an (d x n) matrix containing n samples of a d-dimensional random
## vector.
##
## Output(s):
## @var{Zc} is the centered version of @var{Z}.
## @var{mu} is the (d x 1) sample mean of @var{Z}.
##               
## @seealso{repmat, bsxfun}
## @end deftypefn

## Author: Brian Moore @email{brimoor@umich.edu}
## Created: 2016-11-01

## Compute sample mean.
mu = mean (Z, 2);

## Subtract mean.
Zc = bsxfun (@minus, Z, mu);
endfunction

## Copyright (C) 2016 Brian Moore
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