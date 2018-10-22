function [finalUnitPercentArea, areaFactorVec, numHalfRegVec, ...
    vertexTrendPlunge3dMat, centerPtsTrendPlungeMat, areaFactorVecById] ...
    = createcountingequalareanet (equalareaPercentaje, want2plot)

%Description:
%Create the equal-area counting net in the stereographical equal-area
%projection.
%
%Nested function(s):
%Paul Leopardi: eq_regions, eq_point_set_polar (by Paul Leopardi) and
%their minimum necessary nested functions to work only with a sphere:
%area_of_cap, area_of_collar, area_of_ideal_region, area_of_sphere,
%bot_cap_region, cap_colats, centres_of_regions, circle_offset, eq_caps,
%eq_point_set_polar, eq_regions, ideal_collar_angle, ideal_region_list,
%num_collars, partition_options, polar_colat, round_to_naturals,
%sphere_region, sradius_of_cap, top_cap_region.
%Actual code: isevennumber, polar2nepolar ,equalareapolar2planepolar
%,plotnortheastpolarpoints ,acuteclockwisearc ,calculatepointsnecirculararc
%,cart2nepol.
%
%Input(s):
%Area of the unit counting area expressed as percentage of the total
%half hemisphere area. Normally it varies from 1% to 0,1%, but the program
%admits any value equal or less to 100%.
%Logical value if it is desired to plot the net, for 'true'; or not for
%'false'.  
%
%Output(s):
%Value of the final and corrected area percent (finalUnitPercentArea).
%Vector, of dimension 'number of collars +1', of the area-factors for all
%the collars and bottom cap (areaFactorVec). Only the fisrt element of the
%vector varies from1 to 0.5 depending if the extreme collar shares the
%upper and lower hemisphere.
##
%Vector, of dimension 'number of collars 1', having integer numbers that
%indicates how many regions it has each collar (numHalfRegVec).
##
## Three dimensional matrix (2 x 2 x n) of the vertex points of each region,
%expressed in trend/plunge values. The first column gives the trend angle and
%the second column the plunge angle. Rows from 1 up to 2 are the two
%opposite vertex points that defines each region. All these for the total
%number of the regions (n) (vertexTrendPlunge3dMat).
%Matrix (n x 2) of the center points of each region, expressed in
%trend/plunge values, where n is the number of regions. In the first column
%the trend angle is specified and in the second column the plunge angle
%(centerPtsTrendPlungeMat). 

## Example 1:
## equalareaPercentaje = 1;
## want2plot = false;

## Input management.
if nargin < 2
    want2plot = false;
endif

%Calculating the total number of segments in the whole sphere
seedHalfSphereNumSegs = round(100 /equalareaPercentaje);
finalUnitPercentArea =1 /seedHalfSphereNumSegs *100;

totalSphereNumSegs =2 *seedHalfSphereNumSegs;

[vertexEspherical3dMat, numCapsVec ,numRegVec] = eq_regions(totalSphereNumSegs);
centerPointsMat =eq_point_set_polar(totalSphereNumSegs);

%Obtaining only the half bottom sphere
%numberOfRegions =size(vertexEspherical3dMat ,3);
numberOfRegions =sum(numRegVec);
numberOfCollars =length(numCapsVec);

numOfCompleteRegions =sum( numRegVec(1 :floor(numberOfCollars /2)) );
numOfSharedRegions =numberOfRegions -2 *numOfCompleteRegions;

%Obtaining the segments of the half lower hemisphere
vertexHalfEsph3dMat = vertexEspherical3dMat(: ,: ,numOfCompleteRegions +1 :numberOfRegions);
vertexHalfEsph3dMat(2 ,1 ,1:numOfSharedRegions) =pi /2;
%Obtaining the center points of the half lower hemisphere segments
centerPointsHalfMat = centerPointsMat(:, numOfCompleteRegions +1 :numberOfRegions);
numOfHalfRegions =size(centerPointsHalfMat,2);

%Vector containing the number of regions per collar
if isevennumber(numberOfCollars)
    numOfHalfCollars =floor(length(numCapsVec)/2) +1;
    borderAreaFactor =0.5;
else
    numOfHalfCollars =length(numCapsVec)/2;
    borderAreaFactor =1;
end
a= numberOfCollars -numOfHalfCollars +1;
numHalfRegVec =numRegVec(a :end);

%Creating the area-factor vector
areaFactorVec =zeros( 1 ,numOfHalfCollars );
areaFactorVec(1) =borderAreaFactor;
for i = 2 : numOfHalfCollars
    areaFactorVec(i) =1;
end

%Transform all points from espherical coordinates to trend-plunge values
vertexTrendPlunge3dMat =zeros(2,2,numOfHalfRegions);
centerPtsTrendPlungeMat =zeros(2,numOfHalfRegions);
for i=1:numOfHalfRegions
    for j=1:2
        %the vertex
        vertexTrendPlunge3dMat(1,j,i) =polar2nepolar(vertexHalfEsph3dMat(1,j,i)) *180 /pi;
        vertexTrendPlunge3dMat(2,j,i) =(vertexHalfEsph3dMat(2,j,i) -pi/2) *180 /pi;
    end
        %the center points
        centerPtsTrendPlungeMat(1,i) =polar2nepolar(centerPointsHalfMat(1,i)) *180 /pi;
        centerPtsTrendPlungeMat(2,i) =(centerPointsHalfMat(2,i) -pi/2) *180 /pi;
