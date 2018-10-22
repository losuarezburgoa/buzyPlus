function [ equalPlungePrinMat, equalPlungeSecondMatR, equalTrendPrinMatR, ...
    equalTrendSecondMatR ] =createpolargrid( projectionType, ...
    prinTrendStepsGrad, prinPlungeStepsGrad, noSecondScalePlungeGrad, ...
    noSecondScaleTrendGrad, plotSecondScale, plotArgsSTR )
%
% Description:
% Create an equal-area or equal-angle polar grid.
%
% External sub-functions:
% equalareapolar2planepolar, plotnortheastpolarpoints,
% equalanglepolar2planepolar.
%
% Input(s):
% Type of desired projection, a string value between '...' (projectionType).
% For an equal-angle projection type 'equalangle' or for an equal-area
% projection type 'equalarea'.
%
% Primary scale steps of the trend, in hexagesimal grades
% (prinTrendStepsGrad). Secondary scale steps will be ever one fifth of
% the principal scale step.
%
% Primary scale steps of the plunge, in hexagesimal grades
% (prinPlungeStepsGrad). Secondary scale steps will be ever one fifth of
% the principal scale step.
%
% Plunge value (noSecondScalePlungeGrad), in hexagesimal grades ,upon where 
% secondary plunge scale must not be shown (normaly upon 80 grades).
%
% Plunge value (noSecondScaleTrendGrad), in hexagesimal grades ,upon where 
% secondary trend scale must not be shown (normaly upon 95 grades).
%
% A logical value to exorts to display secondary grid (plotSecondScale). If
% true it displays the secondary grid with gree lines.
%
% A structure wich will control the line colors, widths, and types of both
% the primary and secondary grids (plotArgsSTR).
%      plotArgsSTR.primScaleCell: cell of 1x2 that contain a chain of plot
%                                 specifications for the trend and plunge
%                                 of the primary grid.
%      plotArgsSTR.scndScaleCell: cell of 1x2 that contain a chain of plot
%                                 specifications for the trend and plunge
%                                 of the secondary grid.
%      For example:
%      plotArgsSTR =struct( 'primScaleCell', {{ '''-k''', '''-k''' }}, ...
%             'scndScaleCell', {{ ' ''-'', ''Color'', 0.8*ones(1,3) ', ...
%                                ' ''-'', ''Color'', 0.8*ones(1,3) ' }} );
%
% Output(s):
% The plunge grid matrix of principal scale (equalPlungePrinMat) having 
% points coordinates to plot the concetric circles of equal pluge value. 
% Each pair of consecutive columns gives the polar coordinates 
% (polar angle, radius) of a concentric circle.
%
% The plunge grid matrix of secondary scale (equalPlungeSecondMat).
%
% The trend grid matrix of principal scale (equalTrendPrinMat) having points
% coordinates to plot the radial lines of equal trend value. 
%
% The trend grid matrix of secondary scale (equalTrendSecondMat).
%
% Example1:
% createpolargrid('equalarea', 10, 10, 85, 85, true );
%
%%%%%%%%%%%%%%%%%%%%%
% createpolargrid( projectionType );
%%%%%%%%%%%%%%%%%%%%%

%% Input management.
% Default values of colors.
prinScaleColorsCell ={ '''-k''', '''-k''' };
scndScaleColorsCell ={ '''-g''', '''-g''' };

if nargin < 2
   prinTrendStepsGrad =10;
   prinPlungeStepsGrad =10;
   noSecondScalePlungeGrad =85;
   noSecondScaleTrendGrad =85;
   plotSecondScale =false;
   plotArgsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
        'scndScaleCell', {scndScaleColorsCell} );
