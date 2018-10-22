function [ ] =plotpolefilledregion( trendPlungeMat, ...
    projectionType, pointGraphicalOptions, want2plotgrid )
%lsb code
%plotplaneorientationdata( trendPlungeMat, ...
%    projectionType, pointGraphicalOptions, want2plotgrid )
%Description:
%Plots the planes orientation data given by the trend and plunge of
%their respective poles in a estereographic pole representation, equiangle 
%or aquiarea.
%
%Nested functions:
%plotnortheastpolarfilledregions
%External functions:
%createpolargrid, plotnortheastpolarpoints,
%equalanglepolar2planepolar, equalareapolar2planepolar
%
%Input(s):
%Orientation data given in a matrix of nx2 size, where the first column has
%the pole trend angle and second column the plunge, boths in hexadesimal 
%angular grades (trendPlungeMat). 
%
%Detailed string (projectionType) to specify on which projetion type is
%wanted to display the pole, on a equal-angle ('equalaNgle') or equal-area
%('equalaRea') projection.
%
%Detailed grahical options (pointGraphicalOptions) of the points in a
%string chain (e.g. 'ko', which gives circular ponts in black color). 
%
%Logical option if it is wanted to plot the grid background
%(want2plotgrid).
%
%Output(s);
%The graphical representation in a figure window.
%
%Example:
%Plot the following planes given in the matix (exapleMat):
%exampleMat =[ 156 ,65 ;171 ,60 ;334 ,15 ;334 ,15 ;319 ,26 ;156 ,65...
%;321 ,38 ;199 ,16 ;143 ,63 ;327 ,19 ;296 ,22 ;329 ,15 ;198 ,3 ;287 ,21...
%;171 ,60 ]
%plotplaneorientationdata( exampleMat, 'equalarea', 'kx');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%¨%%%%%%%%%%%%
%plotplaneorientationdata( trendPlungeMat, ...
%    projectionType, pointGraphicalOptions, want2plotgrid )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initial constants
prinTrendStepsGrad= 10;
prinPlungeStepsGrad = 10;
noSecondScalePlungeGrad =85;
noSecondScaleTrendGrad =85;
plotSecondScale= 'false';

%Number of data
matrixSize =size(trendPlungeMat);

%Creating the NE polar matrix
polarMatrix =zeros(matrixSize(1) ,2);
%Filling the polar matrix
switch projectionType 
    case {'N','equalaNgle', 'equalangle'}
           %Calling the function to create the background grid
           if want2plotgrid ==true
               createpolargrid('equalangle' ,prinTrendStepsGrad,...
               prinPlungeStepsGrad, noSecondScalePlungeGrad ,...
               noSecondScaleTrendGrad ,plotSecondScale);
           end
        for i=1:matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           [polarMatrix(i,1) ,polarMatrix(i,2)] =...
               equalanglepolar2planepolar( [trendPlungeMat(i,1)...
                ,trendPlungeMat(i,2)] );
        end
    case {'R','equalaRea', 'equalarea'} 
           %Calling the function to create the background grid
           if want2plotgrid ==true
               createpolargrid('equalarea' ,prinTrendStepsGrad,...
               prinPlungeStepsGrad, noSecondScalePlungeGrad ,...
               noSecondScaleTrendGrad ,plotSecondScale);
           end
        for i=1:matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           [polarMatrix(i,1) ,polarMatrix(i,2)] =...
               equalareapolar2planepolar( [trendPlungeMat(i,1)...
               ,trendPlungeMat(i,2)] );
        end
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
end
%Plot polar matrix
plotnortheastpolarfilledregions( polarMatrix, 2, pointGraphicalOptions);   
end

function [  ] = plotnortheastpolarfilledregions( polarMatrix, displaySquareSide, ...
    displayOptions )  
%Description:
%Plots 2D points expressed in polar coordinates at the North-East
%system (NE system: x-axis points to the north, y-axis points to the
%east).
%Input(s):
%Matrix of similar entities containing in each consecutive pair of columns, the
%polar data of each entity (polarMatrix). The first column of each pair has the angular 
%polar coordinates and the second column of the pair has the radial coordinate. 
%The matrix has a dimension of (number of points of each similar entity x 2
%*number of entities).
%The side of the display square, with center in the origin (displaySquareSide).
%Options of the plot, which controls the type, color of the line,etc. This
%variable is a string variable, so it must be between '' (displayOptions).

polarMatrixSize =size(polarMatrix);
hold on;
axis (displaySquareSide /2 *[-1 ,1 ,-1 ,1], 'equal', 'off');
for i=1 :(polarMatrixSize(2) /2)
    fill( polarMatrix(:,2*i) .*sin(polarMatrix(:,2*i -1)) ,...
            polarMatrix(:,2*i) .*cos(polarMatrix(:,2*i -1)) ,displayOptions );
end
%hold off;
end

