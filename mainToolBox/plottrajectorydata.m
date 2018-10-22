function [ ] = plottrajectorydata (trendPlungeArray, projectionType, varargin)
% 
% Description:
% Plots the planes orientation data given by the trend and plunge of
% their respective poles in a spherical pole representation, equiangle 
% or aquiarea. With the actual function one can change the symbol size, the
% symbol face and adge color.
%
% External sub-function(s):
% equalanglepolar2planepolar, equalareapolar2planepolar.
%
% Input(s):
% Orientation data given in a matrix of n x 2 size, where the first column
% has the pole trend-angle, and second column the plunge-angle; boths in 
% angular degrees (trendPlungeArray). 
%
% Detailed string (projectionType) to specify on which projetion type is
% wanted to display the poles, on a equal-angle ('equalangle'), or
% equal-area ('equalarea') projection.

## Output(s);
## The graphical representation in a figure window.

## Example 1
## See script example13SCR.m.

%% Initial values.
if nargin < 2
    projectionType ='equalangle';
    varargin = {'k-'};
elseif nargin < 3
    varargin = {'k-'};
endif

% Number of data.
matrixSize = size (trendPlungeArray);

% Creating the NE polar matrix.
polarMatrix = zeros (matrixSize(1), 2);

%% Filling the polar matrix.
switch lower(projectionType) 
    case {'N','equalaNgle', 'equalangle'}
        for i=1:matrixSize(1)
           polarMatrix(i,:) = equalanglepolar2planepolar ( ...
               [trendPlungeArray(i,1), trendPlungeArray(i,2)]);
        endfor
    case {'R','equalaRea', 'equalarea'} 
        for i=1:matrixSize(1)
           polarMatrix(i,:) = equalareapolar2planepolar( ...
               [trendPlungeArray(i,1), trendPlungeArray(i,2)]);
        endfor
    otherwise 
         disp (['Unknown option: ' projectionType ...
             '. Please recall the command and type a correct option']);
endswitch

%% Plotting polar matrix points.
hold on
displaySquareSide = 2;
polarMatrixSize = size(polarMatrix);

axis((displaySquareSide /2 *[-1 ,1 ,-1 ,1]), 'equal', 'off');

numPairs = polarMatrixSize(2) /2;
for k = 1 : numPairs
    xArray = polarMatrix(:, 2*k) .*sin(polarMatrix(:, (2*k-1)));
    yArray = polarMatrix(:, 2*k) .*cos(polarMatrix(:, (2*k-1)));
endfor
plot (xArray, yArray, varargin{:});

endfunction

