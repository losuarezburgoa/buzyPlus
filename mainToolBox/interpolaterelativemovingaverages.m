function [finalDestineZmat, pixelSide, contourMatrix, contourHandle] = ...
    interpolaterelativemovingaverages(extendedAverageValuesGrid, ...
    contourIntervalPercentaje, smootProcessTimes, wantFilledCounts, colorMap)
##
## Description:
## Interpolates the moving average values into a dense grid with small pixels
## (i.e. area of each pixel is 0.005 times the area of the net).
## Then, it plots the countours.
%This fuction seems to be robust because the interpolation extends in a
%square region wider than a square circumscribing net, which avoids
%precission loss in the extremes of the net.
%Moreover, it has a proposal to smoot values when too noisy contours are
%generated.
%
%Input(s):
%The matrix having the locations of the points where the cicular window was
%located to count the number of poles. It is a nx4 matrix, where n is the
%number of locations, the frist column gives the polar-angle of the point
%in the projeted plane, the second column gives the polar-radius of the
%point, the third column gives the number of points encountered in each
%location and the fourth column the value in percentaje of the number of
%poles relative to the total number of poles (extendedAverageValuesGrid).
%This matrix is obtained with the 'createextendedaveragegrid' function.
%
%The contourn interval value (contourIntervalPercentaje).
%
%Number of times of smooth processes will be performed in this function
%(smootProcessTimes). It is used when the data produes to much noise. But
%normally 1 times is enough to get a good smotness. 
%
%Type of grid to be put within the countoring representation, may be
%'equalangle' or 'equalarea'. This value should be consistent with the
%processe used to generate the 'extendedAverageValuesGrid'. It means that
%of an equalarea projection was used in the 'createextendedaveragegrid',
%here it should be put the 'equalarea'.
%
%Output(s):
%Matrix of the interpolated values order as a values-image
%(finalDestineZmat). This variable may be used for a raster-image
%post-proessing.
%
%Length of the pixel side (pixelSide), used with the 'finalDestineZmat'
%variaable in order to scale properly the image.
%
%Matrix having the information of each drawn contourn (contourMatrix). It
%is a 2xm matrix. The first row epresses the x-cartesian coordinate and the
%second row the y-cartesian coordinate. Each contourn is divided by a
%column information, where in this column, the first row express the index
%and the second row the further numer of columns that defines that contourn.
%
%Handle of the contourn marix (contourHandle).
%
%Example:
%[ zMat ,pixelSide, C ,h ] = interpolaterelativemovingaverages ...
%      (extendedAverageValuesGrid, 1, 2, 'equalarea');

warning (["This function 'interpolaterelativemovingaverages' was deprecated, ", ...
    "use 'interpolrelmovavg' and 'plotdensitiyfromintetpolmovavg'!"]);

## Input management.
if nargin < 2
  contourIntervalPercentaje = 1;
  smootProcessTimes = 1;
  wantFilledCounts = true;
  colorMap = 'grayi';
elseif nargin < 3
  smootProcessTimes = 1;
  wantFilledCounts = true;
  colorMap = 'grayi';
elseif nargin < 4
  wantFilledCounts = true;
  colorMap = 'grayi';
elseif nargin < 5
  colorMap = 'grayi';
endif

%Radius of the reference shere = radius of the reference major great circle
sphereRadius = 1;
%Area of the interpolation pixel expressed in percentaje to the total major
%great circle area (pixelAreaInPercent)
pixelAreaInPercent = 0.005;

%Creating the blancking matrix
[blanckingGrid, pixelSide] = create_pixelgrid_any_homogeneus_value(1 , ...
    pixelAreaInPercent);
maxNumPixelsXY = size(blanckingGrid, 1);

%Factor that will scale the interpolation region.
scaleFactor = 1.2;

% Making bigger the initial blanckingGrid
adicionalRowsCols = floor((maxNumPixelsXY * (scaleFactor -1))) + 1;
scaledBlanckingGrid = [ ...
    NaN(maxNumPixelsXY, adicionalRowsCols), blanckingGrid, ...
    NaN(maxNumPixelsXY, adicionalRowsCols)];
scaledBlanckingGrid = [ ...
    NaN(adicionalRowsCols, maxNumPixelsXY + 2 * adicionalRowsCols); ...
    scaledBlanckingGrid;
    NaN(adicionalRowsCols, maxNumPixelsXY + 2 * adicionalRowsCols)];

%Creating the destine grid
radiusOffset = adicionalRowsCols * pixelSide;
scaledSphereRadius = sphereRadius + radiusOffset;
xyArray = linspace(-scaledSphereRadius, scaledSphereRadius, ...
    (maxNumPixelsXY + 2 *adicionalRowsCols));

[destineXMat, destineYMat] = meshgrid(xyArray);
destineYMat = flipud(destineYMat);

%Assigning the reference matrices
referenceXVec = extendedAverageValuesGrid(:,1);
referenceYVec = extendedAverageValuesGrid(:,2);
referenceZVec = extendedAverageValuesGrid(:,4);

%INTERPOLATION
%Methods can be: 'linear', 'cubic', 'nearest' or 'v4'
destineZMat = griddata(referenceXVec, referenceYVec, referenceZVec, ...
    destineXMat, destineYMat, 'linear');

%POST-PROCESSING
%Smooting ZMat values, propossed to smoot noisy values
smootedDestineZmat = destineZMat;
for i = 1 : smootProcessTimes
    %Convolution kernel F
    F = [0.05, 0.1, 0.05; 0.1, 0.4, 0.1; 0.05, 0.1, 0.05];
    smootedDestineZmat = conv2(smootedDestineZmat, F , 'same');
endfor

%Resampling ZMat values into categories
negativeIndexes = smootedDestineZmat < 0;
resampledDestineZMat = smootedDestineZmat;
resampledDestineZMat(negativeIndexes) = 0;

%Blancking the outside region
blanckedDestineXMat = destineXMat .* scaledBlanckingGrid;
blanckedDestineYMat = destineYMat .* scaledBlanckingGrid;
blanckedDestineZMat = resampledDestineZMat .* scaledBlanckingGrid;

%Final Zmat
finalDestineXmat = blanckedDestineXMat;
finalDestineYmat = blanckedDestineYMat;
finalDestineZmat = blanckedDestineZMat;

%CONTOURNS
%Number of countorns
maxValue = max(max(finalDestineZmat));
numberCountorns = floor(maxValue / contourIntervalPercentaje) + 1;
maxCountValue = numberCountorns * contourIntervalPercentaje;

%Monotonically increasing vector v for the contours lines
v = linspace(1, maxCountValue, numberCountorns);

%PLOTTING
if wantFilledCounts == true
    hold on
    drawfilledcontour(extendedAverageValuesGrid, contourIntervalPercentaje, ...
    '2Dfilled', colorMap);
endif

hold on
axis(scaledSphereRadius * [-1 ,1 ,-1 ,1], 'equal', 'off');

%Plotting the contourns
[contourMatrix, contourHandle] = contour (finalDestineXmat, finalDestineYmat, ...
    finalDestineZmat, v);
clabel(contourMatrix, contourHandle, 'LabelSpacing', 350, 'FontSize', 9, ...
    'Color', 'white', 'Rotation', 0);

endfunction

