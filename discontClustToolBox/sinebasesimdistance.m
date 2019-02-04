function [sineBaseDist] = sinebasesimdistance (vec1, vec2)
## -*- texinfo -*- 
## @deftypefn {} {@var{sineBaseDist} =} sinebasesimdistance (@var{vec1}, @var{vec2})
##
## Calculates the sine-based similarity distance between two points, 
## prepresented by two (3x1) vectors.
## The @dfn{sine-based similarity measure distance} is defined by 
## d = 1 - (v_1 \cdot v_2)^2.
##
## This distance is a one that is used as measure for the fuzzy K-means 
## algorithm. For more details see Hammah & Curran (1999).
##
## Reference(s):
## R.E. Hammah and J.H. Curran , 1999. On distance measures for the fuzzy 
## K-means algoritm for joint data. Rock Mechanics and Rock Engineering, 
## Vol.32(1): 1-27. @uref{https://doi.org/10.1007/s006030050041}
##
## @seealso{spectralclustering}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa @email{losuarezb@unal.edu.co}
## Created: 2018-05-29

sineBaseDist = 1 - (dot(vec1', vec2))^2;
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
