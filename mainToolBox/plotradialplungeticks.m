function [xPrinTicks, yPrinTicks] = plotradialplungeticks (projType, dirString, ...
    wantPrinTicks, wantScndTicks, tickProp, equalPlungePrinMat, equalPlungeSecondMatR)

## Plot the ticks that are located in the middle cross lines of the circular 
## diagram.
##
## Input(s):
## Cardinal direction from center to it, where the tocks are wanted to plot 
## (dirString), e.g. 'N', 'E', 'S' and 'W'.
##
## Tick length proportinal to the grate circle radius (tickProp), e.g. 0.05 means
## that the tick length will be 5 % of the great circle radius.
##
## Array where the principal ticks will be located (equalPlungePrinMat).
## Array where the secondary ticks will be located (equalPlungeSecondMatR).
## Boolean variable if the secondary ticks are wanted to plot (wantScndTicks), 
## by default is true.
##
## Output(s):
## Absisas (i.e. x-coordiantes) where the ticks are placed (xPrinTicks).
## Ordinates (i.e. y-coordiantes) where the ticks are placed (yPrinTicks).
##
## Nested function(s):
## createplungevec.
## 

## Input management.
if nargin < 2
    dirString = 'E';
    wantPrinTicks = true;
    wantScndTicks = false;
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 3
    wantPrinTicks = true;
    wantScndTicks = false;
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 4
    wantScndTicks = false;
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 5
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 6
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
endif

## Creating the ticks of the principal scale at east axis.
if wantPrinTicks
radiusAtEastRowArray = equalPlungePrinMat(1, :);
rhoAtEast = radiusAtEastRowArray(2 : 2 : length(radiusAtEastRowArray));

yPrinTicks = 0.8 * [-tickProp; +tickProp] * (ones(1, length(rhoAtEast)));
xPrinTicks = ones(2, 1) * rhoAtEast;

switch dirString
    case 'E'
    case 'N'
        tempo = xPrinTicks;
        xPrinTicks = yPrinTicks;
        yPrinTicks = tempo;
    case 'W'
        xPrinTicks = -xPrinTicks;
    case 'S'
        tempo = xPrinTicks;
        xPrinTicks = yPrinTicks;
        yPrinTicks = -tempo;
    case 'A'
        stringdCell = {'N', 'E', 'S', 'W'};
        hold on
        for k = 1 : length(stringdCell)
            plotradialplungeticks (projType, stringdCell{k}, ...
            true, false, tickProp, equalPlungePrinMat, equalPlungeSecondMatR);
        endfor
    otherwise
        error('Bad string, it should be only: N, E, S or W!');
endswitch
endif

## Creating the ticks of the secondary scale.
if wantScndTicks
    radiusAtEast2RowArray = equalPlungeSecondMatR(1, :);
    rhoAtEast = radiusAtEast2RowArray(2 : 2 : length(radiusAtEast2RowArray));
    
    yScndTicks = 0.4 * [-tickProp; +tickProp ] * (ones(1, length(rhoAtEast)));
    xScndTicks = ones(2, 1) * rhoAtEast;
    
    switch dirString
        case 'E'
        case 'N'
            tempo = xScndTicks;
            xScndTicks = yScndTicks;
            yScndTicks = tempo;
        case 'W'
            xScndTicks = -xScndTicks;
        case 'S'
            tempo = xScndTicks;
            xScndTicks = yScndTicks;
            yScndTicks = -tempo;
        case 'A'
        stringdCell = {'N', 'E', 'S', 'W'};
        for k = 1 : length(stringdCell)
            hold on
            plotradialplungeticks (projType, stringdCell{k}, ...
            false, true, tickProp, equalPlungePrinMat, equalPlungeSecondMatR);
        endfor
        otherwise
            error('Bad string, it should be only: N, E, S or W!');
    endswitch
endif

%% Plotting.
hold on
if wantPrinTicks
    plot(xPrinTicks, yPrinTicks, 'k-', 'Linewidth', 1);
endif
if wantScndTicks
    plot(xScndTicks, yScndTicks, 'k-', 'Linewidth', 0.5);
endif
#axis off
#axis equal
endfunction

