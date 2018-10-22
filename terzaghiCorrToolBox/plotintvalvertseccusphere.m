## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotintvalvertseccusphere (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-18

## Plot interval in the vertical section of the unit sphere.


## plotintvalvertseccusphere ([90, 40; 90, 60]);
## plotintvalvertseccusphere ([270, 0; 90, 0]);

## plotintvalvertseccusphere ([270, 10; 270, 0]);
## intValArray = [270, 10; 270, 0];
## patchColor = 'c';

## plotintvalvertseccusphere ([90, 0; 90, 20]);
## intValArray = [90, 0; 90, 20];
## patchColor = 'c';

function [ ] = plotintvalvertseccusphere (intValArray, patchColor)

if nargin < 2
    patchColor = 'c';
endif

hold on
thetaArray = zeros(1,2);
for k = 1 : 1 : 2
    plotpointvertseccusphere (intValArray(k, :));
    [x, y] = trendplunge2xyvertsecc (intValArray(k, :));
    [theta, ~] = cart2pol (x, y);
    thetaArray(k) = theta;
endfor

if thetaArray(2) > thetaArray(1)
    idxs = thetaArray < 0;
    thetaArray(idxs) = 2*pi + thetaArray(idxs);
endif

h = arcpatch (0, 0, 1, rad2deg(thetaArray), 1);
set(h, 'facecolor', 'c', 'edgecolor', patchColor);
axis equal

endfunction
