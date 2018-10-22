function [ freqReshapedArray ] =plotpolesfrequenydata( arrangedFreqArray, ...
    freqValNameArray, freqQuantArray, projectionType, symbolSTR, plotGridTrue )
%
% Description:
% Plot the frequency data, given for each frecuency quantity a plot symbol
% size.
%
% External sub-functions: plotplaneorientationdata.
%
% See also: findorientationsfrequencies.
%
% Input(s):
% Arranged matrix of m x 3 having in the third column the frequency data
% (arrangedFreqArray). The first and the second column of this matrix are
% the azimutal and inclinations arranged data of the input matrix,
% respectively. 
%
% Vector having the names of the actual frequencies (freqValNameArray).
%
% Vector having the quantities of each frequency (freqQuantArray).
% Note: The variables 'arrangedFreqArray', 'freqValNameArray' and
% 'freqQuantArray' can be obtained with the 'findorientationsfrequencies'
% function. 
%
% String specifying the type of the projection (projectionType).
%
% Structure in order to specify the shape, size, and colors of the symbols
% (symbolSTR). 
%        symbolSTR.plotSymbol:      String for the flag of the shape type.
%        symbolSTR.symbolSizeLimts: Array of 1x2 with the lower and upper
%                                   limits size of the symbol in points
%                                   units. 
%        symbolSTR.faceColor:       Color string or a color vector of 1x3
%                                   in order to specify the color fo the
%                                   face of the symbol. 
%        symbolSTR.edgeColor:       Color string or a color vector of 1x3
%                                   in order to specify the color fo the
%                                   edge of the symbol. 
%
% Boolean value of true if the spherical projection grid is wanted to plot
% (plotGridTrue).
%
% Output(s):
% In this array, every pair of colums contains the orientatio data for each
% frequency; from single frequencies in the first pair to further
% incremental frequencies in the following pairs (freqReshapedArray).
%
% Example1:
% arrangedFreqArray =[ 1, 22, 1; 1, 40, 1; 2, 46, 1; 5, 17, 1; 5, 39, 1; 8, 4, 2; 9, 40, 5; 12, 46, 1; 13, 1, 1; 14, 2, 1; 16, 6, 1; 19, 2, 1; 19, 45, 1; 21, 2, 1; 21, 45, 1; 25, 39, 1; 31, 33, 1; 32, 45, 1; 36, 38, 1; 39, 38, 1; 41, 40, 1; 59, 22, 1; 60, 14, 2; 60, 21, 1; 61, 19, 1; 63, 18, 1; 64, 10, 1; 66, 15, 2; 68, 15, 1; 70, 1, 1; 71, 8, 1; 71, 15, 1; 72, 13, 1; 73, 1, 1; 76, 17, 1; 77, 7, 1; 77, 8, 1; 78, 6, 1; 78, 23, 1; 81, 4, 1; 82, 1, 1; 83, 6, 2; 84, 1, 1; 86, 6, 2; 86, 12, 1; 87, 48, 1; 92, 5, 1; 92, 7, 1; 94, 3, 2; 99, 16, 2; 99, 21, 1; 100, 14, 1; 108, 4, 1; 124, 35, 1; 133, 42, 1; 139, 73, 1; 145, 6, 1; 146, 10, 1; 147, 19, 1; 153, 29, 1; 155, 36, 1; 156, 71, 2; 162, 38, 1; 162, 39, 2; 164, 43, 3; 164, 49, 2; 165, 37, 1; 165, 47, 1; 166, 39, 2; 168, 40, 1; 171, 51, 1; 172, 62, 1; 174, 47, 1; 176, 61, 1; 178, 44, 2; 178, 47, 2; 182, 54, 1; 183, 41, 1; 183, 49, 1; 184, 51, 1; 184, 54, 1; 186, 52, 1; 188, 49, 1; 188, 57, 1; 190, 2, 1; 190, 47, 1; 190, 48, 1; 190, 49, 1; 192, 47, 1; 194, 1, 1; 196, 1, 1; 196, 4, 1; 202, 5, 1; 208, 61, 1; 209, 37, 1; 218, 31, 1; 218, 42, 1; 225, 43, 1; 226, 46, 2; 228, 9, 1; 229, 9, 1; 231, 8, 1; 246, 56, 2; 246, 61, 1; 254, 66, 1; 260, 0, 1; 260, 2, 1; 260, 5, 1; 263, 3, 1; 266, 0, 3; 271, 4, 1; 271, 7, 1; 275, 32, 1; 277, 9, 2; 277, 11, 1; 277, 13, 1; 279, 16, 1; 281, 7, 2; 281, 11, 1; 282, 12, 1; 283, 15, 2; 286, 13, 1; 287, 12, 1; 288, 59, 1; 289, 14, 1; 292, 17, 2; 293, 22, 1; 293, 23, 1; 297, 52, 1; 316, 38, 1; 319, 30, 1; 320, 36, 1; 321, 38, 1; 324, 36, 1; 326, 16, 2; 329, 37, 2; 333, 42, 1; 334, 2, 10; 335, 40, 1; 337, 30, 1; 339, 38, 1; 347, 49, 1; 348, 37, 1; 350, 9, 1; 353, 38, 2; 355, 3, 1; 355, 40, 1 ]; 
% freqValNameArray =[ 1; 2; 3; 5; 10 ];
% freqQuantArray =[ 121; 22; 2; 1; 1 ];
% projectionType ='equalarea';
% plotGridTrue =true;
% symbolSTR =struct( 'plotSymbol', 'o', 'symbolSizeLimts', [4, 16], 'faceColor', 'w', 'edgeColor', 'k' );
%
%%%%%%%%%%%%%%%%%%%%%%%
% plotpolesfrequenydata( arrangedFreqArray, freqValNameArray,
%     freqQuantArray );
%%%%%%%%%%%%%%%%%%%%%%%

