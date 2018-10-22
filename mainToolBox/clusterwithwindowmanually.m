function [clusteredTrendPlungeMat ,clusterIdVec , ...
    unClusteredTrendPlungeMat, unClusterIdVec, ...
    lowerWindowPointsMat, upperWindowPointsMat] = clusterwithwindowmanually ...
    (lowerRigthTrendPlungeVec, windowArc, otherExtremePlunge, typeOfWindow, ...
    clusterID, trendplungeMat, want2see)

## Description:
%Find out those poles that are inside a rectangular window cluster in the
%stereographic projection. In this case the cluster window is
%assigned with the lower left point, the arc angle, the other extreme
%plunge and the switch value to specify if the window crosses the
%boundary of the stereographic to appear in the opposite sector.
%
## Nested function(s):
%prepareorientationangles ,reduceminimal360angle ,obtain_clusteredpoles
%,calculateclustersubwindow ,plotplaneorientationdata ,polar2nepolar
%
## Input(s):
%Trend-plunge vector of the lower left point of the window
%(lowerRigthTrenPlungeVec).
%
%Arc angle of the window in hexagesimal angular grades (windowArc).The arc
%value may not be more than 180 ° if a double window is desired, or no more
%than 360 ° if single window is desired.
%
%Upper extreme value of the window, i.e. lowest plunge value
%(otherExtremePlunge).
%
%Switch (typeOfWindow) to specify if the window remains in the
%stereographic plot without crossing its boundary, making a single window
%('single' or 's') or it ultrapases the extreme boundary, making two
%windows ('double' or 'd'). 
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
%Matrix (o x 2) containing the north-east system polar coordinates of the
%points that conforms the window (lowerWindowPointsMat). If the cluster
%window is single, this matrix has the complete coordinates of the entire
%widow, if the cluster widow is double, this matrix has the coordinate
%points of the lower window.
%
%Matrix (p x 2) containing the north-east system polar coordinates of the
%points that conforms the window (upperWindowPointsMat). If the cluster
%window is single, this matrix is empty, if the cluster widow is double,
%this matrix has the coordinate points of the upper window.

%Example(s):
## trendplungeMat =[ 353 ,11 ;166 ,85 ;11 ,77 ;116 ,66 ;139 ,72 ;329 ,31 ; ...
#3    4, 49 ;9 ,85 ;113 ,67 ;263 ,10 ;315 ,33 ;263 ,10 ;152 ,72 ;158 ,84 ;126 ,48];

## Example 1:
## clusterwithwindowmanually ([320, 70], 50, 15, 'd', 1, trendplungeMat, true);

## Example 2:
## lowerRigthTrendPlungeVec = [175, 10];
## windowArc = 15;
## otherExtremePlunge = 5;
## typeOfWindow = 'd';
## clusterID = '1';
## want2see = true;


## Initial values transformation, preparing trend and plunge angles.
pTrendPlungeMat =prepareorientationangles( trendplungeMat );

initialTrend =lowerRigthTrendPlungeVec(1);
finalTrend =initialTrend +windowArc;

if otherExtremePlunge <=lowerRigthTrendPlungeVec(2)
    initialPlunge =lowerRigthTrendPlungeVec(2);
    finalPlunge =otherExtremePlunge;
else
    initialPlunge =otherExtremePlunge;
    finalPlunge =lowerRigthTrendPlungeVec(2);
end

