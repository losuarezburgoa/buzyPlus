function [trendPlungeVec] = planepolar2equalareapolar (angleThetaRad, rho)

% Description:
% Transforms the spatial orientation of a line represented in a plane-polar
% equalarea representation in the NED coordinate system to trend-plunge
% orientation.
%
% Inputs(s):
% Polar angle in the NED system in radians (angleThetaRad).
% Polar radius in the NED system (rho).
%
% Output(s):
% Trend and plunge vector expressed in hexadecimal grades (trendPlungeVec)

sphereRadius = 1;
angleThetaRad = angleThetaRad(:);
rho = rho(:);

trendGrad = angleThetaRad * 180 / pi;

plungeRad = 2 * acos (sqrt(2) * rho / 2 / sphereRadius) - pi / 2;
plungeGrad = plungeRad * 180 / pi;

trendPlungeVec = [trendGrad, plungeGrad];

endfunction

