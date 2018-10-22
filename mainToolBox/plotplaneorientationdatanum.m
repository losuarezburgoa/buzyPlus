function [ ] =plotplaneorientationdatanum( trendPlungeMat, numberMat, ...
    projectionType, pointGraphicalOptions, textColorString, want2plotgridTrue )
%%%%%%%%%%%%%%
% plotplaneorientationdatanum( trendPlungeMat, numberMat, projectionType, ...
%    pointGraphicalOptions, textColorString, want2plotgridTrue )
%%%%%%%%%%%%%%
%
%Description:
% Plots the planes orientation data given by the trend and plunge of
% their respective poles in a estereographic projection or in a equiarea
% projection. In each point, a number is given.
%
%Nested functions:
% createpolargrid, plotnortheastpolarnumbers, equalanglepolar2planepolar,
% equalareapolar2planepolar.
%
%Input(s):
% Orientation data given in a matrix of nx2 size, where the first column
% has the pole trend angle and second column the plunge, boths in
% hexadesimal angular grades (trendPlungeMat). 
%
% Matrix having the number that will be put near the point. In the case is
% an empty matrix, then the numbers are consecutive according to the number
% of input data (numberMat). 
%
% Detailed string (projectionType) to specify on which projetion type is
% wanted to display the pole, on a equal-angle ('equalaNgle') or equal-area
% ('equalaRea') projection.
%
% Detailed grahical options (pointGraphicalOptions) of the points in a
% string chain (e.g. 'ko', which gives circular ponts in black color). 
%
% Logical option if it is wanted to plot the grid background
% (want2plotgridTrue).
%
% Output(s);
% The graphical representation in a figure window.
%
%Example1:
% trendPlungeMat =[ 156 ,65 ;171 ,60 ;334 ,15 ;334 ,15 ;319 ,26 ;156 ,65...
% ;321 ,38 ;199 ,16 ;143 ,63 ;327 ,19 ;296 ,22 ;329 ,15 ;198 ,3 ;287 ,21...
% ;171 ,60 ];
% numberMat =transpose(1:1:15);
% projectionType ='equalarea';
% pointGraphicalOptions ='kx';
% textColorString ='b';
% want2plotgridTrue =true;
%
%%%%%%%%%%%%%%
% plotplaneorientationdatanum( trendPlungeMat, numberMat, projectionType, ...
%    pointGraphicalOptions, textColorString, want2plotgridTrue )
%%%%%%%%%%%%%%

%% Initial constants
prinTrendStepsGrad= 10;
prinPlungeStepsGrad = 10;
noSecondScalePlungeGrad =85;
noSecondScaleTrendGrad =85;
plotSecondScale= 'false';

%% Number of data
matrixSize =size(trendPlungeMat);

%% Checking the numberMat
if isempty(numberMat)
    numberMat =transpose(1:1:matrixSize(1));
elseif size(numberMat, 1) ~= matrixSize(1)
    % warning('The matrix of number is not equal to the number of inputa data');
    numberMat =transpose(1:1:matrixSize(1));
end

%% Creating the NE polar matrix
polarMatrix =zeros(matrixSize(1) ,2);
% Filling the polar matrix
switch projectionType 
    case {'N','equalaNgle', 'equalangle'}
           %Calling the function to create the background grid
           if want2plotgridTrue
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
           if want2plotgridTrue
               createpolargrid('equalarea' ,prinTrendStepsGrad,...
               prinPlungeStepsGrad, noSecondScalePlungeGrad ,...
               noSecondScaleTrendGrad ,plotSecondScale);
           end
        for i=1:matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           %[polarMatrix(i,1), polarMatrix(i,2)] = ...
           polMat = ...
           equalareapolar2planepolar ([trendPlungeMat(i,1), ...
               trendPlungeMat(i,2)]);
           polarMatrix(i,1) = polMat(1);
           polarMatrix(i,2) = polMat(2);
        end
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
end
%% Plot polar matrix
hold on
plotnortheastpolarpoints( polarMatrix, 2, pointGraphicalOptions);
plotnortheastpolarnumbers( polarMatrix, numberMat, 2, textColorString )
end
