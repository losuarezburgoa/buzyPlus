function [ trendPlungeVec ] = twovectors2trendplunge( vectorOne ,vectorTwo )
%lsb code
%[ trendPlungeVec ] = twovectors2trendplunge( vectorOne ,vectroTwo )
%
%Description:
%Converts the information of a plane given by two coplanar vectors, in a
%north-east-nadir coordinate system, to trend and plunge information. The
%function alwas give the orientation of the plane that points downwards.
%
%Nested function(s):
%twovectorscolinearity, unitvector, unitvect2trendplunge,
%prepareorientationangles
%
%Input(s):
%First coplanar vector given in NED coordinate system (vectorOne).
%Second coplanar vector in NED coordinate system (vectorTwo).
%
%Output(s):
%Orientation of a plane given by a trend and plunge (trendPlungeVec).
%%%%%%%%%%%%%%%%%%%
%[ trendPlungeVec ] = twovectors2trendplunge( vectorOne ,vectroTwo )

vectorOne =unitvector(vectorOne);
vectorTwo =unitvector(vectorTwo);

%Prolems exist when the two vectors are colinear
eval =twovectorscolinearity(vectorOne ,vectorTwo);
if eval ==true
    error('The two vectors are colinear and they do not define a plane');
end

polePlaneUnitVec =cross(vectorOne ,vectorTwo);
polePlaneUnitVec =unitvector(polePlaneUnitVec);

%Changing sense if the resultant vectoro points upwards (negative valor)
if polePlaneUnitVec(3) <0;
    polePlaneUnitVec =-polePlaneUnitVec;
end

trendPlungeVec =unitvect2trendplunge( polePlaneUnitVec );
trendPlungeVec =prepareorientationangles( trendPlungeVec );
end