%% Input management.

if nargin < 5
    symbolSTR =struct( 'plotSymbol', 'o', 'symbolSizeLimts', ...
        [4, 16], 'faceColor', 'w', 'edgeColor', 'k' );
    plotGridTrue =false;
elseif nargin < 6
    plotGridTrue =false;
end

% Calculate the symbol size for each frequency group.
minSymbolSize =symbolSTR.symbolSizeLimts(1); %in points
maxSymbolSize =symbolSTR.symbolSizeLimts(2); %in points
% Plot frequency orientation data.
symbolFaceColor =symbolSTR.faceColor;
symbolEdgeColor =symbolSTR.edgeColor;
plotSymbol =symbolSTR.plotSymbol;

%% Arrange frequency matrix by its frequency.
[frequency ,indexes1] =sort(arrangedFreqArray(:,3) ,'ascend');
tempo1 =arrangedFreqArray(indexes1(:,1) ,1);
tempo2 =arrangedFreqArray(indexes1(:,1) ,2);
tempo3 =frequency(:,1);

sortedByFrequencyMat =[tempo1 ,tempo2 ,tempo3];

% Indexes in the sortedByFrequencyMat of initial and final data of each
% frequency group.
numberFreqGrps =size( freqValNameArray ,1 ); % number of frequency groups.
indexInitialVec =ones( numberFreqGrps, 1 );
indexFinalVec =zeros( numberFreqGrps, 1 );
for k=1 :numberFreqGrps
    indexFinalVec(k) =sum( freqQuantArray(1:k) );
end
a =indexFinalVec +1; % auxiliary vector.
indexInitialVec(2 :end) =a(1: end -1);
indexMat =[ indexInitialVec ,indexFinalVec ];

% Obtain separated matrices for each frequency.
freqReshapedArray =zeros( max(freqQuantArray), 2*numberFreqGrps );
for k=1 :numberFreqGrps
    freqReshapedArray(1: (indexMat(k, 2)-indexMat(k, 1)+1), 2*k-1) ...
        =sortedByFrequencyMat( indexMat(k ,1) :indexMat(k ,2) ,1 );
    freqReshapedArray(1: (indexMat(k, 2)-indexMat(k, 1)+1), 2*k ) ...
        =sortedByFrequencyMat( indexMat(k ,1) :indexMat(k ,2) ,2 );
end

%% Ploting.
% This will plot the points in different sizes according to the frequency.
symbolInterval =linspace(minSymbolSize ,maxSymbolSize, numberFreqGrps);
symbolSizeVec =round(symbolInterval);

pltHndleArray =zeros(1,numberFreqGrps);
for k =numberFreqGrps :-1 :1
    pltHndleArray(k) = plotplaneorientationdata ( ...
        freqReshapedArray(1 : freqQuantArray(k), 2*k-1 : 2*k), ...
        projectionType, plotSymbol, plotGridTrue, symbolSizeVec(k), ...
        symbolFaceColor, symbolEdgeColor);
endfor

% This will plot the center of the point.
for k =numberFreqGrps :-1 :1
    plotplaneorientationdata( ...
        freqReshapedArray( 1:freqQuantArray(k), 2*k-1: 2*k ), ...
        projectionType, '.', false, 1, 'k', 'k' );
end

% This will generate the legend.
freqValNameCell =num2cell(freqValNameArray');
legendStringCell =cell( 1, length(freqValNameCell) );
for k=1 :length(freqValNameCell)
    legendStringCell{k} =int2str(freqValNameCell{k});
end
legendHandle =legend( pltHndleArray, legendStringCell );
set(legendHandle, 'Box', 'off');
set(legendHandle, 'Color', 'none');

end