switch typeOfWindow
    case {'Single' ,'single' ,'s' ,'S'}
        if windowArc >360
            error('This arc may not be more than 360�');
        end
        if finalTrend <360
            finalTrend =reduceminimal360angle(finalTrend);
            %Case 1a
            internalPlots =false;
            %Sub-window A
            %Calculating from the 2 basic points the rest points
            subWindowGradA =zeros(2);
            subWindowGradA(1 ,1) =initialTrend;
            subWindowGradA(1 ,2) =initialPlunge;
            subWindowGradA(2 ,1) =finalTrend;
            subWindowGradA(2 ,2) =finalPlunge;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatA ,unClusteredOrientMatA ] =obtain_clusteredpoles( pTrendPlungeMat ,subWindowGradA ,internalPlots );
            %Ploting sub-window
            [ pointsMat1A ,pointsMat2A ,pointsMat3A ,pointsMat4A ] =calculateclustersubwindow( subWindowGradA ,internalPlots );
            %
            %Total Values
            %Total cluster and unclustr matrices
            clusteredTrendPlungeMat =clusteredOrientMatA;
            unClusteredTrendPlungeMat =unClusteredOrientMatA;
            %Total window points
            lowerWindowPointsMat =[ pointsMat1A ;pointsMat2A ;pointsMat3A ;pointsMat4A ];
            upperWindowPointsMat =zeros(1,2);
        else
            %Case 1b
            finalTrend =reduceminimal360angle(finalTrend);
            internalPlots =false;
            %Sub-window A
            %Calculating from the 2 basic points the rest points
            subWindowGradA =zeros(2);
            subWindowGradA(1 ,1) =initialTrend;
            subWindowGradA(1 ,2) =initialPlunge;
            subWindowGradA(2 ,1) =360;
            subWindowGradA(2 ,2) =finalPlunge;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatA ,unClusteredOrientMatA ] =obtain_clusteredpoles( pTrendPlungeMat ,subWindowGradA ,internalPlots );
            %Ploting sub-window 
            [pointsMat1A, pointsMat2A, pointsMat3A, pointsMat4A] = calculateclustersubwindow( subWindowGradA ,internalPlots );
            %
            %Sub-window C
            %Calculating from the 2 basic points the rest points
            subWindowGradC =zeros(2);
            subWindowGradC(1 ,1) =0;
            subWindowGradC(1 ,2) =initialPlunge;
            subWindowGradC(2 ,1) =finalTrend;
            subWindowGradC(2 ,2) =finalPlunge;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatC ,unClusteredOrientMatC ] =obtain_clusteredpoles( unClusteredOrientMatA ,subWindowGradC ,internalPlots );
            %Ploting sub-window
            [ pointsMat1C ,pointsMat2C ,pointsMat3C ,pointsMat4C ] =calculateclustersubwindow( subWindowGradC ,internalPlots );
            %Total Values
            %Total cluster and unclustr matrices
            clusteredTrendPlungeMat =[clusteredOrientMatA ;clusteredOrientMatC];
            unClusteredTrendPlungeMat =unClusteredOrientMatC;
            %Total window points
            lowerWindowPointsMat =[pointsMat1A ;pointsMat2A ;pointsMat2C ;pointsMat3C ;pointsMat4C ;pointsMat4A];
            upperWindowPointsMat =zeros(1,2);
        end
    case {'Double' ,'double' ,'d' ,'D'}
        if windowArc >180
            error('This arc may not be more than 180!');
        end
        if finalTrend < 360
            %Case 1c
            finalTrend =reduceminimal360angle(finalTrend);
            internalPlots =false;
            %Sub-window A
            %Calculating from the 2 basic points the rest points
            subWindowGradA =zeros(2);
            subWindowGradA(1 ,1) =initialTrend;
            subWindowGradA(1 ,2) =initialPlunge;
            subWindowGradA(2 ,1) =finalTrend;
            subWindowGradA(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatA ,unClusteredOrientMatA ] =obtain_clusteredpoles( pTrendPlungeMat ,subWindowGradA ,internalPlots );
            %Ploting sub-window 
            [ pointsMat1A ,pointsMat2A ,pointsMat3A ,pointsMat4A ] =calculateclustersubwindow( subWindowGradA ,internalPlots );
            %
            %Sub-window B
            %Calculating from the 2 basic points the rest points
            subWindowGradB =zeros(2);
            subWindowGradB(1 ,1) =reduceminimal360angle( initialTrend +180 );
            subWindowGradB(1 ,2) =finalPlunge;
            subWindowGradB(2 ,1) =reduceminimal360angle( finalTrend +180 );
            subWindowGradB(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatB ,unClusteredOrientMatB ] =obtain_clusteredpoles( unClusteredOrientMatA ,subWindowGradB ,internalPlots );
            %Ploting sub-window
            [pointsMat1B, pointsMat2B, pointsMat3B, pointsMat4B] = calculateclustersubwindow (subWindowGradB, internalPlots); %%%
            %
            %Total Values
            %Total cluster and unclustr matrices
            clusteredTrendPlungeMat =[clusteredOrientMatA ;clusteredOrientMatB];
            unClusteredTrendPlungeMat =unClusteredOrientMatB;
            %Total window points
            lowerWindowPointsMat =[pointsMat3A ;pointsMat4A ;pointsMat1A];
            upperWindowPointsMat =[pointsMat3B ;pointsMat4B ;pointsMat1B];
            
            %plotclusterwindowpart (pointsMat3A, 'r*-');
            %plotclusterwindowpart (pointsMat4A, 'g*-');
            %plotclusterwindowpart (pointsMat1A, 'b*-');
            %plotclusterwindowpart (pointsMat3B, 'ro-');
            %plotclusterwindowpart (pointsMat4B, 'go-');
            %plotclusterwindowpart (pointsMat1B, 'bo-');
        else
            %Case 1D
            finalTrend =reduceminimal360angle(finalTrend);
            internalPlots =false;
            %Sub-window A
            %Calculating from the 2 basic points the rest points
            subWindowGradA =zeros(2);
            subWindowGradA(1 ,1) =initialTrend;
            subWindowGradA(1 ,2) =initialPlunge;
            subWindowGradA(2 ,1) =360;
            subWindowGradA(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatA ,unClusteredOrientMatA ] =obtain_clusteredpoles( pTrendPlungeMat ,subWindowGradA ,internalPlots );
            %Ploting sub-window 
            [ pointsMat1A ,pointsMat2A ,pointsMat3A ,pointsMat4A ] =calculateclustersubwindow( subWindowGradA ,internalPlots );
            %
            %Sub-window B
            %Calculating from the 2 basic points the rest points
            subWindowGradB =zeros(2);
            subWindowGradB(1 ,1) =reduceminimal360angle( initialTrend +180 );
            subWindowGradB(1 ,2) =finalPlunge;
            subWindowGradB(2 ,1) =180;
            subWindowGradB(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatB ,unClusteredOrientMatB ] =obtain_clusteredpoles( unClusteredOrientMatA ,subWindowGradB ,internalPlots );
            %Ploting sub-window
            [ pointsMat1B ,pointsMat2B ,pointsMat3B ,pointsMat4B ] =calculateclustersubwindow( subWindowGradB ,internalPlots );
            %
            %Sub-window C
            %Calculating from the 2 basic points the rest points
            subWindowGradC =zeros(2);
            subWindowGradC(1 ,1) =0;
            subWindowGradC(1 ,2) =initialPlunge;
            subWindowGradC(2 ,1) =finalTrend;
            subWindowGradC(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatC ,unClusteredOrientMatC ] =obtain_clusteredpoles( unClusteredOrientMatB ,subWindowGradC ,internalPlots );
            %Ploting sub-window
            [ pointsMat1C ,pointsMat2C ,pointsMat3C ,pointsMat4C ] =calculateclustersubwindow( subWindowGradC ,internalPlots );
            %
            %Sub-window D
            %Calculating from the 2 basic points the rest points
            subWindowGradD =zeros(2);
            subWindowGradD(1 ,1) =180;
            subWindowGradD(1 ,2) =finalPlunge;
            subWindowGradD(2 ,1) =reduceminimal360angle( finalTrend +180 );
            subWindowGradD(2 ,2) =0;
            %Obtaining values clustered in sub-window
            [ clusteredOrientMatD ,unClusteredOrientMatD ] =obtain_clusteredpoles( unClusteredOrientMatC ,subWindowGradD ,internalPlots );
            %Ploting sub-window
            [ pointsMat1D ,pointsMat2D ,pointsMat3D ,pointsMat4D ] =calculateclustersubwindow( subWindowGradD ,internalPlots );
            %
            %Total Values
            %Total cluster and unclustr matrices
            clusteredTrendPlungeMat =[clusteredOrientMatA ;clusteredOrientMatB ;clusteredOrientMatC ;clusteredOrientMatD];
            unClusteredTrendPlungeMat =unClusteredOrientMatD;
            %Total window points
            lowerWindowPointsMat =[pointsMat3C ;pointsMat4C ;pointsMat4A ;pointsMat1A];
            upperWindowPointsMat =[pointsMat3D ;pointsMat4D ;pointsMat4B ;pointsMat1B];
        end
    otherwise
        error('The typeOfWindow variable must be single (s) or double (d)')
