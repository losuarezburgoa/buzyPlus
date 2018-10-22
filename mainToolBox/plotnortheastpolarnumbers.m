function [  ] =plotnortheastpolarnumbers( polarMatrix, numberMat, ...
    displaySquareSide, textColorString )
%%%%%%%%%%%%%%%%
% plotnortheastpolarnumbers( polarMatrix, numberMat, displaySquareSide,
% textColorString )
%%%%%%%%%%%%%%%%
%Description:
% Plots 2D points expressed in polar coordinates at the North-East
% system (NE system: x-axis points to the north, y-axis points to the
% east).
%
%Input(s):
% Matrix of similar entities containing in each consecutive pair of
% columns, the polar data of each entity (polarMatrix). The first column of
% each pair has the angular polar coordinates and the second column of the
% pair has the radial coordinate.
% 
% The matrix has a dimension of (number of points of each similar entity x
% 2 x number of entities).
%
% The side of the display square, with center in the origin
% (displaySquareSide).
%
% Options of the plot, which controls the type, color of the line,etc. This
% variable is a string variable, so it must be between '' (displayOptions).
%
%%%%%%%%%%%%%%%%
% plotnortheastpolarnumbers( polarMatrix, numberMat, displaySquareSide,
% textColorString )
%%%%%%%%%%%%%%%%

%% Input variables
if nargin <4
    textColorString ='r';
end

polarMatrixSize =size(polarMatrix);
%% The plotting process
axis (displaySquareSide /2 *[-1 ,1 ,-1 ,1], 'equal', 'off');
deltaXY =0.0075 *displaySquareSide;
for i=1 :(polarMatrixSize(2) /2)
    x =polarMatrix(:,2*i) .*sin(polarMatrix(:,2*i -1)) +deltaXY;
    y =polarMatrix(:,2*i) .*cos(polarMatrix(:,2*i -1)) +deltaXY;
    for j=1 :size(numberMat, 1)
        numberString =int2str( numberMat(j,i) );
        text( x(j), y(j), numberString, 'Color', textColorString );
    end
end

end