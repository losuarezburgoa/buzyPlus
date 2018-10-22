function [ trendRadArray, plungeRadArray, nedRandVecArray ]= ...
    randomdirectionsonr3lowerhem( n, want2plot ) 
% 'randomdirectionsonr3lowerhem' comes form random directions in R^3 in the
% lower hemisphere.
%
% Description:
% Generate n uniformly distributed random directions in R^3, which are
% uniform on the half southern sphere surface in NED coordinate system.
%
% Requires Buzy+ toolbox to be put on the path.
%
% External sub-function(s):
% randomdirectionsonr3, trendplunge2unitvect (Buzy+ toolbox).
%
% Input(s):
% Integer number of 3D directions to be generated (n).
% True boolean value if a plot is wanted to perform (want2plot).
%
% Output(s):
% A nx1 array of the trend angle (clockwise sense from the North) in
% radians (trendRadArray).
%
% A nx1 array of the plunge angle (dipping sense from horizontal plane) in
% radians (plungeRadArray).
%
% A nx3 array of the (x,y,z) pair coordinates in R^3 in the NED system of
% the directons unit vectors (nedRandVecArray).
%
%%%%%%%%%%%%%%%
% [ trendRadArray, plungeRadArray, nedRandVecArray ]= ...
%    randomdirectionsonr3lowerhem( n, want2plot ) 
%%%%%%%%%%%%%%%

%% Input managing
if nargin < 2
    want2plot =false;
end

%% Transforming to the lower hemisphere by angles
[ trendRadArray, plungeNegPosRadArray ] =randomdirectionsonr3( n, false );

negIndexes =find( plungeNegPosRadArray <0 );
trendRadArray(negIndexes) =mod( (trendRadArray(negIndexes) +pi), 2*pi );
plungeRadArray =abs( plungeNegPosRadArray );

%% Obtaining the NED coordiantes
trendPlungeDegArray =[ trendRadArray(:), plungeRadArray(:) ] *180 /pi;
nedRandVecArray =trendplunge2unitvect( trendPlungeDegArray );

%% Plotting
if want2plot
    plot3( nedRandVecArray(:,1), nedRandVecArray(:,2), ...
        nedRandVecArray(:,3), 'k.' ); hold on
    axis equal
end

end