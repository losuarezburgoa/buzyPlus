function [ ] = plotsecondrosepointnames (projType, dirString, tickProp, ...
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
    dirString = 'SA';
    tickProp = 0.05;
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
elseif nargin < 3
    tickProp = 0.05;
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
elseif nargin < 4
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
endif

circleRadius = 1;
## Creating the carnial names and its tick.
xNt = circleRadius * [1, (1 + tickProp)];
yNt = zeros(1, 2);

pNt = [xNt; yNt];

switch dirString
    case 'NE'
        stringD = 'NE';
        thetaNeDeg = 45;
        hAlign = 'left';
        vAlign = 'middle';
        offsetX = sqrt(2);
        offsetY = sqrt(2);
    case 'SE'
        stringD = 'SE';
        thetaNeDeg = -45;
        hAlign = 'left';
        vAlign = 'middle';
        offsetX = sqrt(2);
        offsetY = -sqrt(2);
    case 'SW'
        stringD = 'SW';
        thetaNeDeg = -135;
        hAlign = 'right';
        vAlign = 'middle';
        offsetX = -sqrt(2);
        offsetY = -sqrt(2);
    case 'NW'
        stringD = 'NW';
        thetaNeDeg = 180 - 45;
        hAlign = 'right';
        vAlign = 'middle';
        offsetX = -sqrt(2);
        offsetY = sqrt(2);
    case 'SA'
        stringdCell = {'NE', 'SE', 'SW', 'NW'};
        for k = 1 : length(stringdCell)
            plotsecondrosepointnames (projType, stringdCell{k}, tickProp); 
        endfor
        return
    otherwise
        error('Bad string, it should be only: NE, SE, SW or NW!');
endswitch

## Plotting.
thetaRad = thetaNeDeg * pi / 180;
Rmat = [cos(thetaRad), -sin(thetaRad); sin(thetaRad), cos(thetaRad)];
ppNt1 = Rmat * pNt(:,1);
ppNt2 = Rmat * pNt(:,2);
ppNt = [ppNt1, ppNt2];

tickspc = tickProp * 2 / 3;

hold on
plot(ppNt(1,:), ppNt(2, :), 'k-', 'Linewidth', 2);
text(ppNt(1,2) + tickspc * offsetX, (ppNt(2,2) + tickspc * offsetY), ...
    stringD, 'Color', 'k', ...
    'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Roman', ...
    'HorizontalAlignment', hAlign, 'VerticalAlignment', vAlign);
%axis off
%axis equal

endfunction