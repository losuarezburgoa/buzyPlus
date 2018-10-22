function [ clusteredOrientationsMat ,unClusteredOrientationsMat ] ...
   =obtain_clusteredpoles( trendPlungeMat ,extremePointsMatGrad ,want2see )
%lsbcode
%[ clusteredOrientationsMat ,unClusteredOrientationsMat ] ...
%  =obtain_clusteredpoles( trendPlungeMat ,extremePointsMatGrad ,want2see )
%
%Description:
%Obtains the orientation poles, in trend-plunge format, that are clustered
%inside the window, referenced by their two oposite extreme points.
%This is a fuction to be used for the 'clusterwithwindowmanually'
%function (i.e. sub-funtion) because this has restrictions in the
%calculations. It only works correctly for acute sectors (i.e. sector with
%no more than 180� of arc). For sectors not cuttig the north axis (i.e.
%initial trend less than 360� and final trend numerically always greater
%than the initial but less or equal to 360�.
%Do not use this functions for generic calculation!
%
%Nested function(s):
%equalareapolar2planepolar ,calpointsnecirculararcpol ,polar2nepolar.
%
%Input(s):
%Matrix of extreme points (2 x 2), where the first and second rows
%represent respectively the initial low-left point and the final
%upper-rigth points of the window (extremePointsMatRad). The first column
%has the trend values and the second the plunge values, all in hexagesimal
%angular grades. 
%
%Logical variable to chose of if it is desired to plot in a Figure the resulting
%window (want2see), by giving a true value; otherwise, give a false value.
%
%Output(s):
%Matrix (n x 2) of the trend-plunge values that are clustered by the window
%(clusteredOrientationsMat). 
%
%Example:
%trendPlungeMat =[ 353 ,11 ;166 ,85 ;11 ,77 ;116 ,66 ;139 ,72 ;329 ,31 ;4
%,49 ;9 ,85 ;113 ,67 ;263 ,10 ;315 ,33 ;263 ,10 ;152 ,72 ;158 ,84 ;126 ,48 ] 
%[ c, u ] =obtain_clusteredpoles(trendPlungeMat ,[ 0 ,85 ;156 ,60 ] ,true ) 
%It gives:  [ 11 ,77; 113 ,67 ;116 ,66 ;139 ,72 ;152 ,72 ]
%%%%%%%%%%%%%%%%%%%%%%%%
%[ clusteredOrientationsMat ,unClusteredOrientationsMat ] ...
%  =obtain_clusteredpoles( trendPlungeMat ,extremePointsMatGrad ,want2see )

%Trend-plunge nodes matrix (Here is constructed the matrix of the four
%points that conforms the window)
nodesMatrix =zeros(4,2);
nodesMatrix(1, :) =extremePointsMatGrad(1 ,:);
nodesMatrix(2 ,1) =extremePointsMatGrad(1 ,1);
nodesMatrix(2 ,2) =extremePointsMatGrad(2 ,2);
nodesMatrix(3 ,:) =extremePointsMatGrad(2 ,:);
nodesMatrix(4 ,1) =extremePointsMatGrad(2 ,1);
nodesMatrix(4 ,2) =extremePointsMatGrad(1 ,2);

%Matrix of clustered data
indexes1 =find( trendPlungeMat(:,1) >=nodesMatrix(1,1) );
l1 =length(indexes1);
greaterClusMinTrendMat =zeros(l1, 2);
for i=1 :l1
    greaterClusMinTrendMat(i ,:) =trendPlungeMat(indexes1(i) ,:);
end

indexes2 =find( greaterClusMinTrendMat(:,1) <nodesMatrix(3,1) );
l2 =length(indexes2);
leastClusMaxTrendMat =zeros(l2, 2);
for i=1 :l2
    leastClusMaxTrendMat(i ,:) =greaterClusMinTrendMat(indexes2(i) ,:);
end

indexes3 =find( leastClusMaxTrendMat(:,2) <nodesMatrix(1,2) );
l3 =length(indexes3);
greaterClusMinPlungeMat =zeros(l3, 2);
for i=1 :l3
    greaterClusMinPlungeMat(i ,:) =leastClusMaxTrendMat(indexes3(i) ,:);
end

indexes4 =find( greaterClusMinPlungeMat(:,2) >=nodesMatrix(3,2) );
l4 =length(indexes4);
leastClusMaxPlungeMat =zeros(l4, 2);
for i=1 :l4
    leastClusMaxPlungeMat(i ,:) =greaterClusMinPlungeMat(indexes4(i) ,:);
end

%Matrix of unclustered data
indexes1 =find( trendPlungeMat(:,1) <nodesMatrix(1,1) );
l1 =length(indexes1);
leastUnclustMinTrendMat =zeros(l1, 2);
for i=1 :l1
    leastUnclustMinTrendMat(i ,:) =trendPlungeMat(indexes1(i) ,:);
end

indexes2 =find( trendPlungeMat(:,1) >=nodesMatrix(3,1) );
l2 =length(indexes2);
greaterUnclustMaxTrendMat =zeros(l2, 2);
for i=1 :l2
    greaterUnclustMaxTrendMat(i ,:) =trendPlungeMat(indexes2(i) ,:);
end

trendUnclustMat =[leastUnclustMinTrendMat ;greaterUnclustMaxTrendMat];
indexes3 =find( trendUnclustMat(:,2) >nodesMatrix(3,2) );
l3 =length(indexes3);
greaterMinTrendUnclustMat =zeros(l3, 2);
for i=1 :l3
    greaterMinTrendUnclustMat(i ,:) =trendUnclustMat(indexes3(i) ,:);
end

indexes4 =find( greaterMinTrendUnclustMat(:,2) <=nodesMatrix(1,2) );
l4 =length(indexes4);
greaterMaxTrendUnclustMat =zeros(l4, 2);
for i=1 :l4
    greaterMaxTrendUnclustMat(i ,:) =greaterMinTrendUnclustMat(indexes4(i) ,:);
end


indexes5 =find( trendPlungeMat(:,2) >=nodesMatrix(1,2) );
l5 =length(indexes5);
leastUnclustMinPlungeMat =zeros(l5, 2);
for i=1 :l5
    leastUnclustMinPlungeMat(i ,:) =trendPlungeMat(indexes5(i) ,:);
end

indexes6 =find( trendPlungeMat(:,2) <nodesMatrix(3,2) );
l6 =length(indexes6);
greaterUnclustMaxPlungeMat =zeros(l6, 2);
for i=1 :l6
    greaterUnclustMaxPlungeMat(i ,:) =trendPlungeMat(indexes6(i) ,:);
end

unClusteredunSortedOrientMat =[greaterMaxTrendUnclustMat ;leastUnclustMinPlungeMat ;greaterUnclustMaxPlungeMat];

%Sorting the final matrix
clusteredOrientationsMat =sortorientations( leastClusMaxPlungeMat );
unClusteredOrientationsMat =sortorientations( unClusteredunSortedOrientMat );

%Plotting the poles inside the window
if want2see == true
    plotplaneorientationdata (clusteredOrientationsMat, 'equalarea', 'k+', true);
    plotplaneorientationdata (unClusteredOrientationsMat, 'equalarea', 'ro', false);
end
end

