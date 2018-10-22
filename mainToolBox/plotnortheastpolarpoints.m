function [x, y] = plotnortheastpolarpoints (polarMatrix, displaySquareSide, ...
    varargin)  
#
# Description:
# Plots 2D points expressed in polar coordinates at the North-East
# system (NE system: x-axis points to the north, y-axis points to the
# east).
#
# Input(s):
# Matrix of similar entities containing in each consecutive pair of columns, the
# polar data of each entity (polarMatrix). The first column of each pair has the angular 
# polar coordinates and the second column of the pair has the radial coordinate. 
# The matrix has a dimension of (number of points of each similar entity x 2
# *number of entities).
#
# The side of the display square, with center in the origin (displaySquareSide).
#
# Options of the plot, which controls the type, color of the line,etc. This
# variable is a string variable, so it must be between '' (varargin).
#

## Input management.
if nargin < 2
    displaySquareSide = 2;
endif

## Plotting.
polarMatrixSize = size(polarMatrix);

hold on;
axis (displaySquareSide / 2 * [-1 ,1 ,-1 ,1], 'equal', 'off');

for i = 1 : (polarMatrixSize(2) / 2)
    x = polarMatrix(:, 2*i) .* sin(polarMatrix(:, 2*i -1));
    y = polarMatrix(:, 2*i) .* cos(polarMatrix(:, 2*i -1));

    if nargin < 3
        #plot( x, y,'ok-', 'LineWidth', 1, 'MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'w');
        plot(x, y, 'k-', 'LineWidth', 1);
    else
        parserObj = inputParser;
        parserObj.KeepUnmatched = true;
        parserObj.addOptional('LineSpec', '-', @(x) ischar(x) && (numel(x) <= 4));
        parserObj.parse(varargin{:});
        # your inputs are in Results
        myArguments = parserObj.Results;
        # plot's arguments are unmatched
        plotArgs = struct2pv (parserObj.Unmatched);
        plot(x, y, myArguments.LineSpec, plotArgs{:});
    endif
endfor
endfunction


function [pv_list, pv_array] = struct2pv (s)
    p = fieldnames(s);
    v = struct2cell(s);
    pv_array = [p, v];
    pv_list = reshape (pv_array', [],1)';
endfunction
