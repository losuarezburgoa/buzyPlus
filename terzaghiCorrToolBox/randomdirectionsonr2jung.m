function [ trendRadArray, nedRandVecArray ] =randomdirectionsonr2jung ...
    ( n, want2plot )
% 'randomdirectionsonR2jung' comes form random directions in R^2, Jung
% version. 
%
% Description:
% Generate n uniformly distributed random directions in R^2, which are
% uniform on the circle perimeter.
%
% Based on the subcode 'UNIFORMdirections' inside the code
% randonMisesFisherm.m code of Sungkyu Jung, Feb 3, 2010. No license type
% specfied.
%
% Reference:
% S. Jung, n.d. Generating von Mises-Fisher distribution on the unit
% d-sphere: Matlab code, vignette (for 3-d case).
% http://www.unc.edu/~sungkyu/MiscPage.html (entered on April, 2011).
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
nr =randn(2,n);

%% Cretate random directions based on independent random number vectors
randVecArray =zeros(2, n);
for i=1 :n
    while 1
        % length of ith vector
        ni =nr(:,i)'*nr(:,i); 
        % exclude too small values to avoid numerical discretization
        if ni <1e-10 
            % so repeat random generation
            nr(:,i) =randn(2,1);
        else
            randVecArray(:,i) =nr(:,i) /sqrt(ni);
            break;
        end
    end
end
randVecArray =transpose( randVecArray );

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