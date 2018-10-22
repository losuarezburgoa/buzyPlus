function [preparedOrientationMat] = prepareorientationangles (orientationMat)

## Description:
## The input orientation matrix , may be trend-plunge or dipdirection-dip
## pairs, is prepared in order to accomplish azimuthal angles varying from 0
## to 360 and slope angles varying from 0 to 90.
## So, input data can have any real number, but those numbers have a specific
## meaning that reflects an orietantion exressed in the lower hemiphere
## stereograhical representation.

## Input(s):
## Matrix of n x 2 containing orientation data (orientationMat).

## Output(s):
## Matrix of n x 2 containing prepared orientation data (preparedOrientationMat).

## Note: The calculations were made for trend-plunge orientations, but is the
## same for dipdirection-dip orientations.

## Example1:
## The following orientation is in the upper hemisphere [125, -36], it should be
## [305, 36] the 'prepared orientation'.

## Example2:
## The following orientation is not reduced to 360 in the dipdirection sense
## [378, 56] the 'prepared orientation' should be [018, 56].

## Example3:
## This orientation has a plunge greater than 90, i.e. [178, 102],  but it 
## stills represent a direction in the lower hemisphere; the 'prepared 
## orientation' is [178+180, 180-102] = [358, 78].

## Example4:
## This orientatio is not correct represented but it still an orientation
## [-025, 32]; the  'prepared orientation' should be [360-25, 32] = [335, 32].
##

## The function can be improveed using modular algebra.

## Transforming into radians.
trendPlungeMatRad = orientationMat *pi /180;

for i=1 :size(trendPlungeMatRad ,1)
    ## Verifying the plunge angles.
    if trendPlungeMatRad(i ,2) >2 *pi
        trendPlungeMatRad(i ,2) =trendPlungeMatRad(i ,2) -floor(trendPlungeMatRad(i ,2) /2 /pi) *2 *pi;
        trendPlungeMat_1 =trendPlungeMatRad(i ,:) *180 /pi;
        trendPlungeMatRad(i, :) =prepareorientationangles( trendPlungeMat_1 ) *pi /180;
    else
        if trendPlungeMatRad(i ,2) >3 /2 *pi
            trendPlungeMatRad(i ,2) =2 *pi -trendPlungeMatRad(i ,2);
            trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) +pi;
        else
            if trendPlungeMatRad(i ,2) >pi
                trendPlungeMatRad(i ,2) =trendPlungeMatRad(i ,2) -pi;
            else
                if trendPlungeMatRad(i ,2) >pi/2
                    trendPlungeMatRad(i ,2) = pi -trendPlungeMatRad(i ,2);
                    trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) +pi;
                else
                    if trendPlungeMatRad(i ,2) < -2 *pi
                        trendPlungeMatRad(i ,2) =trendPlungeMatRad(i ,2) -floor(trendPlungeMatRad(i ,2) /2 /pi) *2 *pi;
                        trendPlungeMat_1 =trendPlungeMatRad(i, :) *180 /pi;
                        trendPlungeMatRad(i, :) =prepareorientationangles( trendPlungeMat_1 ) *pi /180;
                    else
                        if trendPlungeMatRad(i ,2) < -3 /2 *pi
                            trendPlungeMatRad(i ,2) = 2 *pi +trendPlungeMatRad(i ,2);
                        else
                            if trendPlungeMatRad(i ,2) < -pi
                                trendPlungeMatRad(i ,2) = -pi -trendPlungeMatRad(i ,2);
                                trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) +pi;
                            else
                                if trendPlungeMatRad(i ,2) < -pi /2
                                    trendPlungeMatRad(i ,2) = -pi /2 -trendPlungeMatRad(i ,2);
                                else
                                    if trendPlungeMatRad(i ,2) < 0
                                        trendPlungeMatRad(i ,2) = -trendPlungeMatRad(i ,2);
                                        trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) +pi;
                                    else
                                        trendPlungeMatRad(i ,2) =trendPlungeMatRad(i ,2);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    ## Verifying and preparing the trend angles.
    if trendPlungeMatRad(i ,1) >2 *pi
        trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) -floor(trendPlungeMatRad(i ,1) /2 /pi) *2 *pi;
    else
        if trendPlungeMatRad(i,1) <-2 *pi
            trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1) -floor(trendPlungeMatRad(i ,1) /2 /pi) *2 *pi;
            trendPlungeMat_2 =trendPlungeMatRad(i ,:) *180 /pi;
            trendPlungeMatRad(i ,:) =prepareorientationangles( trendPlungeMat_2 ) *pi /180;
        else
            if trendPlungeMatRad(i ,1) <0
                trendPlungeMatRad(i ,1) =2*pi +trendPlungeMatRad(i ,1) ;
            else
                trendPlungeMatRad(i ,1) =trendPlungeMatRad(i ,1);
            end
        end
    end
endfor

## Constructing the resulting orientation matrix and returning values to degrees.
preparedOrientationMat = trendPlungeMatRad / pi * 180;

endfunction

