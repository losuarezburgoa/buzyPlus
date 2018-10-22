function [ ] = plotgreatcircnorth (projType, tickProp, equalTrendPrinMatR, ...
    equalTrendSecondMatR)
%
% Descrition:
% Plots the great external ccircle of the spherical projection. Do not
% confuse with the function 'plotgreatecircle' wich plots a great inclined
% circle inside this great circle. 
#
# Tick length proportinal to the grate circle radius (tickProp), e.g. 0.05 means
# that the tick length will be 5 % of the great circle radius.
#
% See also: plotgreatccircle, plotradialtrendextticks.

%% Input management.
if nargin < 2
    tickProp = 0.05;
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
elseif nargin < 3
    [equalPlungePrinMat, equalPlungeSecondMatR] = createplungevec ...
        (projType, 10, 88);
endif

[equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
circleRadius = equalTrendPrinMatR(1, 2);

%% Creating the great circle.
greatCirclPrinRowArray = equalTrendPrinMatR(1, :);
greatCirclScndRowArray = equalTrendSecondMatR(1, :);

thetaRadGcPrin = greatCirclPrinRowArray(1:2:length(greatCirclPrinRowArray));
thetaRadGcScnd = greatCirclScndRowArray(1:2:length(greatCirclScndRowArray));

thetaRadGc = sort ([thetaRadGcPrin, thetaRadGcScnd]);
thetaRadGreatC = [thetaRadGc, thetaRadGc(1)];
rhoGreatC = ones(1, length(thetaRadGreatC)) * circleRadius;
[xGreatC, yGreatC] = pol2cart (thetaRadGreatC, rhoGreatC);

%% Creating the north and its tick.
xNt = zeros(1, 2);
yNt = circleRadius *[1, (1 + tickProp)];

%% Creating the center of the circle.
xCtv = zeros(1, 2);
yCtv = circleRadius * tickProp * 0.4 * [-1, 1];

xCth = circleRadius * tickProp * 0.4 * [-1, 1];
yCth = zeros(1, 2);

%% Plotting.
limitsVec = ones(1,4);
limitsVec([1:2:end]) = -1;

hold on
# The great circle.
plot (xGreatC, yGreatC, 'k-', 'Linewidth', 2);
# The cener.
plot (xCtv, yCtv, 'k-', 'Linewidth', 1);
plot (xCth, yCth, 'k-', 'Linewidth', 1);
# The north tick.
plot (xNt, yNt, 'k-', 'Linewidth', 2);
text (xNt(2), (yNt(2) + tickProp * 2 / 3), 'N', 'Color', 'k', 'FontSize', 12, ...
    'FontWeight', 'bold', 'FontName', 'Roman', ...
    'HorizontalAlignment','center');
%axisBox = circleRadius * (1 + tickProp * 1.2) * limitsVec;
%axis(axisBox, 'equal', 'off');

endfunction

