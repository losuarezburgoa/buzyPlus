function [ strikeDipVec ] = dipdirdip2strikedip( dipdirDipVec )
%lsb code
%[ strikeDipVec ] = dipdirdip2strikedip( dipdirDipVec )
%
%Description:
%Transforms the orientation of a plane given in dip-direction dip format
%into strike dip format.
%
%Nested function(s):
%prepareorientationangles
%
%Input(s):
%Orientation of a plane given its dip direction and dip (dipdirDipVec)
%
%Output(s):
%Orientation of a plane by its strike and dio (strikeDipVec)
%%%%%%%%%%%%%%%%%%%%%%%
%[ strikeDipVec ] = dipdirdip2strikedip( dipdirDipVec )

dipdirDipVec =prepareorientationangles( dipdirDipVec );

strikeDipVec =zeros(1, 2);
if dipdirDipVec(1) <90
    strikeDipVec(1) =270 +dipdirDipVec(1);
    strikeDipVec(2) =dipdirDipVec(2);
else
    strikeDipVec(1) =dipdirDipVec(1) -90;
    strikeDipVec(2) =dipdirDipVec(2);
end


end

