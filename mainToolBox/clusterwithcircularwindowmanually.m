function [clusteredTrendPlungeMat, clusterIdVec, unClusteredTrendPlungeMat, ...
      unClusterIdVec, closedCurveMat2, closedCurveMat1] ...
      = clusterwithcircularwindowmanually (coneAxisTrendPlungeVec, ...
      coneSemiAngleGrad, clusterID, trendPlungeMat, want2see, projectionType)

%Description:
%Find out those poles that are inside a circular window cluster in the
%stereographic projection. In this case the circular cluster window is
%assigned with its axis orientation and the cone semi angle.
%
%Nested function(s):
# rot_orient_arnd_verticalaxs, rot_orient_arnd_northernstrike, 
# un_particioned_clusterwindow
%
# Input(s):
# Trend-plunge vector of the cone axis orientation (coneAxisTrendPlungeVec).
# This variable is created with the 'evalaxesonsouthhemisphere' function.
%
%Semi-angle of the the cone in hexagesimal grades (coneSemiAngleGrad)
%
%Identification number of the cluster window (clusterID).
%
%Matrix (n x 2) containing the pole trend-plunge information
%(trendplungeMat). The first column has the trend information and second
%the plunge information, where n is the number of data.
%
%Variable of logical value (want2see) to specify if it is desired to plot
%the results in a figure by given a true value, or not by given a false value.
%
%Output(s):
%Matrix (m x 2) containing those pole trend-plunge information that falls
%inside the rectngular cluster (clusteredTrendPlungeMat). The first column
%has the trend values and the second column has the plunge values.
%
%Vector (length equal to m) containing the cluster id number of each
%trend-plunge pairs specified in the trend-plunge matrix (clusterIdVec). 
%
%
% Example1:
# A conical cluster with vertix on the unitsphere has an axis with a trend 
# of 3.3158° and plunge 42°. The angle from the axis to the generatrix is 
# 12.857 (also called here the semiangle). There are many pole orientations
# given in the 'trendPlungeMat'. It is wanted to know if any of these orientations
# is inside this conical cluster.
#
# coneAxisTrendPlungeVec = [6.3158, 42];
# coneSemiAngleGrad = 12.857;
# %Only info: coneSemiAngleGrad = 2.5125;
# trendPlungeMat = [353, 11; 166, 85; 011, 77; 116, 66; 139, 72; 329, 31; ...
#                   004, 49; 009, 85; 113, 67; 263, 10; 315, 33; 263, 10; ...
#                   152, 72; 158, 84; 126, 48];
# want2see = true;
#

# Input management.
if nargin < 5
  want2see = false;
  projectionType = 'equalangle';
elseif nargin < 6
  projectionType = 'equalangle';
endif

# Rotating all data  twice.
numberData = size(trendPlungeMat ,1);
rotatedTrendPlungeMat = zeros(numberData ,2);
for i = 1 : numberData
     rotatedTrendPlungeMat(i,:) = ...
         rot_orient_arnd_verticalaxs(trendPlungeMat(i,:), (90 - coneAxisTrendPlungeVec(1)));
     rotatedTrendPlungeMat(i,:) = ...
         rot_orient_arnd_northernstrike(rotatedTrendPlungeMat(i,:), (90 - coneAxisTrendPlungeVec(2)));
endfor

# Chosing those points inside the cluster.
clusteredDataIndexes = rotatedTrendPlungeMat(:, 2) >= (90 - coneSemiAngleGrad);
clusteredTrendPlungeMat = trendPlungeMat(clusteredDataIndexes, :);
clusterIdVec = ones(size(clusteredTrendPlungeMat, 1), 1) * clusterID;

# Chosing those points outside the cluster.
unClusteredDataIndexes = rotatedTrendPlungeMat(:,2) < (90 - coneSemiAngleGrad);
unClusteredTrendPlungeMat = trendPlungeMat(unClusteredDataIndexes, :);
unClusterIdVec = zeros(size(unClusteredTrendPlungeMat, 1), 1);

# Obtaining the clusters matrices.
if want2see == true
    hold on
    # Plottig the clusters and the grid.
    a = coneAxisTrendPlungeVec(2) - coneSemiAngleGrad;
    if a >= 0
        closedCurveMat2 = un_particioned_clusterwindow ...
            (coneAxisTrendPlungeVec, coneSemiAngleGrad, projectionType, true);
        closedCurveMat1 = zeros(0);
    else
        [closedCurveMat2, closedCurveMat1] = particioned_clusterwindow ...
            (coneAxisTrendPlungeVec, coneSemiAngleGrad, projectionType, true);
    endif
    # Ploting the clustered points.
    plotplaneorientationdata(clusteredTrendPlungeMat, projectionType, 'k+' , false, 5);
    # Ploting the unclustered points.
    plotplaneorientationdata(unClusteredTrendPlungeMat, projectionType, 'ko', false, 5);
endif

endfunction

