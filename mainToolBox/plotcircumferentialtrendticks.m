function [ ] = plotcircumferentialtrendticks (wantPrinTicks, wantScndTicks, ...
    tickProp, equalTrendPrinMatR, equalTrendSecondMatR)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% Input management.
if nargin < 1
    wantPrinTicks = true;
    wantScndTicks = false;
    tickProp = 0.05;
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
elseif nargin < 2
    wantScndTicks = false;
    tickProp = 0.05;
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
elseif nargin < 3
    tickProp = 0.05;
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
elseif nargin < 4
    [equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
endif

circleRadius = 1;

%% Creating the ticks of the principal scale.
if wantPrinTicks
    greatCircl1DataRowArray = equalTrendPrinMatR(1, :);
    thetaRad = greatCircl1DataRowArray(1 : 2 : length(greatCircl1DataRowArray));

    rhoPrinTicks = [1; (1 + tickProp  * 0.8)] * (ones(1, length(thetaRad)) ...
        * circleRadius);
    thetaRadPrinTicks = ones(2, 1) * thetaRad;

    [xPrinTicks, yPrinTicks] = pol2cart(thetaRadPrinTicks, rhoPrinTicks);
endif

%% Creating the ticks of the secondary scale.
if wantScndTicks
    greatCircl2DataRowArray = equalTrendSecondMatR(1, :);
    thetaRad = greatCircl2DataRowArray(1 : 2 : length(greatCircl2DataRowArray));
    
    rhoScndTicks = [1; (1 + tickProp * 0.4)] * (ones(1,length(thetaRad)) ...
        * circleRadius);
    thetaRadScndTicks = ones(2,1) * thetaRad;
    
    [xScndTicks, yScndTicks] = pol2cart(thetaRadScndTicks, rhoScndTicks);
endif

%% Plotting.
hold on
if wantPrinTicks
    plot (xPrinTicks, yPrinTicks, 'k-', 'Linewidth', 1);
endif
if wantScndTicks
    plot (xScndTicks, yScndTicks, 'k-', 'Linewidth', 0.5);
endif

endfunction

