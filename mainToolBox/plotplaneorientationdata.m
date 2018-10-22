function [plotHandle] = plotplaneorientationdata (trendPlungeArray, ...
    projectionType, plotSymbol, want2plotgrid, symbolSize, symbolFaceColor, ...
    symbolEdgeColor, gridColsSTR, plotSecondScale)
% 
% Description:
% Plots the planes orientation data given by the trend and plunge of
% their respective poles in a spherical pole representation, equiangle 
% or aquiarea. With the actual function one can change the symbol size, the
% symbol face and adge color.
%
% External sub-function(s):
% createpolargrid, equalanglepolar2planepolar, equalareapolar2planepolar.
%
% Input(s):
% Orientation data given in a matrix of n x 2 size, where the first column
% has the pole trend-angle, and second column the plunge-angle; boths in 
% angular degrees (trendPlungeArray). 
%
% Detailed string (projectionType) to specify on which projetion type is
% wanted to display the poles, on a equal-angle ('equalaNgle'), or
% equal-area ('equalaRea') projection.
%
% Detailed grahical options (pointGraphicalOptions) of the points in a
% string chain (e.g. 'ko', which gives circular points in black color). 
%
% Logical option if it is wanted to plot the grid background (want2plotgrid).
% 
% Integer number that indicates the size of the symbol (symbolSize).
%
% String letter that indicates the internal color of the symbol
% (symbolFaceColor). This is used in closed symbols like 's', 'o' and not
% for open symbols like '+', '*', 'x'.
%
% String letter that indicates the edge volor of the symbol (symbolEdgeColor).
%
% Structure that controls the colors of the principal and secondary grids
% of the net (gridColsSTR). The form in which the structure is constructed
% is a little bit tracky. Here is an example:
%     pCell ={ '''-r''', '''-g''' };
%     sCell ={ '''-b''', '''-y''' };
%     gridColsSTR =struct('primScaleCell', {pCell}, 'scndScaleCell', {sCell});
% The pCell controls the two colores of the principal grid.
% The sCell controls the two colores of the secondary grid.
% The first color indicates the color of the radial grid, while the second
% color indicates the concentrical circular grid.
%
% Output(s);
% The graphical representation in a figure window.
%
% Example1:
% Plot the following planes given in this array (trendPlungeArray):
% trendPlungeArray =[ 156, 65; 171, 60; 334, 15; 334, 15; 319, 26; 156, 65;
%     321, 38; 199, 16; 143, 63; 327, 19; 296, 22; 329, 15; 198, 3;
%     287, 21; 171, 60 ];
% plotplaneorientationdata( trendPlungeArray, 'equalarea', 'kx', true );
%
% Example2:
% With the same data used in example 1, now we will control some aspects fo
% the final plot.
% We create the cell of colores.
% pCell ={ '''-r''', '''-g''' };
% sCell ={ '''-b''', '''-y''' };
% gridColsSTR =struct( 'primScaleCell', {pCell}, 'scndScaleCell', {sCell} );
% Now we run the function.
% plotplaneorientationdata( trendPlungeArray, 'equalarea', 'ko', true, ...
%    4, 'r', 'b', gridColsSTR, true );
% 
%%%%%%%%%%%%%%%%%%
% plotplaneorientationdata( trendPlungeArray )
%%%%%%%%%%%%%%%%%

%% Initial values.
% Default grid colors.
   prinScaleColorsCell ={ '''-k''', '''-k''' };
   scndScaleColorsCell ={ '''-g''', '''-g''' };
   
if nargin < 2
    projectionType ='equalangle';
    plotSymbol ='ko';
    want2plotgrid = false;
    symbolSize =2;
    symbolFaceColor ='w';
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 3
    plotSymbol ='ko';
    want2plotgrid = false;
    symbolSize =2;
    symbolFaceColor ='w';
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 4
    want2plotgrid = false;
    symbolSize =2;
    symbolFaceColor ='w';
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 5
    symbolSize =2;
    symbolFaceColor ='w';
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 6
    symbolFaceColor ='w';
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 7
    symbolEdgeColor ='k';
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale =false;
elseif nargin < 8
    gridColsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
        'scndScaleCell', {scndScaleColorsCell} );
    plotSecondScale ='false';
elseif nargin < 9
    plotSecondScale ='false';
end

% Initial constants.
prinTrendStepsGrad =10;
prinPlungeStepsGrad =10;
noSecondScalePlungeGrad =85;
noSecondScaleTrendGrad =85;

% Number of data.
matrixSize =size(trendPlungeArray);

% Creating the NE polar matrix.
polarMatrix =zeros(matrixSize(1) ,2);

%% Filling the polar matrix.
switch lower(projectionType) 
    case {'N','equalaNgle', 'equalangle'}
        for i=1:matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           %[polarMatrix(i,1) ,polarMatrix(i,2)] =...
           polarMatrix(i,:) = ...
               equalanglepolar2planepolar( [trendPlungeArray(i,1)...
                ,trendPlungeArray(i,2)] );
        end
    case {'R','equalaRea', 'equalarea'} 
        for i=1:matrixSize(1)
           %Calculate NE polar coordinates from equalangle projection
           %[ polarMatrix(i,1), polarMatrix(i,2) ] = ...
           polarMatrix(i,:) = ...
               equalareapolar2planepolar( [trendPlungeArray(i,1), ...
               trendPlungeArray(i,2)] );
        end
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
end

%% Plotting the grid.
if want2plotgrid == true
    hold on;
    switch lower(projectionType)
        case {'N','equalaNgle', 'equalangle'}
            %Calling the function to create the background grid
            createpolargrid('equalangle', prinTrendStepsGrad, ...
                prinPlungeStepsGrad, noSecondScalePlungeGrad , ...
                noSecondScaleTrendGrad, plotSecondScale, gridColsSTR );
        case {'R','equalaRea', 'equalarea'}
            %Calling the function to create the background grid
            createpolargrid('equalarea', prinTrendStepsGrad, ...
                prinPlungeStepsGrad, noSecondScalePlungeGrad, ...
                noSecondScaleTrendGrad, plotSecondScale, gridColsSTR );
        otherwise
            display( ['Unknown option: ', projectionType, ...
                '. Please recall the command and type a correct option!'] );
    end
    %[equalTrendPrinMatR, equalTrendSecondMatR ] =createtrendvec(prinTrendStepsGrad);
    %plotgreatcircnorth( equalTrendPrinMatR, equalTrendSecondMatR, 0.05 );
    plotgreatcircnorth (projectionType);
end

%% Plotting polar matrix points.
hold on
displaySquareSide = 2;
polarMatrixSize = size(polarMatrix);

axis((displaySquareSide /2 *[-1 ,1 ,-1 ,1]), 'equal', 'off');

numPairs =polarMatrixSize(2) /2;
for i=1 :numPairs
    xArray =polarMatrix( :, 2*i ) .*sin( polarMatrix(:, (2*i -1)) );
    yArray =polarMatrix( :, 2*i ) .*cos( polarMatrix(:, (2*i -1)) );
end
plotHandle = plot( xArray, yArray, plotSymbol, 'markersize', symbolSize, ...
    'markerfacecolor', symbolFaceColor, 'markeredgecolor', symbolEdgeColor );

end