end

## Constructing the cluster and uncluster vectors
clusterIdVec =zeros( size(clusteredTrendPlungeMat, 1) ,1 );
clusterIdVec(:) =clusterID;
unClusterIdVec =zeros( size(unClusteredTrendPlungeMat, 1) ,1 );

## Ploting
projType = 'equalarea';
if want2see ==true;
    hold on
    %Ploting the clustered ponts and the grid
    plotplaneorientationdata (clusteredTrendPlungeMat, projType, 'k^', 0, 5);
    %Ploting the unclustered ponts and the grid
    plotplaneorientationdata (unClusteredTrendPlungeMat, projType, 'ko', 0, 5);
    plotgreatcircnorth (projType);
    %Ploting the window
    %Graphic constants and options
    graphOptions = 'b-';
    sphRadius = 1;
    cenVec = zeros(1 ,2);
    %Transforming the nodes matrix from polar to north-east polar 
    toPlotMat01 = lowerWindowPointsMat;
    toPlotMat01(: ,1) = polar2nepolar( lowerWindowPointsMat(: ,1) );
    toPlotMat02 = upperWindowPointsMat;
    toPlotMat02(: ,1) = polar2nepolar( upperWindowPointsMat(: ,1) );
    ## Now ploting
    %polar (toPlotMat01(:,1), toPlotMat01(:,2), graphOptions);
    %polar (toPlotMat02(:,1), toPlotMat02(:,2), graphOptions);
    [x1, y1] = pol2cart(toPlotMat01);
    [x2, y2] = pol2cart(toPlotMat02);
    plot (x1, y1, graphOptions, 'LineWidth', 2);
    plot (x2, y2, graphOptions, 'LineWidth', 2);
    ## Adjusting the axes
    axis ([ cenVec(1)-sphRadius ,cenVec(1)+sphRadius ,cenVec(2)-sphRadius ,cenVec(2)+sphRadius ] ,'square' );
end

endfunction

