## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} trendplunge2xyvertsecc (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-18

function [x, y] = trendplunge2xyvertsecc (trdplgArray)
    
trd = trdplgArray(1);
if and(trd ~= 90, trd ~= 270)
    error('Trend must be only 90 or 270!');
endif

plg = trdplgArray(2);

if trd == 90
    alpha = 0 - deg2rad(plg);
elseif trd == 270
    alpha = pi + deg2rad(plg);
endif
[x, y] = pol2cart (alpha, 1);

endfunction
