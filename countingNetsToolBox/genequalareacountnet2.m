## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} genequalareacountnet2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-23

function [coneAxisTrendPlungeMat, evaluatedCountCircAreaInPercent] = ...
    genequalareacountnet2 (countingCircleAreaInPercent, wantplot, projType)

## Input management.
if nargin < 1
    countingCircleAreaInPercent = 1;
    wantplot = false;
    projType = 'equalarea';
elseif nargin < 2
    wantplot = false;
    projType = 'equalarea';
elseif nargin < 3
    projType = 'equalarea';
endif
    
%Maximum great circle radius, i.e. radius of the reference sphere
greatCircleRadius =1;
%Area of the maximum great-circle (globalGcArea)
globalGcArea =pi *(greatCircleRadius)^2;

%Area and radius of the equal-area counting circle (countingEaCircleArea,
%countinigEaCircleRadius)
countingEaCircleArea =countingCircleAreaInPercent /100 *globalGcArea;
countingEaCircleRadius =sqrt( countingEaCircleArea /pi );

%Obtaining the 'pixelAreaInPercent' to use the
%'create_pixelgrid_any_homogeneus_value' function to generate the grid
initialPixelSide =2 *countingEaCircleRadius;
initialPixelArea =initialPixelSide ^2;
initialPixelAreaInPercent =initialPixelArea /globalGcArea *100;

%Creating the pixleGrid matrix
[ pixelsGrid ,pixelSide ]...
   =create_pixelgrid_any_homogeneus_value( true ,initialPixelAreaInPercent );
evaluatedEaCircleRadius =pixelSide /2;
%Re-evaluating the counting circle area and the percentage value
%(evaluatedCountCircAreaInPercent) 
evaluatedCountingEaCircleArea =pi *evaluatedEaCircleRadius .^2;
evaluatedCountCircAreaInPercent =evaluatedCountingEaCircleArea /globalGcArea *100;

%Obtaining the cone semiangle for the equal-area counting circle
%(countingConeSemiangleGrad) 
tpv =planepolar2equalareapolar( 0, evaluatedEaCircleRadius );
resultOfBetaGrad =tpv(2);
evaluatedCountingConeSemiangleGrad =90 -resultOfBetaGrad;

%CREATING THE XY MATRIX
%Obtaining the cuadrandt information
a =size(pixelsGrid ,1) /2;
upperLeftQuadrant =pixelsGrid( 1 :a ,1 :a );

%Creating one quadrant matrix
[X, Y]=find(upperLeftQuadrant ==1);
xyQuadrantPointsMat =[X(:)-1 ,Y(:)-1] *pixelSide;
xyQuadrantPointsMat(: ,1) =1 -xyQuadrantPointsMat(:,1);
xyQuadrantPointsMat(: ,2) =1 -xyQuadrantPointsMat(:,2);

%Creating axis matrices
xyVerticalAxisMat =[zeros(a,1) ,transpose( linspace(1, a, a)*pixelSide )];
xyHorizontalAxisMat =fliplr(xyVerticalAxisMat);

%Creating the four quadrant matices
xyPtsUpLeft =[ xyQuadrantPointsMat(:,1)*-1 ,xyQuadrantPointsMat(:,2) ];
xyPtsUpRigth =xyQuadrantPointsMat;
xyPtsDownLeft =xyQuadrantPointsMat *-1;
xyPtsDownRigth =xyPtsUpLeft *-1;

%Creating the xy matrix
xyAxisMat =[xyPtsUpLeft ;xyVerticalAxisMat; [0,0]; xyPtsUpRigth; ...
    -xyHorizontalAxisMat; xyHorizontalAxisMat; xyPtsDownLeft; ...
    -xyVerticalAxisMat; xyPtsDownRigth];

%CREATING THE CIRCUNSCRIBED POLAR MATRIX
[theta ,rho] =cart2nepolnuevo( xyAxisMat(:,1) ,xyAxisMat(:,2) );
polPointsMat =[theta ,rho];
numberPoints =size(polPointsMat ,1);
for i=1 :numberPoints
    if polPointsMat(i,2) >2/sqrt(2)
        polPointsMat(i,2) =2/sqrt(2);
    end
end
polPointsMat =sortorientations( polPointsMat );

%TRANSFERING THE GRID POINTS THAT ARE OUTSIDE BUT NEAR THE MAJOR GREAT
%CIRCLE TO THE DIAMETRAL OPPOSITE SIDE
numberPoints =size(polPointsMat ,1);
for i=1 :numberPoints
    if polPointsMat(i,2) >1
        temporalTheta =reduceminimal2piangle( polPointsMat(i,1) +pi );
        temporalTrendPlungeVec =planepolar2equalareapolar( 0 ,polPointsMat(i,2) );
        tRhoArray = equalareapolar2planepolar( [0 ,-temporalTrendPlungeVec(2)] );
        t = tRhoArray(1);
        temporalRho = tRhoArray(2);
        polPointsMat(i,1) =temporalTheta;
        polPointsMat(i,2) =temporalRho;
    end
end

%CREATING THE CIRCUMSCRIBED POLAR MATRIX
circumscribedPolPtsMat =sortorientations( polPointsMat );

%CREATING THE TREND-PLUNGE MATRIX
%Back calculation of trend-plunge from polar matrix
coneAxisTrendPlungeMat =planepolar2equalareatrendplunge_array( circumscribedPolPtsMat );
coneAxisTrendPlungeMat =sortorientations( coneAxisTrendPlungeMat );

## Plotting.
if wantplot
    hold on
    plotplaneorientationdata (coneAxisTrendPlungeMat, projType, 'x', 0, 5);
endif

endfunction
