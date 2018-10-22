## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{yItvalMean} =} terzaghicorr2dapprox (@var{coneTrdPlgVec}, @var{axisAngleDeg})
##
## @seealso{trendplunge2unitvect}
## @end deftypefn

## Given a cone (oriented in the space with a [trend, plunge] tuple) that expands
## downwards from its vetex at the unit circle with a cone angle.
## This cone intersects a surface  of '\sin{\alpha}' values which is the 
## Terzaghi correction factor function.  This surface is related with the 
## borehole or scanline orientation. 
## After considering these three set of variables, this function calculates
## the two dimensional factor that are more close to the integration of the 
## cone within the function. 

## Input(s):
## The cone axis space orientation given by its trend and plunge angles 
## (coneTrdPlgVec).
## The axis to the generatrix angle of the cone (axisAngleDeg).
## The borehole orientation given by its trend and plunge angles (bhTrdPlgVec).
## The threshold angle value that caracterizes the blind zone (refAngDeg).
## A boolean that determines if a plot is wanrted to show.

## Output(s):
## The mean value of the Terzaghi correction factor (yItvalMean).
## The spatial angle between the borehole axis and the cone axis in hexagesimal
## angular degrees (bhcaAcuteAngDeg).

## Example 1:
## coneTrdPlgVec = [030, 10];
## axisAngleDeg = 20;
## bhTrdPlgVec = [250, 60];
## refAngDeg = 0;
## wantplot = true;

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-23

function [yItvalMean, bhcaAcuteAngDeg] = terzaghicorr2dapprox (coneTrdPlgVec, ...
    axisAngleDeg, bhTrdPlgVec, refAngDeg, wantplot)
  
## Inputs management.
if nargin < 4
    refAngDeg = 8;
    wantplot = false;
elseif nargin < 5
    wantplot = false;
endif

## We will estimate the Terzaghi correction factor for that cone position
## with respect the borehole position.

# Acute angle between two vectors.
coneUvec = trendplunge2unitvect (coneTrdPlgVec);
bhUvec = trendplunge2unitvect (bhTrdPlgVec);
acuteAngRad = acuteobtuseangsbtwen2dirs (coneUvec, bhUvec);
bhcaAcuteAngDeg = rad2deg(acuteAngRad);

# Interpolating on the vertical plot.
bhPlg = 90 - bhcaAcuteAngDeg;
[yItvalMean, x, y, interPlgAlphaCell] = meanalphafrominterval ...
    (bhPlg, 90 * ones(1,2), axisAngleDeg, refAngDeg);

## Plotting.
if wantplot
hold on
# The curve.
plot (x, y, 'k-', 'LineWidth', 2);
# The text offset.
xt = 0.02; yt = 0.02;
# The intervals.
numSubints = length (interPlgAlphaCell);
lblArray = zeros (numSubints*2, 2);
for k = 1 : 1 : numSubints
    plot (interPlgAlphaCell{k}(:,1), interPlgAlphaCell{k}(:,2), 'r-', ...
        'LineWidth', 3);
    lblArray((2*k + 1)-2 : (2*k + 1)-1, :) = ...
        [interPlgAlphaCell{k}(1, 1), interPlgAlphaCell{k}(1, 2); ...
         interPlgAlphaCell{k}(end, 1), interPlgAlphaCell{k}(end, 2)];
endfor
plot (lblArray([1,end], 1), lblArray([1,end],2), 'ko');
plot (-ones(1,2) * bhcaAcuteAngDeg, [0, 1], 'k--');
plot (-bhcaAcuteAngDeg, 1, 'ko');
tbh = text(-bhcaAcuteAngDeg + xt, 1 - yt, 'Borehole axis');
set(tbh,'Rotation', 90); set(tbh, 'HorizontalAlignment', 'right');
# The cone axis.
plot (zeros(1,2), [0, 1], 'k..-'); 
cah = text(0 + xt, 1 - yt, 'Cone axis');
set(cah,'Rotation', 90); set(cah, 'HorizontalAlignment', 'right');
# The end of the intervals.
plot (ones(1,2) -axisAngleDeg, [0, 1], 'k--'); 
plot (ones(1,2) +axisAngleDeg, [0, 1], 'k--'); 
# The legend.
lgndStr2 = sprintf ('(threshold %d °).', refAngDeg);
legend (['Terzaghi function ', lgndStr2], 'Intervals.');
legend ('boxoff');
# Managing scales and axes.
xlabel ('\alpha [°].');
ylabel ('sin{(\alpha)} [1].');
set (gca, 'xtick', [-90 : 15 : 90]); 
set (gca, 'ytick', [0 : 0.2 : 1]);
set (gca,'TickDir','out');
xlim ([-90 , 90]);
ylim ([0, 1]);
endif

endfunction
