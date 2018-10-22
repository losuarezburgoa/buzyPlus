function [] = plotdiagramcenter (tickProp)
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
if nargin < 1
    tickProp = 0.05;
endif

circleRadius = 1;

%% Creating the center of the circle.
xCtv = zeros(1, 2);
yCtv = circleRadius * tickProp * 0.4 * [-1, 1];

xCth = circleRadius * tickProp * 0.4 * [-1, 1];
yCth = zeros(1, 2);

%% Plotting.
hold on
# The cener.
plot (xCtv, yCtv, 'k-', 'Linewidth', 1);
plot (xCth, yCth, 'k-', 'Linewidth', 1);

endfunction

