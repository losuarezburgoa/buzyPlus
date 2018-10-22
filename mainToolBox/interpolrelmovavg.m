function [finalDestineXmat, finalDestineYmat, finalDestineZmat, pixelSide, ...
    destineXMat, destineYMat] = ...
    interpolrelmovavg (extendedAverageValuesGrid, smootProcessTimes, wantplot)
##
## Description:
## Interpolates the moving average values into a dense grid with small pixels
## (i.e. area of each pixel is 0.005 times the area of the net).
## Then, it plots the countours.
## This fuction seems to be robust because the interpolation extends in a
## square region wider than a square circumscribing net, which avoids
## precission loss in the extremes of the net.
## Moreover, it has a proposal to smoot values when too noisy contours are
## generated.
## 
## Input(s):
## The matrix having the locations of the points where the cicular window was
## located to count the number of poles. It is a nx4 matrix, where n is the
## number of locations, the frist column gives the polar-angle of the point
## in the projeted plane, the second column gives the polar-radius of the
## point, the third column gives the number of points encountered in each
## location and the fourth column the value in percentaje of the number of
## poles relative to the total number of poles (extendedAverageValuesGrid).
## This matrix is obtained with the 'createextendedaveragegrid' function.

## Number of times of smooth processes will be performed in this function
## (smootProcessTimes). It is used when the data produes to much noise. But
## normally 1 times is enough to get a good smotness. 

## Output(s):
## Matrix of the interpolated values order as a values-image
## (finalDestineZmat). This variable may be used for a raster-image
## post-proessing.
## 
## Length of the pixel side (pixelSide), used with the 'finalDestineZmat'
## variaable in order to scale properly the image.

## Input management.
if nargin < 2
  smootProcessTimes = 1;
  wantplot = false;
elseif nargin < 3
  wantplot = false;
endif

## Radius of the reference shere = radius of the reference major great circle
sphereRadius = 1;
## Area of the interpolation pixel expressed in percentaje to the total major
## great circle area (pixelAreaInPercent)
pixelAreaInPercent = 0.005;

## Creating the blancking matrix
[blanckingGrid, pixelSide] = create_pixelgrid_any_homogeneus_value(1 , ...
    pixelAreaInPercent);
maxNumPixelsXY = size(blanckingGrid, 1);

## Factor that will scale the interpolation region.
scaleFactor = 1.2;

##  Making bigger the initial blanckingGrid
adicionalRowsCols = floor((maxNumPixelsXY * (scaleFactor -1))) + 1;
scaledBlanckingGrid = [ ...
    NaN(maxNumPixelsXY, adicionalRowsCols), blanckingGrid, ...
    NaN(maxNumPixelsXY, adicionalRowsCols)];
scaledBlanckingGrid = [ ...
    NaN(adicionalRowsCols, maxNumPixelsXY + 2 * adicionalRowsCols); ...
    scaledBlanckingGrid;
    NaN(adicionalRowsCols, maxNumPixelsXY + 2 * adicionalRowsCols)];

## Creating the destine grid
radiusOffset = adicionalRowsCols * pixelSide;
scaledSphereRadius = sphereRadius + radiusOffset;
xyArray = linspace(-scaledSphereRadius, scaledSphereRadius, ...
    (maxNumPixelsXY + 2 *adicionalRowsCols));

[destineXMat, destineYMat] = meshgrid(xyArray);
destineYMat = flipud(destineYMat);

## Assigning the reference matrices
referenceXVec = extendedAverageValuesGrid(:,1);
referenceYVec = extendedAverageValuesGrid(:,2);
referenceZVec = extendedAverageValuesGrid(:,4);

## INTERPOLATION
## Methods can be: 'linear', 'cubic', 'nearest' or 'v4'
destineZMat = griddata(referenceXVec, referenceYVec, referenceZVec, ...
    destineXMat, destineYMat, 'linear');

## POST-PROCESSING
## Smooting ZMat values, propossed to smoot noisy values
smootedDestineZmat = destineZMat;
for i = 1 : smootProcessTimes
    ## Convolution kernel F
    F = [0.05, 0.1, 0.05; 0.1, 0.4, 0.1; 0.05, 0.1, 0.05];
    smootedDestineZmat = conv2(smootedDestineZmat, F , 'same');
endfor

## Resampling ZMat values into categories
negativeIndexes = smootedDestineZmat < 0;
resampledDestineZMat = smootedDestineZmat;
resampledDestineZMat(negativeIndexes) = 0;

## Blancking the outside region
blanckedDestineXMat = destineXMat .* scaledBlanckingGrid;
blanckedDestineYMat = destineYMat .* scaledBlanckingGrid;
blanckedDestineZMat = resampledDestineZMat .* scaledBlanckingGrid;

## Final Zmat
finalDestineXmat = blanckedDestineXMat;
finalDestineYmat = blanckedDestineYMat;
finalDestineZmat = blanckedDestineZMat;

if wantplot
    hold on
    axis(scaledSphereRadius * [-1 ,1 ,-1 ,1], 'equal', 'off');
    s = surf (finalDestineXmat, finalDestineYmat, finalDestineZmat);
    set(s, 'EdgeColor', 'none');
endif

endfunction

