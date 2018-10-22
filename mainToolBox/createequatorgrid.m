function [equalDipPrinMatR, equalDipSecondMatR, equalPitchPrinMatR, ...
    equalPitchSecondMatR] = createequatorgrid (projectionType, ...
    prinPitchStepsGrad, prinDipStepsGrad, noSecondScaleDipGrad, ...
    noSecondScalePitchGrad, plotSecondScale, plotArgsSTR)

% Description:
% Create an equal-angle or equal-area equatorial grid
%
% External sub-function(s):
% pitchdipdirdip2trendplunge, equalanglepolar2planepolar,
% plotnortheastpolarpoints, equalareapolar2planepolar
%
% Input(s):
% Type of desired projection, a string value between '...' (projectionType).
% For an equal-angle projection type 'equalangle' or for an equal-area
% projection type 'equalarea'.
%
% Primary scale steps of the pitch, in hexagesimal grades
% (prinPitchStepsGrad). This should be a submultiple of 90 (e.g. 2.5, 5, 10,
% 15, 30 or 45). Secondary scale steps will be ever one fifth of the
% principal scale step. Normally use 10.
%
% Primary scale steps of the dip, in hexagesimal grades
% (prinDipStepsGrad). This should be also a submultiple of 90 (e.g. 2.5, 5,
% 10, 15, 30 or 45). Secondary scale steps will be ever one fifth of the
% principal scale step. Normally use 10.
%
% Pitch value (noSecondScaleDipGrad), in hexagesimal grades ,until where 
% secondary dip scale must not be shown. This begins from 0 up to 90, and
% normaly is 5.
%
% Pitch value (noSecondScalePitchGrad), in hexagesimal grades ,until where 
% secondary trend scale must not be shown (normaly upon 5 grades).
% A logical value to exorts to display secondary grid (plotSecondScale). If
% true it displays the secondary grid.
%
% Output(s):
% The dip grid matrix of principal scale (equalDipPrinMatR) having 
% points coordinates to plot the great curves of equal dip value. 
%
% Each pair of consecutive columns gives the polar coordinates 
% (polar angle, radius) of the trace plane.
%
% The dip grid matrix of secondary scale (equalDipSecondMatR).
%
%The pitch grid matrix of principal scale (equalPitchPrinMat) having points
%coordinates to plot the small curves of equal pitch value. 
%
%The pitch grid matrix of secondary scale (equalPitchSecondMat).
%
% Example1:
%projectionType = 'equalangle';
%[Dp, Ds, Pp ,Ps] = createequatorgrid('equalarea', 10, 10, 5, 5, true);
%

%% Input management.
% Default values of colors.
prinScaleColorsCell = {'''-k''', '''-k'''};
scndScaleColorsCell = {'''-g''', '''-g'''};

if nargin < 2
    prinPitchStepsGrad = 10;
    prinDipStepsGrad = 10;
    noSecondScaleDipGrad = 5;
    noSecondScalePitchGrad = 5;
    plotSecondScale = true;
    plotArgsSTR = struct('primScaleCell', {prinScaleColorsCell}, ...
        'scndScaleCell', {scndScaleColorsCell});
elseif nargin < 7
   plotArgsSTR = struct('primScaleCell', {prinScaleColorsCell}, ...
       'scndScaleCell', {scndScaleColorsCell});
endif

prinScalePlotArgsCella = plotArgsSTR.primScaleCell{1};
prinScalePlotArgsCellb = plotArgsSTR.primScaleCell{2};
scndScalePlotArgsCella = plotArgsSTR.scndScaleCell{1};
scndScalePlotArgsCellb = plotArgsSTR.scndScaleCell{2};

%% General parameters.
%internal graphic control parameters
pitchStepsGrad = prinPitchStepsGrad / 5;
dipStepsGrad = prinDipStepsGrad / 5;
%number of secondary points
pitchNumPoints = floor(180 / pitchStepsGrad) + 1;
dipNumPoints = floor(90 / dipStepsGrad) + 1;

%% EQUAL-DIP MATRIX.

