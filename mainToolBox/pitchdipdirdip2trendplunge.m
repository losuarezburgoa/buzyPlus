function [trendGrad, plungeGrad] = pitchdipdirdip2trendplunge (pitchGrad, ...
    dipDirDipVec)

## Description:
## Transforms the information of the orientation of a line given by the pitch
## angle in a determined plane (whose information is given by the
## dip-direction and dip) to the trend and plunge format.
## 
## Additional note:
## Even tough the concept of pitch establishes that it varies from 0 to 90
## grades, here it is assumed that it varies from 0 to 180, by maintaining
## one single strike of the plane (i.e. the positive strike), which is the 
## dip-direction angle minus 90 ## grades; and that is accomplished the rigth 
## hand rule.
## 
## Aplicability:
## This function may be used from a common problem, which is to obtain the
## spatial orientation of a line that belongs to a determined plane and where
## the pitch as also the plane orientation are known.
## Also may be used to obtain the stereographical projection of the trace
## line of the intersection of a plane with the unit sphere (i.e. to obtain
## the cyclographic trace or also called the creat circle) and the small
## circle.
## 
## Nested function(s):
## dipdirdip2pole, trendplunge2unitvect, findvectnormal2ref,
## reduceminimal180angle, unitvect2trendplunge, prepareorientationangles
## 
## Input(s):
## Pitch angle in hexagesimal angular grades (pitch).
## Dip-direction and Dip vector in hexagesimal angular grades (dipDirDipVec).
## 
## Output(s):
## Trend in hexagesimal angular grades
## Plunge in hexagesimal angular grades
#
## Example1:
## pitchGrad = 4;
## dipDirDipVec = [90, 90];
##
## Example2:
## pitchGrad = 0;
## dipDirDipVec = [90, 0];
##
## Example 3.
## pitchGrad = 0
## dipDirDipVec = [270, 45]
##

## Case where the dip is 90, the trend will depend on the pitch.
if dipDirDipVec(2) == 90
    if pitchGrad < 90
        trendGrad = mod(dipDirDipVec(1) - 90, 360);
        plungeGrad = pitchGrad;
        return
    elseif pitchGrad == 90
        trendGrad = 0;
        plungeGrad = 90;
        return
    elseif pitchGrad > 90
        trendGrad = mod(dipDirDipVec(1) + 90, 360);
        plungeGrad = pitchGrad;
        return
    endif
elseif dipDirDipVec(2) == 0
    trendGrad = pitchGrad;
    plungeGrad = 0;
    return
endif

%errorVal = 10^(-12);
%if abs(dipDirDipVec(2) - 0) < errorVal && dipDirDipVec(1) == 90
%  trendGrad = pitchGrad;
%  plungeGrad = 0;
%  return
%elseif abs(dipDirDipVec(2) - 0) < errorVal && dipDirDipVec(1) == 270
%  trendGrad = pitchGrad + 180;
%  plungeGrad = 0;
%  return
%endif

## Case where the pitch is 0 or 180.
if pitchGrad == 0
    trendGrad = mod(dipDirDipVec(1) - 90, 360);
    plungeGrad = 0;
    return
elseif pitchGrad == 180
    trendGrad = mod(dipDirDipVec(1) + 90, 360);
    plungeGrad = 0;
    return
endif

pitchGrad = mod(pitchGrad, 180);

## Calculating the pole of the plane
tRendPlungeVecGrads = dipdirdip2pole (dipDirDipVec);

## Calculating the unit vector of that direction
oRientUnitVector = trendplunge2unitvect (tRendPlungeVecGrads);

## Obtaining the in-plane line that is pitched
inPlaneLineUnitVec = findvectnormal2ref (oRientUnitVector, -pitchGrad);

## Transforming the unit vector information to trend-plunge information
pitchTrendPlungeVec = unitvect2trendplunge (inPlaneLineUnitVec);
pitchTrendPlungeVec = prepareorientationangles (pitchTrendPlungeVec);

trendGrad = pitchTrendPlungeVec(1);
plungeGrad = pitchTrendPlungeVec(2);

endfunction