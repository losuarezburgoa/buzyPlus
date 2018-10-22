function [clusteredIndexes, unClusteredIndexes] = clusterwithcircularwindow ...
    (coneSTR, trendPlungeArray, want2plot, projectionType)

## Description:
# Find out those poles that are inside a circular window cluster in the
# stereographic projection. In this case the circular cluster window is
# assigned with its axis orientation and the cone semi angle.
# 
# Nested function(s):
# rot_orient_arnd_verticalaxs, rot_orient_arnd_northernstrike, 
# un_particioned_clusterwindow
# 
## Input(s):
# Trend-plunge vector of the cone axis orientation (coneAxisTrendPlungeVec).
# This variable is created with the 'evalaxesonsouthhemisphere' function.
# 
# Semi-angle of the the cone in hexagesimal grades (coneSemiAngleDeg)
# 
# Identification number of the cluster window (clusterID).
# 
# Matrix (n x 2) containing the pole trend-plunge information
# (trendPlungeArray). The first column has the trend information and second
# the plunge information, where n is the number of data.
# 
# Variable of logical value (want2plot) to specify if it is desired to plot
# the results in a figure by given a true value, or not by given a false value.
# 
## Output(s):
# Matrix (m x 2) containing those pole trend-plunge information that falls
# inside the rectngular cluster (clusteredtrendPlungeArray). The first column
# has the trend values and the second column has the plunge values.
# 
# Vector (length equal to m) containing the cluster id number of each
# trend-plunge pairs specified in the trend-plunge matrix (clusterIdVec). 
# 
## Example1:
# A conical cluster with vertix on the unitsphere has an axis with a trend 
# of 3.3158° and plunge 42°. The angle from the axis to the generatrix is 
# 12.857 (also called here the semiangle). There are many pole orientations
# given in the 'trendPlungeArray'. It is wanted to know if any of these orientations
# is inside this conical cluster.
#
# coneSTR = struct('axisTPvec', [6.3158, 42], 'semiAngDeg', 12.857);
# %Only info: coneSemiAngleDeg = 2.5125;
# trendPlungeArray = [353, 11; 166, 85; 011, 77; 116, 66; 139, 72; 329, 31; ...
#                   004, 49; 009, 85; 113, 67; 263, 10; 315, 33; 263, 10; ...
#                   152, 72; 158, 84; 126, 48];
# want2plot = true;
# projectionType = 'equalangle';
#

# Input management.
if nargin < 3
  want2plot = false;
  projectionType = 'equalangle';
elseif nargin < 4
  projectionType = 'equalangle';
endif

# Resolving the structure.
coneAxisTrendPlungeVec = coneSTR.axisTPvec;
coneSemiAngleDeg = coneSTR.semiAngDeg;

# Rotating all data twice.
numberData = size (trendPlungeArray ,1);
rotatedtrendPlungeArray = zeros (numberData ,2);
for i = 1 : numberData
     rotatedtrendPlungeArray(i,:) = ...
         rot_orient_arnd_verticalaxs (trendPlungeArray(i,:), ...
         (90 - coneAxisTrendPlungeVec(1)));
     rotatedtrendPlungeArray(i,:) = ...
         rot_orient_arnd_northernstrike (rotatedtrendPlungeArray(i,:), ...
         (90 - coneAxisTrendPlungeVec(2)));
endfor

# Chosing those points inside the cluster.
clusteredDataIndexes = rotatedtrendPlungeArray(:, 2) >= (90 - coneSemiAngleDeg);
clusteredIndexes = find(clusteredDataIndexes);
unClusteredIndexes = find(~clusteredDataIndexes);

# Taking the data that are inside and putside the cluster.
clusteredtrendPlungeArray = trendPlungeArray(clusteredIndexes, :);
unClusteredtrendPlungeArray = trendPlungeArray(unClusteredIndexes, :);


# Obtaining the clusters matrices.
if want2plot == true
    # Plottig the clusters and the grid.
    a = coneAxisTrendPlungeVec(2) - coneSemiAngleDeg;
    if a >= 0
        closedCurveMat2 = un_particioned_clusterwindow ...
            (coneAxisTrendPlungeVec, coneSemiAngleDeg, projectionType, true);
        closedCurveMat1 = zeros(0);
    else
        [closedCurveMat2, closedCurveMat1] = particioned_clusterwindow ...
            (coneAxisTrendPlungeVec, coneSemiAngleDeg, projectionType, true);
    endif
    # Plotting the clustered points.
    plotplaneorientationdata (clusteredtrendPlungeArray, projectionType, ...
        's', false, 5, 'r');
    # Plotting the unclustered points.
    plotplaneorientationdata (unClusteredtrendPlungeArray, projectionType, ...
        'o', false, 5, 'g');
endif

endfunction

