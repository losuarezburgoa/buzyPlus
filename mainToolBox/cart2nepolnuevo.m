function [ thetaRad ,rhoRad ] =cart2nepolnuevo( x, y )
%lsb code
%[ thetaRad ,rhoRad ] = cart2nepolnuevo( x ,y )
%
%Description:
%Transforms the coordinates of a point specified in cartesian coordintes to
%north clockwise polar coordinates.
%The cartesian system is the conventional one, x-axis (i.e. first axis)
%pointing to the rigth and y-axis (i.e. second axis) pointing forward.
%Positive angles displace from its origin in the x-axis to the y-axis
%counterclockwise. 
%The North-East system, has its first axis pointing forward and the second
%axis poiinting to the rigth. The positive angle displaces from its origin
%in the north-axis to the east-axis clockwise.
%
%Input(s):
%Coordinate x of the point.
%Coordinate y of the point.
%
%Output(s):
%The angular polar angle (thetaRad) is a clockwise angular displacement in
%radians from the positive North-axis.
%The polar radius (rhoRad) is the distance from the origin to a point in the
%North-East plane. 
%%%%%%%%%%%%%%%%%%%%%%%%
%[ thetaRad ,rhoRad ] = cart2nepolnuevo( x ,y )

if length(x) ~= length(y) 
  error('vectors lengths must be equal');
end

rhoRad =sqrt(x.^2 +y.^2);
theta_0 =zeros(1, length(x));
thetaRad =zeros(1, length(x));

for i=1 :length(x)
    if y(i) >0
        theta_0(i) =atan(x(i) ./y(i));
        if x(i) <0
            thetaRad(i) =theta_0(i) +2 *pi;
        else
            thetaRad(i) =theta_0(i);
        end
    elseif y(i) <0
        theta_0(i) =atan(x(i) ./y(i));
        thetaRad(i) =theta_0(i) +pi;
    else
        if x(i)== 0
            thetaRad(i) =0;
        else
            if x(i) >0
                thetaRad(i) =pi /2;
            else
                thetaRad(i) =3 /2 *pi;
            end
        end
    end
end
thetaRad =transpose(thetaRad);

end

