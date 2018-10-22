function [ equalTrendPrinVec, equalTrendSecondVec ] =createtrendvec ...
    ( prinTrendStepsDeg )
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
% In orde to have a vector to generate a trend scale of 10 degrees
% interval; it est, 18 positions ...
% [ equalTrendPrinVec, equalTrendSecondVec ] =createtrendvec( 10 );
%
%%%%%%%%%%%%%%%%
% [ equalTrendPrinVec, equalTrendSecondVec ] =createtrendvec;
%%%%%%%%%%%%%%%%

%% Input management.
if nargin < 1
   prinTrendStepsDeg =10;
end

%% General parameters.
%internal graphic control parameters
trendStepsGrad =prinTrendStepsDeg /5;
%number of secondary points
trendNumPoints = floor (360 / trendStepsGrad) + 1;

%creating the trend-series and the plunge-series vectors
trendGrad = linspace (0, 360, trendNumPoints);

%% Equal-trend vector.
% creating the complete equal-trend matrix (equalTrendMatC)
equalTrendMatC = zeros(1, 2 * length(trendGrad));
% filling the complete equal-trend matrix
for i = 1 : length(trendGrad)
%[ equalTrendMatC(1, 2*i-1), equalTrendMatC(1, 2*i) ] = ...
    eqTrgMat = equalareapolar2planepolar( [trendGrad(i), 0] );
    equalTrendMatC(1, 2 * i - 1) = eqTrgMat(1);
    equalTrendMatC(1, 2 * i) = eqTrgMat(2);
end
sizeETMatC =size(equalTrendMatC);
% extracting the Primary Scale of radial lines of equal-trend
indexTp =1:10:sizeETMatC(2);
equalTrendPrinMat =zeros(sizeETMatC(1) ,length(indexTp) *2);
for i=1 :length(indexTp)
    equalTrendPrinMat(:, 2*i-1:2*i) =equalTrendMatC(:, indexTp(i):indexTp(i)+1);
end

% extracting the Secondary-Scale of radial lines of equal-trend
indexTs =zeros(1,(length(indexTp)-1)*8);
for i=1 :length(indexTp)-1
    indexTs(8*(i-1)+1 :8*i) =indexTp(i)+2:1:indexTp(i+1)-1;
end
equalTrendSecondMat =zeros(sizeETMatC(1) ,length(indexTs));
for i=1 :length(indexTs)
    equalTrendSecondMat(: ,i) =equalTrendMatC(:, indexTs(i));
end

%% Final output variables.
equalTrendSecondVec =equalTrendSecondMat;
equalTrendPrinVec =equalTrendPrinMat;

end

