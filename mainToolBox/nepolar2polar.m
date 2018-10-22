function [polarAngleRad] = nepolar2polar (nePolarAngleRad)

## Description:
## Transforms a radian angle that is measured at the north-east system from
## the north-axis and clockwise sense to that measured from the x-axis and
## counterclockwise sense at a cartesian system. 
##
## Input(s):
## Clockwise angle in radians from the north axis (nePolarAngleRad)
##
## Output(s):
## Counterclockwise angle in radians from the x-axis (polarAngleRad).
##

polarAngleRad = zeros(1, length(nePolarAngleRad));

for i = 1 : length(nePolarAngleRad);
    if nePolarAngleRad(i) <= pi / 2
        polarAngleRad(i) = pi / 2 - nePolarAngleRad(i);
    else
        polarAngleRad(i) = 2 * pi + pi / 2 - nePolarAngleRad(i);
    endif
endfor

endfunction

