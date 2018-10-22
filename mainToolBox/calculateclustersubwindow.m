function [lineNePolarPtsMat1, arcNePolarPtsMat2, lineNePolarPtsMat3, ...
    arcNePolarPtsMat4] = calculateclustersubwindow (extremePointsMatGrad, ...
    want2see)

%Description:
%Calculates the points of the circular arcs and lines that conforms a
%clustering sub-window, by given the two oposite extreme points.
%
%Nested function(s):
%equalareapolar2planepolar ,calpointsnecirculararcpol ,polar2nepolar.
%
%Input(s):
%Matrix of extreme points (2 x 2), where the first row has the lowest left
%point of the anulus sector and the second one has the highest right point.
%The firsts column has the trend values and the second the plunge values
%(extremePointsMatGrad). Be careful and remember that the first point (the
%lowest one) has the highest plunge, because as one approaches to the
%center of the circle one has higher values up to 90!.
%Logical variable to chose of if it is desired to plot in a Figure the resulting
%window (want2see), by giving a true value; otherwise, give a false value.
%
%Output(s):
%Matrix (2 x 2) of the points that conforms the line 1 of the window (i.e. the
%radial left side of the window) (lineNePolarPtsMat1).
%Matrix (n x 2) of the points that conforms the circular 2 arc of the
%window (i.e. the upper arc side of the window) (arcNePolarPtsMat2).
%Matrix (2 x 2) of the points that conforms the line 3 of the window (i.e. the
%radial rigth side of the window) (lineNePolarPtsMat3).
%Matrix (n x 2) of the points that conforms the circular 4 arc of the
%window (i.e. the lower arc side of the window) (arcNePolarPtsMat4).
%
## Example 1:
## [lineNePolarPtsMat1, arcNePolarPtsMat2, lineNePolarPtsMat3, arcNePolarPtsMat4] = ...
##      calculateclustersubwindow ([0, 85; 156, 60], true);
## extremePointsMatGrad = [0, 85; 156, 60];
## want2see = 1;

## Example 2:
%extremePointsMatGrad = [260, 0; 100, 70];
%extremePointsMatGrad = [355, 0; 10, 90];
%extremePointsMatGrad = [350, 10; 350, 0];
%extremePointsMatGrad = [350, 10; 5, 10];
%extremePointsMatGrad = [350, 10; 10, 0];
%extremePointsMatGrad = [10, 20; 20, 10];
%extremePointsMatGrad = [180, 20; 200, 10];
%extremePointsMatGrad = [160, 20; 200, 10];
%extremePointsMatGrad = [80, 10; 100, 20];
%extremePointsMatGrad = [350, 20; 200, 10];
%extremePointsMatGrad = [200, 10; 350, 20];
%extremePointsMatGrad = [200, 0; 350, 90];
%extremePointsMatGrad = [0, 0; 360, 90];
%extremePointsMatGrad = [90, 0; 180, 90];
%extremePointsMatGrad = [0, 0; 180, 90];
%extremePointsMatGrad = [90, 0; 270, 90];
%extremePointsMatGrad = [90, 0; 360, 90];
%extremePointsMatGrad = [90, 0; 355, 90];
%extremePointsMatGrad = [200, 0; 350, 100];
%extremePointsMatGrad = [200, 0; 350, -10];
%extremePointsMatGrad = [200, 100; 350, -10];
%extremePointsMatGrad = [200, 0; 350, 90];
%extremePointsMatGrad = [-200, 0; 350, 90];
%extremePointsMatGrad = [200, 90; 350, 90];
%extremePointsMatGrad = [200, 0; 350, 0]
%want2see = 1;
%wantPlotPt = 1;

## Input management.
if nargin < 2
    want2see = false;
    wantPlotPt = false;
elseif nargin < 3
    wantPlotPt = false;
endif

if or(any(extremePointsMatGrad(:,2) > 90), any(extremePointsMatGrad(:,2) < 0))
    error('The second column of the input matrix should be between [0, 90]!');
endif

## Correction if the trend is greater than 360.
idxs360 = extremePointsMatGrad(:,1) == 360;
extremePointsMatGrad(:,1) = mod(extremePointsMatGrad(:,1), 360);
extremePointsMatGrad(idxs360,1) = 360;

## Case the final angle is less than the initial.
isMaxAngLessMinAngTrue = extremePointsMatGrad(1,1) > extremePointsMatGrad(2,1);
if isMaxAngLessMinAngTrue
    angDiff = 360 - extremePointsMatGrad(1,1);
    extremePointsMatGrad(:,1) = mod(extremePointsMatGrad(:,1) + ones(2,1) * angDiff, 360);
