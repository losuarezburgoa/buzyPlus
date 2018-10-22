function [ trendRadArray, nedRandVecArray ] =randomdirectionsonr2 ...
    ( n, want2plot ) 
% randomdirectionsonR2 comes form random directions in R^2.
%
% Description:
% Generate n uniformly distributed random directions in R^2, which are
% uniform on the circle perimeter.
%
% Input(s):
% Integer number of 2D directions to be generated (n).
% True boolean value if a plot is wanted to perform (want2plot).
%
% Output(s):
% A nx1 array of the trend angle (clockwise sense from the North) in radians
% (trendRadArray).
%
% A nx2 array of the (x,y) pair coordinates in R^2 in the NED system of the
% directons unit vectors (nedRandVecArray).
%
%%%%%%%%%%%%
% [ trendRadArray, nedRandVecArray ] =randomdirectionsonr2( n, want2plot )
%%%%%%%%%%%%

%% Input managing
if nargin < 2
    want2plot =false;
end

%% Generate independent random numbers on vectors
% generate independent random numbers on vectors
nr =2*pi*rand(n,1);

%% Cretate random directions based on independent rando number vectors
randVecArray =[ cos(nr), sin(nr) ];

%% Transforming to NED coordiantes for depth=0
transformMat =[ 0, 1; 1, 0 ];
nedRandVecArray =transpose(transformMat *transpose(randVecArray));

%% Transforming to trend angles (in degrees)
alphaRadArray =cart2pol( randVecArray(:,1), randVecArray(:,2) );
trendRadArray =mod( (pi/2 -alphaRadArray), 2*pi );

%% Plotting
if want2plot
    plot( nedRandVecArray(:,1), nedRandVecArray(:,2), 'k.' ); hold on
    axis equal
end
end