%East Side
%creating the trend-series and the plunge-series vectors
pitchGradE = linspace(0, 180, pitchNumPoints);
dipGradE = linspace(0, 90, dipNumPoints);
%creating the trend -plunge matrix
trendPlungeMatDHE = zeros(length(pitchGradE) , 2 *length(dipGradE));
%creating the half equal-dip matrix(equalDipMatH)
equalDipMatHE = zeros(length(pitchGradE) ,2 *length(dipGradE));
%filling the half equal-plunge matrix
for i=1 :length(dipGradE)
    for j=1 :length(pitchGradE)
        [ trendPlungeMatDHE(j ,2*i -1) ,trendPlungeMatDHE(j ,2 *i) ] =...
            pitchdipdirdip2trendplunge( pitchGradE(j) , [90 ,dipGradE(i)] );
        switch projectionType 
            case {'equalarea'} 
                %[equalDipMatHE(j, 2*i-1), equalDipMatHE(j, 2*i)] = ...
            eqDpMatHe = ...
            equalareapolar2planepolar ([trendPlungeMatDHE(j, 2*i-1), ...
                trendPlungeMatDHE(j, 2*i)]);
            equalDipMatHE(j, 2*i-1) = eqDpMatHe(1);
            equalDipMatHE(j, 2*i) = eqDpMatHe(2);
            case {'equalangle'} 
                %[equalDipMatHE(j, 2*i-1), equalDipMatHE(j, 2*i)] = ...
            eqDpMatHe = ...
            equalanglepolar2planepolar ([trendPlungeMatDHE(j, 2*i-1), ...
                trendPlungeMatDHE(j, 2*i)]);
            equalDipMatHE(j, 2*i-1) = eqDpMatHe(1);
            equalDipMatHE(j, 2*i) = eqDpMatHe(2);
            otherwise 
                disp (['Option' prkectionType 'is wrong typed']);
        endswitch
        
    endfor
endfor

% West Side
% creating the trend-series and the plunge-series vectors
pitchGradW =linspace(180, 0, pitchNumPoints);
dipGradW =linspace(90, 0, dipNumPoints);
%creating the trend -plunge matrix
trendPlungeMatDHW =zeros( length(pitchGradW) , 2 *length(dipGradW) );
%creating the half equal-dip matrix(equalDipMatH)
equalDipMatHW =zeros( length(pitchGradW) ,2 *length(dipGradW) );
%filling the half equal-plunge matrix
for i=1 :length(dipGradW)
    for j=1 :length(pitchGradW)
        [trendPlungeMatDHW(j, 2*i-1), trendPlungeMatDHW(j, 2*i)] = ...
        %trdPlgMatDhw = ...
            pitchdipdirdip2trendplunge (pitchGradW(j), [270, dipGradW(i)]);
        %trendPlungeMatDHW(j, 2*i-1) = trdPlgMatDhw(1);
        %trendPlungeMatDHW(j, 2*i) = trdPlgMatDhw(2);
        switch projectionType 
            case {'equalarea'} 
                %[equalDipMatHW(j, 2*i-1), equalDipMatHW(j, 2*i)] = ...
                eqDipMatHw = ...
                equalareapolar2planepolar ([trendPlungeMatDHW(j, 2*i-1), ...
                    trendPlungeMatDHW(j, 2*i)]);
                equalDipMatHW(j, 2*i-1) = eqDipMatHw(1);
                equalDipMatHW(j, 2*i) = eqDipMatHw(2);
            case {'equalangle'} 
                %[equalDipMatHW(j, 2*i-1), equalDipMatHW(j, 2*i)] = ...
                eqDipMatHw = ...
                equalanglepolar2planepolar ([trendPlungeMatDHW(j, 2*i-1), ...
                    trendPlungeMatDHW(j, 2*i)]);
                equalDipMatHW(j, 2*i-1) = eqDipMatHw(1);
                equalDipMatHW(j, 2*i) = eqDipMatHw(2);
            otherwise 
             disp (['Option' prkectionType 'is wrong typed']);
        endswitch
    endfor
endfor

%Joining the two matrices
sd =size(equalDipMatHE);
noRepetirDatoD =sd(2)-2;
equalDipMatH =[ equalDipMatHE(:,1:noRepetirDatoD), equalDipMatHW ];
sizeEDMatH =size(equalDipMatH);

