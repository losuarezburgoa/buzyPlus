function [correctedTrendPlungeVec, weigthFactorsVec, correctedN, ...
    sinOfDelta, cosineOfDelta] = correctbiasinscanlineorientations ...
    (trendPlungeMat, scanlineDirectionVec)

%
%Description:
%Correct by bias the orietation planes obtained in an scanline survey.
%
%Nested functions:
%trendplunge2unitvect, unitvect2trendplunge
%
%Input(s):
%Orientation of the planes given in pole trend-plunge format in a matrix 
%of nx2, where in the first column is given the trend and in the
%second column is given the plunge, both in hexadecimal angular grades (trendPlungeMat) 
%Orientation of the scan-line given by its trend and plunge (scanlineDirectionVec)
%
%Output(s):
%The corrected orientations of the planes given in a similar matrix as the
%input case (correctedTrendPlungeMat).
%The weigthed factors of each plane expressed in a column vector (weigthFactorsVec)
%The corrected number of discontinuity planes (correctedN)
%
## Example1:
## Borehole 1
## bhleAxisOrient1 = [030, 45];
## dipdirDip1Array = [182, 87; 172, 80; 187, 82; 200, 65; 197, 47; 232, 62; 196, 33; 203, 16; 268, 87; 278, 86; 229, 07; 129, 06; 253, 11; 289, 03; 036, 07; 295, 12; 335, 08; 360, 81; 353, 82; 355, 88; 096, 76; 092, 85];
##
## Borehole 2
## bhleAxisOrient2 = [150, 45];
## dipdirDip2Array = [176, 84; 182, 84; 179, 79; 090, 85; 086, 82; 267, 84; 270, 88; 203, 08; 177, 05; 083, 09; 272, 08; 329, 06; 051, 05; 014, 08; 351, 24; 327, 60; 335, 71; 012, 86; 357, 85; 003, 88];
## Borehole 3
## bhleAxisOrient3 = [270, 45];
## dipdirDip3Array = [178, 78; 153, 53; 121, 39; 094, 67; 093, 85; 089, 79; 085, 86; 060, 52; 057, 19; 147, 09; 113, 07; 176, 05; 064, 04; 240, 09; 002, 03; 001, 08; 311, 07; 266, 88; 268, 85; 271, 80; 275, 87];
##

## Transforming the scanline orientation in the unit vector format
scanlineUnitVec = trendplunge2unitvect ([scanlineDirectionVec(1), ...
    scanlineDirectionVec(2)]);

## Number of data.
matrixSize = size(trendPlungeMat);

%Transform trend-plunge information into unitary vector
unitaryVetorsMat = zeros(matrixSize(1), 3);
for i = 1 : matrixSize(1)
    temporalVec2 = ...
    trendplunge2unitvect ([trendPlungeMat(i,1), trendPlungeMat(i,2)]); 
    
    unitaryVetorsMat(i,1) = temporalVec2(1);
    unitaryVetorsMat(i,2) = temporalVec2(2);
    unitaryVetorsMat(i,3) = temporalVec2(3);
end
w =zeros(matrixSize(1),1);
%Obtaininig the w_{ji} vector
for i=1:matrixSize(1)
    temporalVec3 =[ unitaryVetorsMat(i,1) ,unitaryVetorsMat(i,2) ,unitaryVetorsMat(i,3)];
    cosineOfDelta =abs(dot(temporalVec3, scanlineUnitVec)) ./norm(temporalVec3) ./norm(scanlineUnitVec);
    w(i) =1 ./cosineOfDelta;
end

%Obtaining the b parameter, which is the total weighted sample size
%(weightedN)
weightedN =sum(w);


%Obtaining the vector of weight-factors (weigthFactorsVec)
weigthFactorsVec =zeros(matrixSize(1),1);
nu= matrixSize(1);
for i=1:matrixSize(1)
    weigthFactorsVec(i) =nu ./weightedN *w(i);
end
bMat =diag(weigthFactorsVec ,0);

%Calculating the corrected orientation planes (correctedTrendPlungeMat)
unitaryCorrectedVetorsMat =bMat *unitaryVetorsMat;
correctedTrendPlungeVec =zeros(matrixSize(1) ,2);
for i=1:matrixSize(1)
     temporalVec4=unitvect2trendplunge( unitaryCorrectedVetorsMat(i,:) );
     correctedTrendPlungeVec(i,1) =temporalVec4(1);
     correctedTrendPlungeVec(i,2) =temporalVec4(2);
end

%Obtaining the resultant vector
resultantVec =zeros(1 ,3);
for i=1:matrixSize(1)
     resultantVec =resultantVec +unitaryVetorsMat(i ,:);
end

%Calculating the corrected number of planes
sinOfDelta =norm( cross(resultantVec, scanlineUnitVec) )...
    ./norm(resultantVec) ./norm(scanlineUnitVec);
correctedN =nu ./sinOfDelta;

end