elseif nargin < 7
   plotArgsSTR =struct( 'primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell} );
end
prinScalePlotArgsCella =plotArgsSTR.primScaleCell{1};
prinScalePlotArgsCellb =plotArgsSTR.primScaleCell{2};
scndScalePlotArgsCella =plotArgsSTR.scndScaleCell{1};
scndScalePlotArgsCellb =plotArgsSTR.scndScaleCell{2};

%% GENERAL PARAMETERS
%internal graphic control parameters
trendStepsGrad =prinTrendStepsGrad /5;
plungeStepsGrad =prinPlungeStepsGrad /5;
%number of secondary points
trendNumPoints =floor(360 /trendStepsGrad) +1;
plungeNumPoints =floor(90 /plungeStepsGrad) +1;

%creating the trend-series and the plunge-series vectors
trendGrad =linspace(0, 360, trendNumPoints);
plungeGrad =linspace(0, 90, plungeNumPoints);

%% EQUAL-PLUNGE MATRIX
%creating the complete equal-plunge matrix(equalPlungeMatC)
equalPlungeMatC =zeros(length(trendGrad) ,2 *length(plungeGrad));
%filling the complete equal-plunge matrix
for i=1 :length(plungeGrad)
    for j=1 :length(trendGrad)
        switch projectionType 
            case {'equalarea'} 
                %%[equalPlungeMatC(j, 2 * i -1), equalPlungeMatC(j, 2 * i)] = ...
                eqPlungMat = ...
                equalareapolar2planepolar ([trendGrad(j), plungeGrad(i)]);
                equalPlungeMatC(j,2*i -1) = eqPlungMat(1);
                equalPlungeMatC(j ,2 *i) = eqPlungMat(2);
            case {'equalangle'} 
                %%[equalPlungeMatC(j, 2 * i -1), equalPlungeMatC(j, 2 * i)] = ...
                eqPlungMat = ...
                equalanglepolar2planepolar ([trendGrad(j), plungeGrad(i)]);
                equalPlungeMatC(j,2*i -1) = eqPlungMat(1);
                equalPlungeMatC(j ,2 *i) = eqPlungMat(2);
            otherwise 
                disp (['Option' prkectionType 'is wrong typed']);
        end
    end
end
sizeEPMatC =size(equalPlungeMatC);
%extracting the Primary Scale of concentric circles of equal-plunge
indexPp =1:10:sizeEPMatC(2);
equalPlungePrinMat =zeros(sizeEPMatC(1) ,length(indexPp) *2);
for i=1 :length(indexPp)
    equalPlungePrinMat(: ,2*i-1:2*i) =equalPlungeMatC(:, indexPp(i):indexPp(i) +1);
end
%extracting the Secondary-Scale of concentric circles of equal-plunge
indexPs =zeros(1,(length(indexPp)-1)*8);
for i=1 :length(indexPp)-1
    indexPs(8*(i-1)+1 :8*i) =indexPp(i)+2:1:indexPp(i+1)-1;
end
equalPlungeSecondMat =zeros(sizeEPMatC(1) ,length(indexPs));
for i=1 :length(indexPs)
    equalPlungeSecondMat(: ,i) =equalPlungeMatC(:, indexPs(i));
end
%extracting dense information from the Secondary-Scale of concentric
%circles of equal-plunge
bp =(90 -noSecondScalePlungeGrad) /(prinPlungeStepsGrad);
cp =floor(bp);
if cp==bp
    dp=0;
else
    dp=1;
end
sustractNumberCols =(cp +dp)*8;
sizeSecondPMat =size(equalPlungeSecondMat);

totalNumberNewCols =sizeSecondPMat(2) -sustractNumberCols;
mat1p =eye(totalNumberNewCols);
mat2p =zeros(sustractNumberCols ,totalNumberNewCols);
reductionMatP =[mat1p; mat2p];
equalPlungeSecondMatR =equalPlungeSecondMat *reductionMatP;

%% EQUAL-TREND MATRIX
% creating the complete equal-trend matrix (equalTrendMatC)
equalTrendMatC =zeros(length(plungeGrad) ,2 *length(trendGrad));
% filling the complete equal-trend matrix
for i=1 :length(trendGrad)
    for j=1 :length(plungeGrad)
        switch projectionType 
            case {'equalarea'} 
                %[equalTrendMatC(j, 2*i-1), equalTrendMatC(j, 2*i)] = ...
                eqTrdMat = ...
                equalareapolar2planepolar ([trendGrad(i), plungeGrad(j)]);
                equalTrendMatC(j, 2*i-1) = eqTrdMat(1);
                equalTrendMatC(j, 2*i) = eqTrdMat(2);
            case {'equalangle'} 
                %[equalTrendMatC(j, 2*i-1), equalTrendMatC(j, 2*i)] = ...
                eqTrdMat = ...
                equalanglepolar2planepolar ([trendGrad(i), plungeGrad(j)]);
                equalTrendMatC(j, 2*i-1) = eqTrdMat(1);
                equalTrendMatC(j, 2*i) = eqTrdMat(2);
            otherwise 
                disp (['Option' prkectionType 'is wrong typed']);
        end
    end
end
sizeETMatC =size(equalTrendMatC);
% extracting the Primary Scale of radial lines of equal-trend
indexTp =1:10:sizeETMatC(2);
equalTrendPrinMat =zeros(sizeETMatC(1) ,length(indexTp) *2);
for i=1 :length(indexTp)
    equalTrendPrinMat(: ,2*i-1:2*i) =equalTrendMatC(:, indexTp(i):indexTp(i) +1);
end

% extracting the Secondary-Scale of radial lines of equal-plunge
indexTs =zeros(1,(length(indexTp)-1)*8);
for i=1 :length(indexTp)-1
    indexTs(8*(i-1)+1 :8*i) =indexTp(i)+2:1:indexTp(i+1)-1;
end
equalTrendSecondMat =zeros(sizeETMatC(1) ,length(indexTs));
for i=1 :length(indexTs)
    equalTrendSecondMat(: ,i) =equalTrendMatC(:, indexTs(i));
end
% extracting too dense information from the secondary equal-plunge matrix 
bt =(90 -noSecondScaleTrendGrad) /(prinPlungeStepsGrad /5);
ct =floor(bt);
if ct==bt
    dt=0;
else
    dt=1;
end
sustractNumberRows =(ct +dt);
sizeSecondTMat =size(equalTrendSecondMat);

totalNumberNewRows =sizeSecondTMat(1) -sustractNumberRows;
mat1t =eye(totalNumberNewRows);
mat2t =zeros(totalNumberNewRows, sustractNumberRows);
reductionMatT =[mat1t, mat2t];
equalTrendSecondMatR =reductionMatT *equalTrendSecondMat;

%% Extracting dense information from the principal equal-plunge matrix
sustractNumberPRows =round(sustractNumberRows /2);
sizeSecondTPMat =size(equalTrendPrinMat);

totalNumberNewPRows =sizeSecondTPMat(1) -sustractNumberPRows;
mat1pt =eye(totalNumberNewPRows);
mat2pt =zeros(totalNumberNewPRows, sustractNumberPRows);
reductionMatPT =[mat1pt, mat2pt];
equalTrendPrinMatR =reductionMatPT *equalTrendPrinMat;

%% PLOTING THE GRID.
% This will avoid to repeat a trend line in the zero (in the north).
equalTrendPrinMatR =equalTrendPrinMatR(:,1:(end-2));
% This will avoid to plot the external great circle.
equalPlungePrinMat =equalPlungePrinMat(:,3:end);

%Ploting the principal grid
hold on
eval( ['plotnortheastpolarpoints( equalPlungePrinMat, 2, ', prinScalePlotArgsCella, ' );'] );
eval( ['plotnortheastpolarpoints( equalTrendPrinMatR, 2, ', prinScalePlotArgsCellb, ' );'] );

%Ploting the secondary grid
if plotSecondScale ==true
    eval( ['plotnortheastpolarpoints( equalPlungeSecondMatR, 2, ', scndScalePlotArgsCella, ' );'] );
    eval( ['plotnortheastpolarpoints( equalTrendSecondMatR, 2, ', scndScalePlotArgsCellb, ' );'] );
end

end

