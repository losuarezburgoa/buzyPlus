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
## @deftypefn {} {@var{textHandleCell} =} plottext (@var{textCoordArray}, 
## @var{textStringCell}, @var{projType}, @var{textRadialOffsetDeg})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-09

## In the spherical projection plots many times is necessary to plot text, but 
## located inside the the plotable area. The problem is that the figure coordiante
## system is cartesian and the region area is a transformation over the southerm
## hemisphere of the sphere.
## You can asing text based on the projection units.
##
## Input(s):
## An array of n times 2 of the locations of the texts you will put and specify
## in the cell of strings.
##
## A string cell of 1 times n with the strings that will be located in the position
## you specfied in the position array.
##
## String falgging the projection type.
## A real number that specifies how many units (degrees) the text will be 
## spaced from the location point.
##
## Output(s):
## A cell whith each plot hanfles of the text.
##
## Example 1.
## textCoordArray = [30, 45; 150, 45; 270, 45];
## textStringCell = {'H-1', 'H-2', 'H-3'};
## projType = 'equalarea';
## textRadialOffsetDeg = 3;
##

function [textHandleCell] = plottext (textCoordArray, textStringCell, ...
    projType, textRadialOffsetDeg)

## Input management.
if ischar(textStringCell)
    textStringCell = {textStringCell};
endif

if nargin < 4
    textRadialOffsetDeg = 3;
endif

## The function that will allows to use text in any n times 2 matrix.
numTexts = length(textStringCell);
textHandleCell = cell (size(textStringCell));
for k = 1 : numTexts
    txtStr = cell2mat(textStringCell(k));
    T = plttxt (textCoordArray(k,:), txtStr, projType, textRadialOffsetDeg);
    textHandleCell{k} = T;
endfor
endfunction

function [T] = plttxt (textCoordVec, textString, projType, textRadialOffsetDeg)
    
## textCoordVec = textCoordArray(k,:);
## textString = textStringCell{k};

## Given an offset away from the point text.
textCoordVec = [textCoordVec(1), textCoordVec(2) - textRadialOffsetDeg];

## Transforming to the plane system.
switch projType
    case 'equalangle'
       ppolarVec = equalanglepolar2planepolar (textCoordVec);
    case 'equalarea'
       ppolarVec = equalareapolar2planepolar (textCoordVec);
    otherwise
       error('Bad string for the projection type!');
endswitch

## Obtaining the polar coordiantes.
trendRad = ppolarVec(1);
plungeRho = ppolarVec(2);

## Definig aligment.
if and (trendRad >= 0, trendRad < pi)
    horzAlignStr = 'left';
elseif and(trendRad >= pi, trendRad <= 2*pi)
    horzAlignStr = 'right';
endif

## Obtaining the cartesian coordinates.
[x, y] = nepol2cart(trendRad, plungeRho);

## Plotting the text.
hold on
T = text (x, y, textString, 'HorizontalAlignment', horzAlignStr, ...
    'VerticalAlignment', 'middle');

endfunction