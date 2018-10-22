function [ ] = plotcircumferentialtrendnums (projType, wantplottick, tickProp, ...
      equalTrendPrinMatR, equalTrendSecondMatR)
#
# Description:
# Plots the great external ccircle of the spherical projection. Do not
# confuse with the function 'plotgreatecircle' wich plots a great inclined
# circle inside this great circle. 
#
# Input(s):
# Tick length proportinal to the grate circle radius (tickProp), e.g. 0.05 means
# that the tick length will be 5 % of the great circle radius.
#
# See also: plotgreatccircle, plotradialtrendextticks.
#
#projType = 'equalarea';
#dirString = 'N';
#tickProp = 0.05;

## Input management.
if nargin < 2
    wantplottick = false;
    tickProp = 0.02;
    equalTrendPrinMatR = createtrendvec (10);
elseif nargin < 3
    tickProp = 0.02;
    equalTrendPrinMatR = createtrendvec (10);
elseif nargin < 4
    equalTrendPrinMatR = createtrendvec (10);
endif

# Taken aut the primary vector exccepto N, E, S, W.
trendNumArray = mod(equalTrendPrinMatR([1:2:end]) * 180 / pi, 360);
spc = (length(trendNumArray) - 1) / 4;
trendNumArray([2:spc:end] - 1) = NaN;
trendNumArray = trendNumArray(~isnan(trendNumArray(1:end-1)));

# Plotting each text on the graphic.
for k = 1 : length(trendNumArray)
    pltctrendnum(projType, trendNumArray(k), wantplottick, tickProp)
endfor
endfunction

function [ ] = pltctrendnum (projType, trendNum, wantplottick, tickProp)

## Circle radius
circleRadius = 1;

## Creating the carnial names and its tick.
xNt = circleRadius * [1, (1 + tickProp)];
yNt = zeros(1, 2);

pNt = [xNt; yNt];
stringD = num2str(trendNum);

if trendNum >= 0 && trendNum <= 90 
    quadrantString = 'NE';
elseif trendNum > 90 && trendNum <= 180
    quadrantString = 'SE';
elseif trendNum > 180 && trendNum <= 270
    quadrantString = 'SW';
elseif trendNum > 270 && trendNum <= 360
    quadrantString = 'NW';
else
    display(trendNum);
    error('out of range!');
endif

switch quadrantString
    case 'NE'
        hAlign = 'left';
        vAlign = 'bottom';
        offsetX = 0;
        offsetY = 0;
    case 'SE'
        hAlign = 'left';
        vAlign = 'top';
        offsetX = 0;
        offsetY = 0;
    case 'SW'
        hAlign = 'right';
        vAlign = 'top';
        offsetX = 0;
        offsetY = 0;
    case 'NW'
        hAlign = 'right';
        vAlign = 'bottom';
        offsetX = 0;
        offsetY = 0;
endswitch

## Plotting.
thetaRad = nepolar2polar(trendNum * pi / 180);
Rmat = [cos(thetaRad), -sin(thetaRad); sin(thetaRad), cos(thetaRad)];
ppNt1 = Rmat * pNt(:,1);
ppNt2 = Rmat * pNt(:,2);
ppNt = [ppNt1, ppNt2];

tickspc = 0 * tickProp;

hold on
if wantplottick
    plot(ppNt(1,:), ppNt(2, :), 'k-', 'Linewidth', 1);
endif
text(ppNt(1,2) + tickspc * offsetX, (ppNt(2,2) + tickspc * offsetY), ...
     stringD, 'Color', 'k', 'rotation', thetaRad * 180/pi, ...
     'FontSize', 10, 'FontName', 'Roman', ...
     'HorizontalAlignment', hAlign, 'VerticalAlignment', vAlign);

%axis off
%axis equal

endfunction