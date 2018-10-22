## Copyright (C) 2018 Ludger O. Suarez-Burgoa


## -*- texinfo -*- 
## @deftypefn {} {@var{trdGral} =} interval2meanaxisconeangle (@var{intValArray})
##
## @seealso{}
## @end deftypefn

## Given the (trd, plg) of the inferior and superior interval (in a vertical plane)
## Find the mean direction (trdGral, plgGRal) and the interval angle (coneAngleDeg).

## Examples 1:
## For ...
## intvalSense = 'clockwise';
## intvalSense = 'counterclockwise';
## intValArray = [270, 10; 090, 70];
## intValArray = [270, 60; 090, 20];
## intValArray = [090, 20; 270, 70];
## intValArray = [090, 70; 270, 10];
## intValArray = [270, 60; 270, 10];
## intValArray = [270, 10; 270, 60];
## intValArray = [090, 60; 090, 20];
## intValArray = [090, 30; 090, 70];
## intValArray = [090, 90; 090, 90];
## intValArray = [270, 90; 270, 90];
## intValArray = [270, 60; 270, 60];

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-22

function [trdGral, plgGral, coneAngleDeg] = interval2meanaxisconeangle ...
    (intValArray, intValSense)

## Input management.
if nargin < 2
    intvalSense = 'clockwise';
endif

# Assuming all the trends and plunges are possitive.
intValArray = prepareorientationangles (intValArray);

# Inferior limits.
trdi = intValArray(1, 1);
plgi = intValArray(1, 2);

# Superior limits.
trdf = intValArray(2, 1);
plgf = intValArray(2, 2);

## Calculating the mean direction from two interval extremes and the angle (trdGral).
# It is similar to calculate the direction of the cone axis and the generatriz
# angle.

if trdi == trdf
    # the trends are equal
    if trdi == 90 % trdi == trdf == 90
        ## The interval angles increment from east to west in a
        ## pitch angle from the positive strike, when the plane is vertical
        ## striking to que East.
        
        # The initial trend is at East.
        if plgi < plgf
            # But the interval is the acute angle.
            trdGral = trdi;
            plgGral = 1/2 * (plgf + plgi + 0);
            coneAngleDeg = 1/2 * (0 - plgi + plgf);
        elseif plgi > plgf
            # But the interval is the obtuse angle.
            trdGral = trdi + 180;
            plgGral = 1/2 * (-plgf - plgi + 180);
            coneAngleDeg = 1/2 * (180 - plgi + plgf);
        else %plgi == plgf == 90
            trdGral = trdi;
            plgGral = plgi;
            coneAngleDeg = 0;
            break
        endif    
    else % trdi == trf ~= 90, i.e. trdi == trdf == 270
        # The initial trend is at West.
        if plgi < plgf
            # But the interval is the obtuse angle.
            trdGral = trdi - 180;
            plgGral = 1/2 * (-plgf - plgi + 180);
            coneAngleDeg = 1/2 * (180 + plgi -plgf);
        elseif plgi > plgf
            # But the interval is the acute angle.
            trdGral = trdi;
            plgGral = 1/2 * (plgf + plgi + 0);
            coneAngleDeg = 1/2 * (0 + plgi -plgf);
        else %plgi == plgf == 270
            trdGral = trdi;
            plgGral = plgi;
            coneAngleDeg = 0;
            break
        endif
    endif
else % trdi ~= trdf
    # the trends are different
    if trdi == 90
        if plgi >= plgf
            trdGral = trdi + 180;
            plgGral = 1/2 * (plgf - plgi + 180);
            coneAngleDeg = 1/2 * (180 - plgi - plgf);
        else % plgi < plgf
            trdGral = trdi;
            plgGral = 1/2 * (-plgf + plgi + 180);
            coneAngleDeg = 1/2 * (180 - plgi - plgf);
        endif
    else % tri == 270
        if plgi >= plgf
            trdGral = trdi;
            plgGral = 1/2 * (-plgf + plgi);
            coneAngleDeg = 1/2 * (0 + plgi + plgf);
        else % plgi > plgf
            trdGral = mod(trdi + 180, 180);
            plgGral = 1/2 * (plgf - plgi);
            coneAngleDeg = 1/2 * (0 + plgi + plgf);
        endif
    endif
endif

## Reinverting trend in case of 'counterclockwise' interval sense.
switch intValSense
    case 'clockwise'
        % normal case
        # pass
    case 'counterclockwise'
        % inverse case
        trdGral = mod(trdGral + 180, 360);
        plgGral = 90 - plgGral;
        coneAngleDeg = 1/2 * (180 - 2 * coneAngleDeg);
    otherwise
        error ("Bad string for the interval sense, could be 'clockwise' or 'counterclockwise'");
endswitch

endfunction
