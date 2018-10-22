## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotverticalseccunitsphere (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-17

## Plot a point in a vertical section of the unit sphere.

function [] = plotpointvertseccusphere (trdPlgArray, wantplotframe, idStr)

if nargin < 2
    wantplotframe = false;
    idStr = '1';
elseif nargin < 3
    idStr = '1';
endif

trd = trdPlgArray(1);
plg = trdPlgArray(2);

## Ploting in the unit circle in a vertical view.
# Distance of the text from point.
dyT = 0.04;
dxT = 0.02;

hold on
# The point.
[x, y] = trendplunge2xyvertsecc ([trd, plg]);

# Plotting.
# ... the point,
plot (x, y, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
# ... the text,
text (x+dxT, y+dyT, sprintf('%s : (%d / %d)', idStr, trd, plg));
# ... the line from center to point,
plot([0, x], [0, y], 'k-');
# .. the frae (if wanted).
if wantplotframe
    plotframevertseccusphere (1);
endif

endfunction
