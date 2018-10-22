function [trendPlungeVec] = pitchstrikedip2trendplunge(planeStrikeDipVec, pitchAngleGrad)
%lsb code
%[ trendPlungeVec ] =pitchstrikedip2trendplunge( planeStrikeDipVec
%                   ,pitchAngleGrad )
%Description:
%Obtains the orientation of a line, in trend-plunge format, that belongs to
%a plane and pitches a determined angle couting from the strike of the
%plane up to 180°. 
%
%Nested function(s):
%reduceminimal180angle, pitchdipdirdip2trendplunge ,prepareorientationangles
%
%Input(s):
%Vector representing a plane given by its strike and dip
%(planeStrikeDipVec)
%
%Pitch angle counting clockwise from the plane strike, from 0° to 180°
%(pitchAngleGrad).
%
%Output(s):
%Orientation of the line in trend-plunge format (trendPlungeVec).
#
# Example1:
# planeStrikeDipVec = [0, 90];
# pitchAngleGrad = 4;
#
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ trendPlungeVec ] =pitchstrikedip2trendplunge( planeStrikeDipVec
%                   ,pitchAngleGrad ) 

trendPlungeVec = zeros(1, 2);

%Preparing input data
pitchAngleGrad = reduceminimal180angle(pitchAngleGrad);

%Obtaining dip-direction dip vector
dipDirDipVec = zeros(1, 2);        
dipDirDipVec(1) = planeStrikeDipVec(1) + 90;
dipDirDipVec(2) = planeStrikeDipVec(2);
dipDirDipVec =prepareorientationangles( dipDirDipVec );

[trendPlungeVec(1), trendPlungeVec(2)] = pitchdipdirdip2trendplunge ...
            (pitchAngleGrad ,dipDirDipVec);

trendPlungeVec = prepareorientationangles(trendPlungeVec);

endfunction