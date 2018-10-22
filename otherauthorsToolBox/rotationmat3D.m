function [ rotationMatrix ]= rotationmat3D(rotationAngleRad ,rotationAxis)
%[ rotationMatrix ]= rotationmat3D(rotationAngleRad ,rotationAxis)
%Description:
% Creates a rotation matrix such that it rotates around a rotation axis
% some.
% Verification:
% Rotate around a random direction a random amount and then back
% the result should be an Identity matrix
% rotationAngleRad =rand(4,1);
% A =rotationmat3D(rotationAngleRad(1),[rotationAngleRad(2),...
% rotationAngleRad(3),rotationAngleRad(4)])...
% *rotationmat3D(-rotationAngleRad(1),[rotationAngleRad(2),...
% rotationAngleRad(3),rotationAngleRad(4)])
%
% Example: 
% Rotate around z axis 45 degrees.
% In  the command line write :rotationMatrixTest = rotationmat3D(pi/4,[0 0 1])
% The answer rotationMatrixTest =[0.7071 -0.7071 0; 0.7071 0.7071 0; 0 0 1]
%%%%%%%%%%%%%%%%%%%%%%%%%
%%[ rotationMatrix ]= rotationmat3D(rotationAngleRad ,rotationAxis)
% by Bileschi 2009 modified by LSB 2010

r =rotationAngleRad;
Axis =rotationAxis;

if nargin == 1
   if(length(rotX) == 3)
      rotY = rotX(2);
      rotZ = rotZ(3);
      rotX = rotX(1);
   end
end

% useful intermediates
L = norm(Axis);
if (L < eps)
   error('axis direction must be non-zero vector');
end
Axis = Axis / L;
L = 1;
u = Axis(1);
v = Axis(2);
w = Axis(3);
u2 = u^2;
v2 = v^2;
w2 = w^2;
c = cos(r);
s = sin(r);
%storage
R = nan(3);
%fill
R(1,1) =  u2 + (v2 + w2)*c;
R(1,2) = u*v*(1-c) - w*s;
R(1,3) = u*w*(1-c) + v*s;
R(2,1) = u*v*(1-c) + w*s;
R(2,2) = v2 + (u2+w2)*c;
R(2,3) = v*w*(1-c) - u*s;
R(3,1) = u*w*(1-c) - v*s;
R(3,2) = v*w*(1-c)+u*s;
R(3,3) = w2 + (u2+v2)*c;

rotationMatrix= R;
end
