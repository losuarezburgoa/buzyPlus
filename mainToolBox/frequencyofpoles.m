function [ meanTrendPlungeMat ,frequencyValuesVec ] =frequencyofpoles ...
    ( poleTrendPlungeMat, weigthedValuesVec, areaAnalysisPercentage )
%
% Description:
% Obtains the frequency of each trend-plunge interval
%
% Input(s):
% The analysis area given as a percentaje of the total projected area,
% normally is 1% (areaAnalysisPercentage) 
%
% Output(s):

sphereRadius =1;

%Transform the trend-plunge matrix into a NE polar angular-radious matrix
matrixSize =size(poleTrendPlungeMat);
thetaRhoMat =zeros(matrixSize(1) ,2);
for i=1:matrixSize(1)
    [ angleThetaRad, rho ] =equalareapolar2planepolar...
        ( [poleTrendPlungeMat(i,1) ,poleTrendPlungeMat(i,2)] ); 
    thetaRhoMat(i,1) =angleThetaRad;
    thetaRhoMat(i,2) =rho;
end

%Analysis area value
analysisArea =pi *sphereRadius^(2);

%area of a sector
sectorArea =sectorAngleRad /2 *(externalRadius^(2) -internalRadius^(2));


%Calculate the extreme opposite two points forming a constant area of the
%equal-area region 

%Create the area structure, where in each row is specified: the area id
%number, the inferior point id, the superior point id. It is a
%number-of-areas x 3 matrix.

%For each point obtain by searching the area id to it belongs.


end