endif

## Trend-plunge nodes matrix (Here is constructed the matrix of the four
# points that conforms the window)
nodesMatrix = zeros(4,2);
nodesMatrix(1, :) = extremePointsMatGrad(1 ,:);
nodesMatrix(2 ,1) = extremePointsMatGrad(1 ,1);
nodesMatrix(2 ,2) = extremePointsMatGrad(2 ,2);
nodesMatrix(3 ,:) = extremePointsMatGrad(2 ,:);
nodesMatrix(4 ,1) = extremePointsMatGrad(2 ,1);
nodesMatrix(4 ,2) = extremePointsMatGrad(1 ,2);

## North-East polar nodes matrix projected into equalarea
polarNodesMat = zeros (size(nodesMatrix));
for i=1 :size(nodesMatrix ,1)
    %[ polarNodesMat(i ,1), polarNodesMat(i ,2) ] =...
    polarNodesArray = ...
        equalareapolar2planepolar( nodesMatrix(i ,:) );
    polarNodesMat(i ,1) = polarNodesArray(1);
    polarNodesMat(i ,2) = polarNodesArray(2);
end

%Calculating arc points
resolution = 36;
internalPlots = false;
initialArcAngleRad = polarNodesMat(1,1);
arcAngleRad = polarNodesMat(3,1) - polarNodesMat(1,1);

## Arc 4 matrix.
#( radius, arcAngleRad, initialArcAngleRad, resolution, want2see )
# All in respect points 1 and 3
arcNePolarPtsMat4 = calpointsnecirculararcpol ...
    (polarNodesMat(1,2), arcAngleRad, initialArcAngleRad, resolution, internalPlots);
arcNePolarPtsMat4 = flipud (arcNePolarPtsMat4);
## Arc 2 matrix.
# ( radius, arcAngleRad, initialArcAngleRad, resolution, want2see )
# All in respect points 1 and 3
arcNePolarPtsMat2 = calpointsnecirculararcpol...
    (polarNodesMat(3,2), arcAngleRad, initialArcAngleRad, resolution, internalPlots);
    
## Calculating line points
# Line 1 matrix
lineNePolarPtsMat1 = (polarNodesMat(1:2 ,:));
# Line 3 matrix
lineNePolarPtsMat3 = (polarNodesMat(3:4 ,:));

if isMaxAngLessMinAngTrue
    arcNePolarPtsMat4 = [arcNePolarPtsMat4(:,1) - deg2rad(angDiff), ...
        arcNePolarPtsMat4(:,2)];
    arcNePolarPtsMat2 = [arcNePolarPtsMat2(:,1) - deg2rad(angDiff), ...
        arcNePolarPtsMat2(:,2)];
    lineNePolarPtsMat1 = [polarNodesMat(1:2 ,1) - deg2rad(angDiff), ...
        polarNodesMat(1:2 ,2)];
    lineNePolarPtsMat3 = [polarNodesMat(3:4 ,1) - deg2rad(angDiff), ...
        polarNodesMat(3:4 ,2)];;
endif

## PLOTTING
if want2see == true
    hold on
    %Graphic constants and options
    graphOptions = 'b+-';
    sphRadius =1;
    cenVec = zeros (1, 2);
    %Transforming the nodes matrix from polar to north-east polar 
    toPlotMat = [lineNePolarPtsMat1(1:end-1,:); arcNePolarPtsMat2(1:end-1,:); ...
        lineNePolarPtsMat3(1:end-1,:); arcNePolarPtsMat4];
    toPlotMat(: ,1) = polar2nepolar( toPlotMat(: ,1) );
    %Now plotting
    #polar (toPlotMat(:,1), toPlotMat(:,2), graphOptions );
    [x, y] = pol2cart (toPlotMat(:,1), toPlotMat(:,2));
    
    plot(x, y, graphOptions);
    %plot(x(1), y(1), 'ro');
    
    ## Plotting ther point numbers.
    if wantPlotPt
    a = [0:5:length(x)-1]'; b = num2str(a); c = cellstr(b);
    idxs = transpose (a + 1);
    text(x(idxs), y(idxs), c);
    endif
    %Adjusting the axes
    axis ([cenVec(1) - sphRadius, cenVec(1) + sphRadius, ...
        cenVec(2)-sphRadius, cenVec(2)+sphRadius], 'square');
    %plotgreatcircnorth ('equalarea');
end

endfunction