%extracting the Primary Scale of plane trace arcs of equal-dip
indexDp =1:10:sizeEDMatH(2);
equalDipPrinMat =zeros(sizeEDMatH(1) ,length(indexDp) *2);
for i=1 :length(indexDp)
    equalDipPrinMat(: ,2*i-1:2*i) =equalDipMatH(:, indexDp(i):indexDp(i) +1);
endfor
%extracting the Secondary-Scale of plane trace arcs of equal-dip
indexDs =zeros(1,(length(indexDp)-1)*8);
for i=1 :length(indexDp)-1
    indexDs(8*(i-1)+1 :8*i) =indexDp(i)+2:1:indexDp(i+1)-1;
endfor
equalDipSecondMat =zeros(sizeEDMatH(1) ,length(indexDs));
for i=1 :length(indexDs)
    equalDipSecondMat(: ,i) =equalDipMatH(:, indexDs(i));
endfor

%Extracting dense information
%extracting dense information from the Secondary-Scale of plane trace arcs
%of equal-dip
bDs =noSecondScaleDipGrad /(prinPitchStepsGrad /5);
cDs =floor(bDs);
if cDs==bDs
    dDs=0;
else
    dDs=1;
endif
sustractNumberRowsDs =(cDs +dDs);
equalDipSecondMatR =equalDipSecondMat((sustractNumberRowsDs +1) ...
    :(end -sustractNumberRowsDs) ,:); 
%extracting dense information from the Primary-Scale of plane trace arcs
%of equal-dip
sustractNumberRowsDp =round(sustractNumberRowsDs /3);
equalDipPrinMatR =equalDipPrinMat((sustractNumberRowsDp +1) ...
    :(end -sustractNumberRowsDp) ,:); 


%% EQUAL-PITCH MATRIX

% Eastside
%creating the trend-series and the plunge-series vectors
%dipGradE =linspace(0, 90, dipNumPoints);

%creating the trend -plunge matrix
trendPlungeMatPHE =zeros( length(dipGradE) , 2 *length(pitchGradE) );
%creating the half equal-pitch matrix (equalPitchMatH)
equalPitchMatHE =zeros( length(dipGradE) ,2 *length(pitchGradE) );
%filling the half equal-pitch matrix
for i=1 :length(pitchGradE)
    for j=1 :length(dipGradE)
        [trendPlungeMatPHE(j, 2*i-1), trendPlungeMatPHE(j, 2*i)] = ...
            pitchdipdirdip2trendplunge (pitchGradE(i), [90, dipGradE(j)]);
        switch projectionType 
            case {'equalarea'} 
                 %[equalPitchMatHE(j, 2*i-1), equalPitchMatHE(j, 2*i)] = ...
                 eqPtcMatHe = ...
                 equalareapolar2planepolar ([trendPlungeMatPHE(j, 2*i-1), ...
                     trendPlungeMatPHE(j ,2 *i)]);
                 equalPitchMatHE(j, 2*i-1) = eqPtcMatHe(1);
                 equalPitchMatHE(j, 2*i) = eqPtcMatHe(2);
            case {'equalangle'} 
                %[equalPitchMatHE(j, 2*i-1), equalPitchMatHE(j, 2*i)] = ...
                eqPtcMatHe = ...
                    equalanglepolar2planepolar ([trendPlungeMatPHE(j, 2*i-1), ...
                        trendPlungeMatPHE(j, 2*i)]);
                equalPitchMatHE(j, 2*i-1) = eqPtcMatHe(1);
                 equalPitchMatHE(j, 2*i) = eqPtcMatHe(2);
            otherwise 
             disp (['Option' prkectionType 'is wrong typed']);
        endswitch
    endfor
endfor

% Westside
%creating the trend-series and the plunge-series vectors
%dipGradW =linspace(90, 0, dipNumPoints);

