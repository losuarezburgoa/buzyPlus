function [] = plotentiregreatcircle (projType)
%
% Descrition:
% Plots the great external circle of the spherical projection. Do not
% confuse with the function 'plotgreatecircle' wich plots a great inclined
% circle inside this great circle or the 'plotgreatcircnorth' which plots with
# the north tick and name.
#
# See also: plotgreatccircle, plotgreatcircnorth, plotradialtrendextticks,
#           plotrosepointnames.


[equalTrendPrinMatR, equalTrendSecondMatR] = createtrendvec (10);
circleRadius = 1;

%% Creating the great circle.
greatCirclPrinRowArray = equalTrendPrinMatR(1, :);
greatCirclScndRowArray = equalTrendSecondMatR(1, :);

thetaRadGcPrin = greatCirclPrinRowArray(1 : 2 : length(greatCirclPrinRowArray));
thetaRadGcScnd = greatCirclScndRowArray(1 : 2 : length(greatCirclScndRowArray));

thetaRadGc = sort ([thetaRadGcPrin, thetaRadGcScnd]);

thetaRadGreatC = [thetaRadGc, thetaRadGc(1)];
rhoGreatC = ones(1, length(thetaRadGreatC)) * circleRadius;
[xGreatC, yGreatC] = pol2cart (thetaRadGreatC, rhoGreatC);

%% Plotting.
hold on
# The great circle.
plot(xGreatC, yGreatC, 'k-', 'Linewidth', 2);

endfunction

