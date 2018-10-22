## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotclusterwindowpart (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-24

function [] = plotclusterwindowpart (winArray, varargin)

hold on
%Ploting the window
%Graphic constants and options
sphRadius = 1;
cenVec = zeros(1 ,2);
%Transforming the nodes matrix from polar to north-east polar 
toPlotMat01 = winArray;
toPlotMat01(: ,1) = polar2nepolar( winArray(: ,1) );
## Now ploting
[x1, y1] = pol2cart(toPlotMat01);
plot (x1, y1, varargin{:});
## Adjusting the axes
axis ([cenVec(1)-sphRadius, cenVec(1)+sphRadius, cenVec(2)-sphRadius, ...
    cenVec(2)+sphRadius],'square');

endfunction