% Creating the trend -plunge matrix.
trendPlungeMatPHW =zeros( length(dipGradW) , 2 *length(pitchGradW) );
%creating the half equal-pitch matrix (equalPitchMatH)
equalPitchMatHW =zeros( length(dipGradW) ,2 *length(pitchGradW) );
%filling the half equal-pitch matrix
for i=1 :length(pitchGradW)
    for j=1 :length(dipGradW)
        [trendPlungeMatPHW(j, 2*i-1), trendPlungeMatPHW(j, 2*i)] = ...
            pitchdipdirdip2trendplunge (pitchGradW(i), [270, dipGradW(j)]);
        switch projectionType 
            case {'equalarea'} 
            %[equalPitchMatHW(j, 2*i-1), equalPitchMatHW(j, 2*i)] = ...
            eqPitchMatHw = ...
            equalareapolar2planepolar ([trendPlungeMatPHW(j, 2*i-1), ...
                trendPlungeMatPHW(j, 2*i)]);
            equalPitchMatHW(j, 2*i-1) = eqPitchMatHw(1);
            equalPitchMatHW(j, 2*i) = eqPitchMatHw(2);
            case {'equalangle'} 
            %[equalPitchMatHW(j, 2*i-1), equalPitchMatHW(j, 2*i)] = ...
            eqPitchMatHw = ...
            equalanglepolar2planepolar ([trendPlungeMatPHW(j, 2*i-1), ...
                trendPlungeMatPHW(j, 2*i)]);
            equalPitchMatHW(j, 2*i-1) = eqPitchMatHw(1);
            equalPitchMatHW(j, 2*i) = eqPitchMatHw(2);
            otherwise 
             disp (['Option' prkectionType 'is wrong typed!']);
        endswitch
    endfor
endfor

% Joining the two matrices
sp = size(equalPitchMatHE);
noRepetirDatoP = sp(1) - 1;
equalPitchMatH = [equalPitchMatHE(1:noRepetirDatoP,:); equalPitchMatHW];
sizeEPMatH = size(equalPitchMatH);

% extracting the Primary Scale of curvillinear arc of equal-pitch
indexPp = 1 : 10 : sizeEPMatH(2);
equalPitchPrinMat = zeros(sizeEPMatH(1), length(indexPp) * 2);
for i = 1 : length(indexPp)
    equalPitchPrinMat(: ,2*i-1:2*i) = equalPitchMatH(:, indexPp(i):indexPp(i) + 1);
endfor

% extracting the Secondary-Scale of curvillinear arc of equal-pitch
indexPs = zeros(1, (length(indexPp) - 1) * 8);
for i = 1 :length(indexPp) - 1
    indexPs(8*(i-1)+1 :8*i) = indexPp(i) + 2 : 1 : indexPp(i+1) - 1;
endfor
equalPitchSecondMat = zeros(sizeEPMatH(1), length(indexPs));
for i = 1 : length(indexPs)
    equalPitchSecondMat(:, i) = equalPitchMatH(:, indexPs(i));
endfor

%% Exracting dense information.
% extracting too dense information from the secondary equal-pitch matrix
bPs = (noSecondScalePitchGrad) / (prinPitchStepsGrad / 5);
cPs = floor(bPs);
if cPs == bPs
    dPs = 0;
else
    dPs = 1;
endif
sustractNumberSCols = (cPs + dPs);
equalPitchSecondMatR = equalPitchSecondMat(:, (sustractNumberSCols * 2 + 1) :...
    (end - sustractNumberSCols * 2) );

% extracting dense information from the principal equal-pitch matrix
sustractNumberPCols = round (sustractNumberSCols / 3);
equalPitchPrinMatR = equalPitchPrinMat(:, (sustractNumberPCols *2 + 1) :...
    (end - sustractNumberPCols * 2));

## PLOTING THE GRID.
# Ploting the principal grid.
equalPitchPrinMatR = equalPitchPrinMatR([1:45, 47:end-1], :);
equalPitchSecondMatR = equalPitchSecondMatR([1:45, 47:end-1], :);

hold on
eval(['plotnortheastpolarpoints (equalDipPrinMatR, 2, ', ...
    prinScalePlotArgsCella, ');']);
eval(['plotnortheastpolarpoints (equalPitchPrinMatR, 2, ', ...
    prinScalePlotArgsCellb, ');']);

# Ploting the secondary grid.
if plotSecondScale == true
    eval(['plotnortheastpolarpoints (equalDipSecondMatR, 2, ', ...
        scndScalePlotArgsCella, ');']);
    eval(['plotnortheastpolarpoints (equalPitchSecondMatR, 2, ', ...
        scndScalePlotArgsCellb, ');']);
endif

endfunction

