function [ trendPlungeMat ] =planepolar2equalareatrendplunge_array( planePolarMat )
%lsb code
%[planePolarMat] =planepolar2equalareatrendplunge_array( trendPlungeMat )
%
%Description:
%Performs the same calculations as the 'planepolar2equalareapolar' but for
%a planePolarMat and not for a single vector.
%
%Nested Function(s):
%planepolar2equalareapolar
%
%Input(s):
%Matrix of trend-plunge values (trendPlungeMat)
%
%Output(s):
%Matrix of polar points represented in a equalarea projection plane
%(trendPlungeMat)
%%%%%%%%%%%%%%%%%%%%%%
%[planePolarMat] =planepolar2equalareatrendplunge_array( trendPlungeMat )

dataNumber =size(planePolarMat, 1);
trendPlungeMat =zeros( size(planePolarMat) );

for i=1 :dataNumber
    [ trendPlungeMat(i ,:) ] =planepolar2equalareapolar...
        ( planePolarMat(i ,1) ,planePolarMat(i ,2) );
end

end

