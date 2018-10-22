function [ newXyPointsMatrix ] = rotatescanshape( angleGrad, oldXyPointsMatrix )
%[ newXyPointsMatrix ] = rotatescanshape( angleGrad, oldXyPointsMatrix )
%lsb code
%Descriprion:
% Rotates the scan-shape (e.g. scan-line, borehole, scan-polyline, 
%scan-closed-polyline) an amount of angular grades (angleGrad) around its 
%baricenter in counterclockwise direction.
%Input(s):
%Rotation angle (angleGrad) in counterclockwise direction and in hexagesimal grades
%Matrix (numberData x 2) containing the old x,y points that defines the
%scan-shape (oldXyPointsMatrix).
%Output(s):
%Matrix (numberData x 2) containing the x,y points that defines the rotated
%scan-shape.
%[ newXyPointsMatrix ] = rotatescanshape( angleGrad, oldXyPointsMatrix )

angleRad =angleGrad /180 *pi;
newXyPointsMatrix =oldXyPointsMatrix * [cos(angleRad),...
    -sin(angleRad); sin(angleRad), cos(angleRad)];
end

