function [clusterCentersTrendPlungeMat, clusteredValuesVec, totalNumberData, ...
    evaluatedAreaInPercent] = calculatekalsbeekmovingaverages (attitudeStructure)

%Description:
%Calculates the moving average values of orientation data using the
%Kalsbeek counting net.
%
%Input(s):
%Matrix nx5 representing the attitude data structure of a series of
%discsontinuities (attitudeStructure).
%
%Output(s):
%Matrix having the trend-plunge values of the orientation of the
%center of the couting clusters used to evaluate the moving average values
%(clusterCentersTrendPlungeMat) 
%
%Vector having the quantities of points encountered in each circular
%window whose axis are reffered in the 'clusterCentersTrendPlungeMat'
%(clusteredValues)
%
%Number of total data used in the calculation (totalNumberData). This value
%is equal to the number of data if the weigths by bias are equal to one for
%all datas, elsewhere it varies and is not an integer value.
%
%Area value of the cluster window given in percentaje of the total
%projected area (evaluatedAreaInPercent)
%
%Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ clusterCentersTrendPlungeMat ,clusteredValuesVec ,totalNumberData...
%    ,evaluatedAreaInPercent ] =calculatekalsbeekmovingaverages(
%    attitudeStructure )

%Transforming the Trend-Plunge of the attitudeStructure in x-y coordinates
planePolarMat =equalareatrendplunge2planepolar_array( attitudeStructure(:,1:2) );
[ xOrientations ,yOrientations ] = nepol2cart( planePolarMat(:,1) ,planePolarMat(:,2) );
xyOrientations =[ xOrientations ,yOrientations ];
preparedXyAttitudeStructure =[ xyOrientations ,attitudeStructure(:,3) .*attitudeStructure(:,4) ];
%plot( preparedXyAttitudeStructure(:,1) ,preparedXyAttitudeStructure(:,2) ,'o' );

%Creating the big total matrix
annulus =1:10;
pseudoRadius =1:10;
points =1:3;
coordinates =1:2;
types =1:2;
sectors =1:6;
totalCountMat =zeros( length(annulus) ,length(pseudoRadius) ,length(points) ,length(coordinates) ,length(types) ,length(sectors) );

%Filling the total counting matrix with the information
for i=1 :length(sectors)
 [ type2SubClusters ,type3SubClusters ] =create_kalsbeek_sector_countnet( i ,false );
 totalCountMat(:,:,:,:,1,i) =type2SubClusters;
 totalCountMat(:,:,:,:,2,i) =type3SubClusters;
end

%COUNTING THE VALUES CLUSTERED IN EACH SUB-CLUSTER
subclusterValuesMat=NaN( length(annulus) ,length(pseudoRadius) ,length(types) ,length(sectors) );
for i=1 : length(sectors)
    for j=1 : length(types)
        for k=1 :length(pseudoRadius)
            for l=1 :length(annulus)
                %Obtaining the three points matrix that defines each sub-cluster
                subClusterlocationVec =[ l ,k ,j ];
                t2SubClusters =squeeze( totalCountMat(: ,: ,: ,: ,1 ,i) );
                t3SubClusters =squeeze( totalCountMat(: ,: ,: ,: ,2 ,i) );
                %Creating the cluster contourn
                fifteenPointsMat =create_subcluster( subClusterlocationVec ,t2SubClusters, t3SubClusters ,false );
                [ x ,y ] =pol2cart( fifteenPointsMat(:,1) ,fifteenPointsMat(:,2) );
                xyFifteenPointsMat =[ x ,y ];
                %Obtaining the indexes of orientations inside the contourn
                if isnan( xyFifteenPointsMat(1,1) )
                    totalClusteredValue =NaN;
                else
                    insideIndexes =inpolygon( preparedXyAttitudeStructure(:,1) ,preparedXyAttitudeStructure(:,2) ,xyFifteenPointsMat(:,1) ,xyFifteenPointsMat(:,2) );
                    %Obtaining the number of orientations times the weigthed
                    %fators of orientations inside the contourn
                    clusteredXyAttStructurInside =preparedXyAttitudeStructure( insideIndexes, 3 );
                    totalClusteredValue =sum(clusteredXyAttStructurInside);
                end
                subclusterValuesMat( l ,k ,j ,i ) =totalClusteredValue;
            end
        end
    end
end

%OBTAINING THE CENTRAL POINTS MATRIX OF CLUSTERS
%The 'internalClusterCentersMat' variable is a 4D matrix (annulus x pseudo-radius-C x
%polar coordinates x sector)=(10 x 10 x 2 x 6)
internalClusterCentersMat =squeeze( totalCountMat(: ,: ,1 ,: ,1 ,:) );

%The 'borderClusterCentersMat' variable is a 3D matrix (pseudo-radius-C x polar
%coordinates x sector)=(10 x 2 x 6)
borderlineClusterCentersMat =squeeze( totalCountMat(10 ,: ,2 ,: ,1 ,:) );
lastPointClusterCenterMat =squeeze( totalCountMat(10 ,10 ,3 ,: ,1 ,:) );

%ClusterCentersMat is a 4D matrix structured by ( cicumference x
%pseudo-radius-C x coordinates x sector) =(11 x 11 x 2 x 6)
clusterCentersMat =NaN(11 ,11 ,2 ,6); 
clusterCentersMat(1:10 ,1:10 ,: ,:) =internalClusterCentersMat;
clusterCentersMat(11:11 ,1:10 ,: ,:) =borderlineClusterCentersMat;
clusterCentersMat(11:11 ,11:11 ,: ,:) =lastPointClusterCenterMat;

