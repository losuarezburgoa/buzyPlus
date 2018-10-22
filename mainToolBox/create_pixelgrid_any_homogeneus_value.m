function [ pixelsGrid ,pixelSide ,evaluatedPixelAreaInPercent ]...
   =create_pixelgrid_any_homogeneus_value( value ,pixelAreaInPercent )
%lsb code
% [ pixelsGrid ,pixelSide ,evaluatedCountCircAreaInPercent ]...
%    create_pixelgrid_any_homogeneus_value( value
%    ,countingCircleAreaInPercent )
%
%Description:
%Creates a raster pixel grid with a determined constant value in all their
%elements having pixels equal to a certain percentage of the total area of
%the great circle of the projection.
%
%Input(s):
%Desired numeric value of all elements of the grid (value). If in this
%option a string of 'rand' is set, the function will generate a pixel grid
%with randow values in each of their elements. 
%
%Area of each pixel in percentaje of the total area of the great circle
%(pixelAreaInPercent)
%
%Output(s):
%Square matrix with real values defining the great circle region and 'not a
%number' (NaN) values defining the region that is not part of the great
%circle.
%
%The side of the pixel relative to the great circle radius (pixelSide)
%
%The evaluated area of each pixel, in percentaje of the total area of the
%great circle (evaluatedPixelAreaInPercent). This value is not always the
%same as the input value because pixel side should accomplish entire
%requirements, but is the closest to that defined initialy. 
%%%%%%%%%%%%%%%%%%%%%%%
% [ pixelsGrid ,pixelSide ,evaluatedCountCircAreaInPercent ]...
%    create_pixelgrid_any_homogeneus_value( value
%    ,countingCircleAreaInPercent )

sphereRadius =1;
globalArea =pi *(sphereRadius)^2;
pixelArea =pixelAreaInPercent /100 *globalArea;
initialPixelSide =sqrt( pixelArea );

%Re-evaluating the couting circle area
maxNumPixelsXY =round( sphereRadius /initialPixelSide );
pixelSide =sphereRadius /maxNumPixelsXY;

evaluatedPixelAreaInPercent =(pi *pixelSide^2) /globalArea *100;

%CREATING THE COUNTING GRID
%Creating the counting grid (the right-down quadrant)
yArray =linspace( 0 ,sphereRadius ,maxNumPixelsXY +1 );
xArray =sqrt( sphereRadius.^2 -yArray.^2 );

numPixelsXY =floor(xArray(2:end) /pixelSide) +1;

rightDownPixelsGrid =zeros( max(numPixelsXY) );
for i=1 :size(rightDownPixelsGrid ,2)
    rightDownPixelsGrid( i ,1 :numPixelsXY(i) ) =1;
end
for j=1 :size(rightDownPixelsGrid ,1)
    rightDownPixelsGrid( 1 :numPixelsXY(j), j ) =1;
end
indexes =rightDownPixelsGrid ==0 ;
rightDownPixelsGrid(indexes) =NaN;

%Mirroring the other quadrants
rightUpPixelsGrid  =flipud( rightDownPixelsGrid );
leftUpPixelsGrid  =fliplr( rightUpPixelsGrid );
leftDownPixelsGrid =fliplr( rightDownPixelsGrid );

pixelsGrid =[ [leftUpPixelsGrid ,rightUpPixelsGrid]; [leftDownPixelsGrid ,rightDownPixelsGrid] ];

if strcmp(value, 'rand')
    %to create a pixelgrid with random elements do
    a =rand( length(pixelsGrid) );
    pixelsGrid =a .* pixelsGrid;
else
    %to create a pixelgrid with homogeneus value do
    pixelsGrid =value *pixelsGrid;
end

%To export the image to an bmp file
%imwrite(pixelsGrid, 'pixelgrid.bmp', 'bmp')

end

