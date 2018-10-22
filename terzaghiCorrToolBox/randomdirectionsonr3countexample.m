function randVecArray =randomdirectionsonr3countexample( n, want2plot ) 
% 'randomdirectionsonr3countexample' comes form random directions in R^3, a
%   counterexample. 
%
% Description:
% This is a counterexample of the way how NOT a random direction in R^3
% should be created.
%
% Input(s):
% Integer number of 3D directions to be generated (n).
% True boolean value if a plot is wanted to perform (want2plot).
%
% Output(s):
% A nx3 array of the (x,y,z) pair coordinates in R^3 of the directons unit
% vectors (nedRandVecArray).
%
%%%%%%%%%%%%%%
% randVecArray =randomdirectionsonr3countexample( n, want2plot ) 
%%%%%%%%%%%%%%

%% Input managing
if nargin < 2
    want2plot =false;
end

% Generate random angles on the circle
trendRadArray =randomdirectionsonr2( n, false );
% Trend angles are similar to longitude angles
longRadArray =mod( (pi/2 -trendRadArray), (2*pi) );

% Generate random angles for the latitudes from -pi/2 to pi/2
latRadArray =pi *rand(n,1) -pi/2;

[x,y,z] =sph2cart( longRadArray, latRadArray, ones(n,1) );
randVecArray =[x,y,z];

%% Plotting
if want2plot
    plot3( randVecArray(:,1), randVecArray(:,2), randVecArray(:,3), 'k.' ); hold on
    axis equal
end
end