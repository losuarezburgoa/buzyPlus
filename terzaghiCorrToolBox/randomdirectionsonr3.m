function [ trendRadArray, plungeNegPosRadArray, nedRandVecArray ]= ...
    randomdirectionsonr3( n, want2plot ) 
% randomdirectionsonR3 comes form random directions in R^3.
%
% Description:
% Generate n uniformly distributed random directions in R^3, which are
% uniform on the sphere surface.
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
% [ trendRadArray, plungeNegPosRadArray, nedRandVecArray ] = ...
%     randomdirectionsonr3( n, want2plot ) 
%%%%%%%%%%%%%%%

%% Input managing
if nargin < 2
    want2plot =false;
end

%% Generate independent random numbers on vectors
% Set the dimension
dimR =3;
% generate independent random numbers on vectors
nr =randn(dimR,n);

%% Cretate random directions based on independent rando number vectors
randVecArray =zeros(dimR, n);
for i=1 :n
    while 1
        % length of ith vector
        ni =nr(:,i)'*nr(:,i); 
        % exclude too small values to avoid numerical discretization
        if ni <1e-10 
            % so repeat random generation
            nr(:,i)=randn(dimR,1);
        else
            randVecArray(:,i) =nr(:,i)/sqrt(ni);
            break;
        end
    end
end
randVecArray =transpose( randVecArray );

%% Transforming to NED coordiantes
transformMat =[ 0, 1, 0; 1, 0, 0; 0, 0, -1 ];
nedRandVecArray =transpose(transformMat *transpose(randVecArray));

%% Transforming to longitude-colatitude in angles in NED
[ trendRadArray, plungeNegPosRadArray ] =cart2sph( nedRandVecArray(:,1), ...
    nedRandVecArray(:,2), nedRandVecArray(:,3) );

%% Plotting
if want2plot
    plot3( nedRandVecArray(:,1), nedRandVecArray(:,2), ...
        nedRandVecArray(:,3), 'k.' ); hold on
    axis equal
end

end