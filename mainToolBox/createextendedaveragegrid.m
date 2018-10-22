function extArgValGrid = createextendedaveragegrid (coneAxisTrendPlungeArray, ...
    clustVals, circAreaPercent, projType, wantPlot)

## Description:
# Creates a extended grid by copying and projecting the poles located in the
# south hemisphere to the northern hemisphere. The results are used for the
# interpolation process.
# 
## Input(s):
# Matrix having the trend-plunge values of the orientation of the cone-axis
# used to evaluate the moving average values (coneAxisTrendPlungeArray)
# 
# Vector having the quantities of points encountered in each circualar
# window whose axis are reffered in the 'coneAxisTrendPlungeArray' (clustVals).
#
# Recalculated area value of the cluster window in percentaje of the total
# projected area (circAreaPercent).
#
# Type of projection: 'equalarea' or 'equalangle' (projType).
#
# Logical value if it is desired to plot (want2plot).
#
## Output(s):
#
# Array having the trend-plunge values of the extended movin evalution ppints.
#

# The plunge limit will control how many pomits will be refletd to the norhterm 
# hemiphere. Therefeore, we will select only some angles.
plungeLimit = 65;
expansionFactor = 1.5;

plungeLimitIndexes = coneAxisTrendPlungeArray(:, 2) <= plungeLimit;
externalconeAxisTrendPlungeArray = coneAxisTrendPlungeArray(plungeLimitIndexes, :);

# The selected values will also be reflected.
externalclustVals = clustVals(plungeLimitIndexes);
# Inorder to reflect, we add 180° to the trends, and the plunges are negative.
externalconeAxisTrendPlungeArray(:, 1) = ...
    mod(externalconeAxisTrendPlungeArray(: ,1) + 180, 360);
externalconeAxisTrendPlungeArray(:, 2) = -externalconeAxisTrendPlungeArray(: ,2);

# Joining all the direction angles.
extendedconeAxisTrendPlungeArray = [coneAxisTrendPlungeArray; ...
   externalconeAxisTrendPlungeArray];
# Also joining the clustered values.
extendedclustVals = [clustVals; externalclustVals];

# We have to scale the values.
extendedClusteredRelativeValsPercent = extendedclustVals;

## Convertig to polar cartesian plane.
numberValues = size (extendedconeAxisTrendPlungeArray, 1);
extendedNePolarMatRad = zeros (numberValues, 2);
switch projType
    case 'equalarea'
        for i = 1 : numberValues
            %[extendedNePolarMatRad(i, 1), extendedNePolarMatRad(i, 2)] = ...
            exdedNePolRad = ...
                equalareapolar2planepolar (extendedconeAxisTrendPlungeArray(i,:));
            extendedNePolarMatRad(i, 1) = exdedNePolRad(1);
            extendedNePolarMatRad(i, 2) = exdedNePolRad(2);
        endfor
            %[alpha, rhoLimit] = ...
            planePolarMat = equalareapolar2planepolar ([0, -plungeLimit]);
            alpha = planePolarMat(1);
            rhoLimit = planePolarMat(2);
    case 'equalangle'
        for i = 1 : numberValues
            %[extendedNePolarMatRad(i, 1), extendedNePolarMatRad(i, 2)] = ...
            exdedNePolRad = ...
                equalanglepolar2planepolar (extendedconeAxisTrendPlungeArray(i,:));
            extendedNePolarMatRad(i, 1) = exdedNePolRad(1);
            extendedNePolarMatRad(i, 2) = exdedNePolRad(2);
        endfor
            %[alpha, rhoLimit] = ...
            planePolarMat = equalanglepolar2planepolar ([0, -plungeLimit]);
            alpha = planePolarMat(1);
            rhoLimit = planePolarMat(2);
    otherwise
        error('Projetion type option bad written!');
endswitch

extendedValsXYmat = zeros(numberValues, 2);
for i = 1 : numberValues
    [extendedValsXYmat(i, 1), extendedValsXYmat(i, 2)] = nepol2cart ...
        (extendedNePolarMatRad(i, 1), extendedNePolarMatRad(i, 2));
endfor

# Creating an array with information such as the xy coordinates, 
# the clustered values, and the relative clustered values. This in order to cut data.
extArgValGrid = [extendedValsXYmat, extendedclustVals, ...
    extendedClusteredRelativeValsPercent];

# The limit disntance.
squareBoundaryHalfSide = rhoLimit * expansionFactor * sqrt(2) / 2;
# Cutting in each four ortogonal directions.
# ... to the rigth,
rigthSquareLimiting = extArgValGrid(:,1) <= squareBoundaryHalfSide;
extArgValGrid = extArgValGrid(rigthSquareLimiting, :);
# ... to the left,
leftSquareLimiting =extArgValGrid(:,1) >=-squareBoundaryHalfSide;
extArgValGrid =extArgValGrid( leftSquareLimiting ,: );
# ... above,
upSquareLimiting =extArgValGrid(:,2) <=squareBoundaryHalfSide;
extArgValGrid =extArgValGrid( upSquareLimiting ,: );
# ... down.
downSquareLimiting =extArgValGrid(:,2) >=-squareBoundaryHalfSide;
extArgValGrid =extArgValGrid( downSquareLimiting ,: );

# Creating a string in order to inform in the plot.
%notes_string = strcat('Projection Type:', projType, '; Counting area:', ...
%    num2str(circAreaPercent ,2), '%');

## PLOTTING.
if wantPlot == true
    clusterValsText = num2str (extArgValGrid(:, 3), 3);
    m = size(clusterValsText, 2);
    hold on
    axis (squareBoundaryHalfSide * [-1, 1, -1, 1], 'equal', 'off');
    plot (extArgValGrid(:, 1), extArgValGrid(:, 2), 'linestyle', 'none', ...
        'marker', 'x', 'markersize', 3, 'markeredgecolor', 'b');
    letterSpace = 0.04;
    lineSpace = 0.1;
    lettersPositionMat = extArgValGrid(:, 1:2);
    for j = 1 : m
        lettersPositionMat(:, 1) = lettersPositionMat(:, 1) ...
            + letterSpace * (j -m /2);
        text(lettersPositionMat(:, 1), lettersPositionMat(:, 2), ...
            clusterValsText(:, j), 'FontSize', 10, 'horizontalalignment', 'center');
    endfor
    %text( -squareBoundaryHalfSide , (-squareBoundaryHalfSide -lineSpace) ,notes_string );
    plotgreatcircnorth (projType);
endif

endfunction

