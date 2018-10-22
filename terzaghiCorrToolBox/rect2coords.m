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
## @deftypefn {} {@var{X}, @var{Y} =} rect2coords (@var{rectVec}, @var{wantplot})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-05

## Creates an X vector and a Y vector of the vertices of a rectangle given an 
## array (rectvec = [Xo, Yo, b, h]) that has the rectangular information ordered
## by the coordiante of the inferior left corner (xo, yo), its base distance (b)
## and its height (h).

## Example 1:
## The rectangle with its inferior-left-vertex coordiantes at origim, two units
## wide and one unit heigth has its vertex coordiantes
## [X, Y]  = rect2coords ([0, 0, 2, 1], true);
##   0   0
##   2   0
##   2   1
##   0   1
##   0   0
## The last coordinate is the same as the first one.
##
## Example 2:
## A rectangle is wanted to draw. The rectangle should have his left inferior
## vertix at (5, 8) and should be 4 wide and 2 tall.
## [X, Y]  = rect2coords ([5, 8, 4, 2], true);
##

function [X, Y] = rect2coords (rectVec, wantplot)

if nargin < 2
  wantplot = false;
endif

XYarray = zeros(5, 2);

XYarray(1,:) = rectVec(1:2);
XYarray(2,:) = [rectVec(1) + rectVec(3), rectVec(2)];
XYarray(3,:) = [rectVec(1) + rectVec(3), rectVec(2) + rectVec(4)];
XYarray(4,:) = [rectVec(1), rectVec(2) + rectVec(4)];
XYarray(5,:) = rectVec(1:2);

X = XYarray(:,1);
Y = XYarray(:,2);

if wantplot
    hold on
    plot(X, Y, 'bo-');
endif    
    
endfunction