temporalMat =triu( NaN(11) );
for i=1 :6
    for j=1 :2
        clusterCentersMat(:,:,j,i) =clusterCentersMat(:,:,j,i) +temporalMat;
    end
end

%OBTAINING THE CENTRAL POINTS GLOBAL CLUSTERED VALUES MATRIX
%The 'valuesMat' variable is a 3D matrix (circumference x pseudo-radius-C x sector)=(11 x
%11 x 6)
valuesMat =NaN( 11, 11 ,6 );

%Region 1, defined by: circumferrence 1:1, pseudo-radius 1:1
centerValue =zeros(4,1);
for i=1 :6
    centerValue(i) =subclusterValuesMat( 1 ,1 ,1 ,i );
end
%Region 2, defined by: circumference (k) 2:10, pseudo-radius 1:1
for i=1 :6
    for k=2 :10
        %i for sectors
        %j for pseudoRadiusC
        %k for circumference
        valuesMat(k ,1 ,i) =subclusterValuesMat( k ,1 ,1, i )...
            +subclusterValuesMat( k ,1 ,2, i )...
            +subclusterValuesMat( k-1 ,1 ,1, i )...
            +subclusterValuesMat( k-1 ,k-1 ,1, reduceminimalanyinteger( 6 ,i-1 ) )...
            +subclusterValuesMat( k ,k-1 ,2, reduceminimalanyinteger( 6 ,i-1 ) )...
            +subclusterValuesMat( k ,k ,1, reduceminimalanyinteger( 6 ,i-1 ) );
    end
end
%Region 3, defined by: circumference (k) 3:10, pseudo-radius (j) 2:9
for i=1 :6
    for k=3 :10
        for j=2 :(k-1)
            %i for sectors
            %j for pseudoRadiusC
            %k for circumference
            valuesMat(k ,j ,i) =subclusterValuesMat( k ,j ,1, i )...
                +subclusterValuesMat( k ,j ,2, i )...
                +subclusterValuesMat( k ,j ,1, i )...
                +subclusterValuesMat( k ,j ,2, i )...
                +subclusterValuesMat( k ,j ,1, i )...
                +subclusterValuesMat( k ,j ,2, i );
        end
    end
end
%Region 5, defiend  by: circumference 11:11, pseudo-radius 2:10
for i=1 :6
    valuesMat(11 ,1 ,i) =subclusterValuesMat( 10 ,1 ,1, reduceminimalanyinteger( 6 ,i+3 ) )...
        +subclusterValuesMat( 10 ,1 ,2, reduceminimalanyinteger( 6 ,i+3 ) )...
        +subclusterValuesMat( 10 ,10 ,1, reduceminimalanyinteger( 6 ,i+2 ) )...
        +subclusterValuesMat( 10 ,9 ,2, reduceminimalanyinteger( 6 ,i+2 ) )...
        +subclusterValuesMat( 10 ,10 ,1, reduceminimalanyinteger( 6 ,i-1 ) )...
        +subclusterValuesMat( 10 ,1 ,1, i );
end
%Region 6, defined by: circumference 11:11, pseudo-radius 1:1
for i=1 :6
    for j=2 :10
        valuesMat(11 ,j ,i) =subclusterValuesMat( 10 ,j ,1 ,reduceminimalanyinteger( 6 ,i+3 ) )...
            +subclusterValuesMat( 10 ,j ,1, i )...
            +subclusterValuesMat( 10 ,j-1 ,2, i )...
            +subclusterValuesMat( 10 ,j-1 ,1, i )...
            +subclusterValuesMat( 10 ,j-1 ,1, reduceminimalanyinteger( 6 ,i+3 ) )...
            +subclusterValuesMat( 10 ,j-1 ,2, reduceminimalanyinteger( 6 ,i+3 ) );
    end
end
                       
%CONSTRUCTING THE clusterCentersTrendPlungeMat  AND clusteredValuesVec
%VARIABLES
numberOfPoints =sum( sum( ~isnan(clusterCentersMat(:,:,1)) ) )*6;
clusterCentersPolarMat =zeros( numberOfPoints ,2 );
clusteredValuesVec =zeros( numberOfPoints ,1 );

%Loading alpha values
%( cicumference=2:10, pseudo-radius-C x coordinates=2 x sector )
counter =1;
for k =2 :11
    for i=1 :6
        for j =1 :(k-1)
            clusterCentersPolarMat( counter ,1 ) =clusterCentersMat(k ,j ,1 ,i);
            clusterCentersPolarMat( counter ,2 ) =clusterCentersMat(k ,j ,2 ,i);
            clusteredValuesVec( counter ) =valuesMat(k ,j ,i);
            counter= counter +1;
        end
    end
end
clusterCentersPolarMat =[ [ 0 ,0 ] ;clusterCentersPolarMat ];
clusteredValuesVec =[ sum(centerValue) ;clusteredValuesVec ];
%polar( clusterCentersPolarMat(:,1) ,clusterCentersPolarMat(:,2) ,'+' );

clusterCentersTrendPlungeMat =zeros( size(clusterCentersPolarMat) );
for i=1 :size(clusterCentersPolarMat, 1)
    clusterCentersTrendPlungeMat(i,:) =planepolar2equalareapolar( clusterCentersPolarMat(i,1) ,clusterCentersPolarMat(i,2) );
end

totalNumberData =sum( attitudeStructure(:,3) .*attitudeStructure(:,4) );
evaluatedAreaInPercent =1;
end

