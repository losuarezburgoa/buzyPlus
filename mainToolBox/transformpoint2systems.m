function [ newPoint ] = transformpoint2systems( oldPoint, old2newTMat)
%[ newPoint ] = transformpoint2systems( oldPoint, old2newTMat)
%Description:
% Transforms a point expressed in the Old Coordinate System to that
% expresed in the New Coordinate System.
% Inputs:
% Old point row vector (oldPoint)
% Old to New transformation matrix (old2newTMat)
%Outputs:
% New point row vector (newPoint)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newPoint = oldPoint *old2newTMat;
end

