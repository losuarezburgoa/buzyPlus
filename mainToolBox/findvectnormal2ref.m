function [uPerpVec] = findvectnormal2ref (referenceVec, angGrad)
%
% [ uPerpVec, errMsg ] = findvectnormal2ref( referenceVec, angGrad)
%
% Definition:
% Find out a vector, that plunges an angle (angGrad), orthogonal to a reference
% vector (referenceVec), in the NED coordinate system.
% Nested functions:
%   unitvector, rotationmat3D, verifyorthonorm, comparevectormatrixrows,
%   unitvect2trendplunge
% Inputs:
% Reference vector, from which one wants to find out the orthogonal vector
% (referenceVec).
% Desired plunge angle of the new vector inreference to the horizontal
% in hexagesimal grades (angGrad).
% Outputs:
% Vector (uPerpVec) that is perpendicular to the reference one, that plunges an angle
% equal to (angGrad).
%
% Example 01:
% Given a vector [0.8365 0.4830 0.2588] obtain the normal vector to it
% which plunges 0 degrees in respect to the horizontal (i.e. angGrad= 0°).
% Answer.- The corresponding searched vector is [-0.500 0.8660 0.000]
%
% Example 02:
% For the same vector of Example 01 obtain the normal vector to it
% which plunges upwards (i.e. angGrad= -90°).
% Answer.- The corresponding searched vector is [-0.2241 -0.1294 0.9659]
%
% Example 03:
% referenceVec = [-1.8370e-16, -1, 0];
% angGrad = -4
#
# Example 04:
# referenceVec = [0, 0, 1];
# angGrad = 360;

%Unit vector of reference vector
errorVal = 10^(-12);
if and (any(abs(referenceVec - [0,0,1]) < errorVal), angGrad == 0)
  angRad = angGrad*pi/180;
  uPerpVec = [cos(angRad), sin(angRad), 0];
  return
endif

uRefVec = unitvector(referenceVec);
uRefVecTrendPlunge = unitvect2trendplunge(uRefVec);

cardinalMat = [0, 1, 0; 1, 0, 0; 0, 0, 1]; %Cardinal matrix of the NED system
transMatCardMat = [0, 1, 0; 0, 0, 1; 1, 0, 0];

locationEqualVec = comparevectormatrixrows(abs(uRefVec), cardinalMat);%use isequal
value = size(locationEqualVec);

if value(1, 2) == 0
    yaw = angGrad /180 *pi;
    pitch = uRefVecTrendPlunge(2) /180 *pi;
    roll = -uRefVecTrendPlunge(1) /180 *pi;

    rxYawMat = rotationmat3D(yaw, [1 0 0]);
    ryPitchMat = rotationmat3D(pitch, [0 1 0]);
    rzRollMat = rotationmat3D(roll, [0 0 1]);

    %Transformation matrix assemble
    transMat = rxYawMat * ryPitchMat * rzRollMat;
    %Verification of orthonormality
    logicAfirm = verifyorthonorm(transMat);
        if logicAfirm == true
            uPerpVec = transMat(2,:);
        else
            uPerpVec = zeros(1,0);
        endif
else
    %a = find(uRefVec);
    %signus = abs(uRefVec(a)) ./ uRefVec(a); 
    signus = sign(uRefVec);
    uPerpVecP = cardinalMat(locationEqualVec, :) * transMatCardMat; 
    uPerpVec = signus .* uPerpVecP;

endif

endfunction
