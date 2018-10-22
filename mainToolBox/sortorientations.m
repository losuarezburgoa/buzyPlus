function [ arrangedOrientationMat ]=sortorientations( orientationMat )
%lsb code
%[ arrangedOrientationMat ]=sortorientations( orientationMat )
%Description:
%Arrange orientation data according to the azimuthal orientation and later
%according to their inclination, both in asceding order.
%Input(s):
%Matrix of n x 2, where the first column has the azimuthal values and the
%second the inclination values (orientationMat)
%Output(s):
%Arranged matrix of n x 2 (arrangedOrientationMat)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ arrangedOrientationMat ]=sortorientations( orientationMat )

%Sorting the plunges
[plunge ,indexes1] =sort(orientationMat(:,2) ,'ascend');
tempo1 =orientationMat(indexes1(:,1) ,1);
tempo2 =plunge(:,1);

arrangedMat1 =[tempo1 ,tempo2];

%Sorting the trends
[trend ,indexes2] =sort(arrangedMat1(:,1) ,'ascend');
tempo4 =arrangedMat1(indexes2(:,1) ,2);
tempo3 =trend(:,1);

arrangedOrientationMat =[tempo3 ,tempo4];

end

