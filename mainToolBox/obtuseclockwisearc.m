function [ arcAngleRad ,initialArcAngleRad ] = obtuseclockwisearc( angle1Rad ,angle2Rad )
%lsb code
%Description:
%Calculates the obtuse angle of an arc that developes clockwise, given two angles.
%
%Input(s):
%First any extreme angle in radians (angle1Rad).
%Second any extreme angle in radians (angle2Rad).
%
%Output(s):
%Acute arc angle between the two angles (arcAngleRad).
%Initial angle upon where the arc developes clokwise (initialArcAngleRad).


angle1Rad =angle1Rad -floor(angle1Rad ./2 ./pi) *2 *pi;
angle2Rad =angle2Rad -floor(angle2Rad ./2 ./pi) *2 *pi;

if angle1Rad ==angle2Rad
    initialArcAngleRad =angle1Rad;
    arcAngleRad =2*pi;
    return;
end
angleMin =min( [angle1Rad ,angle2Rad] );
angleMax =max( [angle1Rad ,angle2Rad] );
arcDiference1 =(angleMax -angleMin);
arcDiferencex =(angleMin+2*pi -angleMax);
arcDiference2 =arcDiferencex -floor(arcDiferencex ./2 ./pi) *2 *pi;

if arcDiference1 ==arcDiference2
    initialArcAngleRad =angle1Rad;
    arcAngleRad =arcDiference1;
    return;
end

if arcDiference1 >arcDiference2
    initialArcAngleRad =angleMin;
else
    initialArcAngleRad =angleMax;
end
arcAngleRad =max(arcDiference1 ,arcDiference2);
end

