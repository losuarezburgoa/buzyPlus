function [ trendPlungeVec ] =planepolar2equalanglepolar( thetaRad, rhoRad )
%lsb code
%[ trendPlungeVec ] = planepolar2equalanglepolar( thetaRad, rhoRad )
%
%Description:
%Transforms the spatial orientation of a line represented in a plane-polar
%equalangle representation in the NED coordinate system to trend-punge
%orientation 
%
%Inputs(s):
%Polar angle in the NED system in radians (thetaRad).
%Polar radius in the NED system (rhoRad).
%
%Output(s):
%Trend and plunge vector expressed in hexadecimal grades (trendPlungeVec)
%%%%%%%%%%%%%%%%%%%%

sphereRadius =1;

trendGrad =thetaRad *180 /pi;
plungeRad = pi /2 -2*atan(rhoRad /sphereRadius);
plungeGrad =plungeRad *180 /pi;

trendPlungeVec =[trendGrad, plungeGrad];

end