end

## This is a vectro that gives the factor area for each index.
areaFactorVecById = zeros(1,sum(numHalfRegVec));
kf = cumsum(numHalfRegVec);
ki = [0, kf(1:end-1)] +1;
for k = 1: 1: length(numHalfRegVec)
    afVec = ones(1, numHalfRegVec(k)) * areaFactorVec(k);
    areaFactorVecById(ki(k):kf(k)) = afVec;
endfor

%%%%%%%%%%%%%%%%%%%%%
%FROM HERE THE CALCULATIONS ARE TO ATTAIN THE PLOT
if want2plot == true
    %Calculate the polar coordinates projected in the horizontal plane with the
    %equal area concept, of the vertexes and center points
    vertexEqualArea3dMat = zeros(2, 2, numOfHalfRegions);
    centerEqualAreaPointsMat = zeros(numOfHalfRegions, 2);
    for i = 1 : numOfHalfRegions
        for j = 1 : 2
            # The vertex 3D mat
            %[vertexEqualArea3dMat(1,j,i), vertexEqualArea3dMat(2,j,i)] = ...
            vrtxEA3dM = equalareapolar2planepolar ...
                ([vertexTrendPlunge3dMat(1,j,i), vertexTrendPlunge3dMat(2,j,i)]);
            vertexEqualArea3dMat(1,j,i) = vrtxEA3dM(1);
            vertexEqualArea3dMat(2,j,i) = vrtxEA3dM(2);
        end
        # The center points
        %[centerEqualAreaPointsMat(i, 1), centerEqualAreaPointsMat(i, 2)] = ...
        cntrEAptsM = equalareapolar2planepolar ...
            ([centerPtsTrendPlungeMat(1,i), centerPtsTrendPlungeMat(2,i)]);
        centerEqualAreaPointsMat(i ,1) = cntrEAptsM(1);
        centerEqualAreaPointsMat(i, 2) = cntrEAptsM(2);
    end

    %Sphere radius
    sphereRadius = 1;

    %Ploting the center points
    [xc, yc] = plotnortheastpolarpoints (centerEqualAreaPointsMat, 2*sphereRadius, 'k+' );
    # Ploting the ids.
    a = transpose(1:1:length(xc)); b = num2str(a); c = cellstr(b);
    dx = 0; dy = 0;
    text(xc + dx, yc + dy, c);

    %Ploting the vertex points
    vertexEqualAreaMat =zeros(numOfHalfRegions,2);
    vertexEqualAreaMat(:,1)  =vertexEqualArea3dMat(1,1,:);
    vertexEqualAreaMat(:,2)  =vertexEqualArea3dMat(2,1,:);
    plotnortheastpolarpoints( vertexEqualAreaMat, 2 *sphereRadius , 'k.' );

    %Creating and plotting the radial lines
    radialLineMat =zeros( 2 ,numOfHalfRegions *4 );
    for i =1:numOfHalfRegions
        radialLineMat(:,4*i-3) =vertexEqualArea3dMat(1,1,i);
        radialLineMat(:,4*i-1) =vertexEqualArea3dMat(1,2,i);
        radialLineMat(1,4*i-2) =vertexEqualArea3dMat(2,1,i);
        radialLineMat(1,4*i-0) =vertexEqualArea3dMat(2,1,i);
        radialLineMat(2,4*i-2) =vertexEqualArea3dMat(2,2,i);
        radialLineMat(2,4*i-0) =vertexEqualArea3dMat(2,2,i);
    end
    plotnortheastpolarpoints( radialLineMat, 2 *sphereRadius , 'r-' );

    %Creating and ploting the circular arcs
    centerVec =[0 ,0];
    resolution =72;
    want2see =false;

    concentricCartArcsMat= zeros(resolution+2, numOfHalfRegions *2);
    escalarVec =zeros(1,numOfHalfRegions);

    for i =1:numOfHalfRegions
        radius =vertexEqualArea3dMat(2,1,i);
        [ arcAngleRad ,initialArcAngleRad ] = acuteclockwisearc( vertexEqualArea3dMat(1,1,i) ,vertexEqualArea3dMat(1,2,i) );
        [mat ,escalar ] =calculatepointsnecirculararc...
            ( radius, arcAngleRad, initialArcAngleRad, centerVec, resolution, want2see );
        concentricCartArcsMat(1:escalar ,2*i-1) =mat(: ,1);
        concentricCartArcsMat(1:escalar ,2*i) =mat(: ,2);
        escalarVec(i) =escalar;
    end

    concentricArcsMat =zeros(resolution+2, numOfHalfRegions *2);
    for i =1:numOfHalfRegions
        %Changing from cartesian coordinates to polar
        [concentricArcsMat(: ,2*i-1) ,concentricArcsMat(: ,2*i)]...
            =cart2nepolnuevo ( concentricCartArcsMat(: ,2*i-1) ,concentricCartArcsMat(: ,2*i) );
        %Plotting the cicular arcs
        plotnortheastpolarpoints( [concentricArcsMat(1:escalarVec(i) ,2*i-1) ,concentricArcsMat(1:escalarVec(i) ,2*i)], 2 *sphereRadius , 'k-' );
    
    end
end

endfunction


