## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotisogonicfield (@var{terzaguiPlotSTR}, @var{colormapStr}, , @var{viewProj})
##

## Plot data stored in a structure of the isogonic field of a borehole direction.

## @seealso{createisogoniocfield}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-20

function [ ] = plotisogonicfield (terzaguiPlotSTR, colormapStr, viewProj)

if nargin < 2
    colormapStr = 'jet';
    viewProj = 2;
elseif nargin < 3
    viewProj = 2;
endif

# Set the color map with 'colormapStr', which can be 'jet', 'hot', 'gray';
hold on
surf (terzaguiPlotSTR.x, terzaguiPlotSTR.y, terzaguiPlotSTR.z , ...
    'EdgeColor', 'None');
colormap (colormapStr);
%colorbar
view (viewProj);
axis ([-1, 1, -1, 1]);
axis equal
axis off

endfunction
