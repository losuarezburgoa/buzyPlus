function [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
    (projectionType, prinPlungeStepsGrad, noSecondScalePlungeGrad)
%
% Description:
% Creates a vector of values of the principal and secondary scales in order
% to plot grids or scales.
%
% Input(s):
% Primary scale steps of the trend, in sexagesimal degrees. The generation
% of points is independent of the spherical projection type
% (prinTrendStepsDeg). 
%
% Note: Secondary scale steps will be ever one fifth of the principal scale
% step. 
%
% Output(s):
% The trend grid vector of principal scale (equalTrendPrinVec) having points
% values to plot the radial lines of equal trend value. 
%
% The trend grid matrix of secondary scale (equalTrendSecondVec).
%
% Example1:
% In order to have a vector to generate a plunge scale of 10 degrees
% interval but avoinding points after 85 degree; type ...
% [ equalPlungePrinMat, equalPlungeSecondMatR ] =createplungevec( 'equalarea', 10, 85 );
%

%% Input management.
if nargin < 2
   prinPlungeStepsGrad =10;
   noSecondScalePlungeGrad =85;
end

%% General parameters.
%internal graphic control parameters
plungeStepsGrad =prinPlungeStepsGrad /5;
%number of secondary points
plungeNumPoints =floor(90 /plungeStepsGrad) +1;

%creating the trend-series and the plunge-series vectors
plungeGrad =linspace(0, 90, plungeNumPoints);

%% EQUAL-PLUNGE MATRIX
%creating the complete equal-plunge matrix(equalPlungeMatC)
trendGrad = 0;
equalPlungeMatC =zeros(length(trendGrad) ,2 *length(plungeGrad));
%filling the complete equal-plunge matrix
for i = 1 : length(plungeGrad)
    for j = 1 : length(trendGrad)
        switch projectionType 
            case {'equalarea'} 
                %[equalPlungeMatC(j, 2*i -1), equalPlungeMatC(j, 2*i)] = ...
            %equalareapolar2planepolar([trendGrad(j), plungeGrad(i)]);
                eqPlgMat = equalareapolar2planepolar([trendGrad(j), plungeGrad(i)]);
                equalPlungeMatC(j, 2*i -1) = eqPlgMat(1);
                equalPlungeMatC(j, 2*i) = eqPlgMat(2);
            case {'equalangle'} 
                %[equalPlungeMatC(j, 2*i -1), equalPlungeMatC(j, 2*i)] = ...
                eqPlgMat = equalanglepolar2planepolar([trendGrad(j), plungeGrad(i)]);
                equalPlungeMatC(j, 2*i -1) = eqPlgMat(1);
                equalPlungeMatC(j, 2*i) = eqPlgMat(2);
            otherwise 
                disp (['Option ''projectionType'' is wrong typed!']);
        endswitch
    end
endfor
sizeEPMatC = size(equalPlungeMatC);
%extracting the Primary Scale of concentric circles of equal-plunge
indexPp = 1:10:sizeEPMatC(2);
equalPlungePrinMat = zeros(sizeEPMatC(1), length(indexPp) * 2);
for i = 1 : length(indexPp)
    equalPlungePrinMat(:, 2*i-1 : 2*i) = ...
        equalPlungeMatC(:, indexPp(i) : indexPp(i) + 1);
endfor

%% Extracting the Secondary-Scale of concentric circles of equal-plunge
indexPs = zeros(1, (length(indexPp)-1) * 8);
for i = 1 : length(indexPp) - 1
    indexPs(8 * (i-1) + 1 : 8*i) = indexPp(i) + 2:1:indexPp(i+1) - 1;
endfor
equalPlungeSecondMat = zeros(sizeEPMatC(1), length(indexPs));
for i = 1 :length(indexPs)
    equalPlungeSecondMat(:, i) = equalPlungeMatC(:, indexPs(i));
endfor

%% Extracting dense information from the Secondary-Scale of concentric
%circles of equal-plunge
bp = (90 - noSecondScalePlungeGrad) / prinPlungeStepsGrad;
cp = floor(bp);
if cp == bp
    dp = 0;
else
    dp = 1;
endif
sustractNumberCols = (cp + dp) * 8;
sizeSecondPMat = size(equalPlungeSecondMat);

totalNumberNewCols = sizeSecondPMat(2) - sustractNumberCols;
mat1p = eye(totalNumberNewCols);
mat2p = zeros(sustractNumberCols, totalNumberNewCols);
reductionMatP = [mat1p; mat2p];
equalPlungeSecondMatR = equalPlungeSecondMat * reductionMatP;

endfunction