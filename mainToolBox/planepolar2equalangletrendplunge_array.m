function [ trendPlungeMat ] =planepolar2equalangletrendplunge_array( planePolarMat )
%lsb code
%[planePolarMat] =planepolar2equalangletrendplunge_array( trendPlungeMat )
%
%Description:
%Performs the same calculations as the 'planepolar2equalanglepolar' but for
%a planePolarMat and not for a single vector.
%
%Nested Function(s):
%planepolar2equalanglepolar
%
%Input(s):
%Matrix of trend-plunge values (trendPlungeMat)
%
%Output(s):
%Matrix of polar points represented in a equalangle projection plane.
%%%%%%%%%%%%%%%%%%%%%%
%[planePolarMat] =planepolar2equalangletrendplunge_array( trendPlungeMat )

dataNumber =size(planePolarMat, 1);
trendPlungeMat =zeros( size(planePolarMat) );

for i=1 :dataNumber
    [ trendPlungeMat(i ,:) ] =planepolar2equalanglepolar...
        ( planePolarMat(i ,1) ,planePolarMat(i ,2) );
end

end

