function [strikeDipArray] = dipdirdip2strikedip (dipdirDipArray)
%lsb code
%[ strikeDipVec ] = dipdirdip2strikedip( dDirDipVec )
%
%Description:
%Transforms the orientation of a plane given in dip-direction dip format
%into strike dip format.
%
%Nested function(s):
%prepareorientationangles
%
%Input(s):
%Orientation of a plane given its dip direction and dip (dDirDipVec)
%
%Output(s):
%Orientation of a plane by its strike and dio (strikeDipVec)
%
%[strikeDipVec] = dipdirdip2strikedip (dDirDipVec)

numData = size (dipdirDipArray, 1);
strikeDipArray = zeros (numData, 2);
for i = 1 : numData
    strikeDipArray(i, :) = ddd2s (dipdirDipArray(i,:)); 
endfor
endfunction


function [strikeDipVec] = ddd2s (dDirDipVec)

dDirDipVec = prepareorientationangles (dDirDipVec);

strikeDipVec = zeros(1, 2);
if dDirDipVec(1) < 90
    strikeDipVec(1) = 270 + dDirDipVec(1);
    strikeDipVec(2) = dDirDipVec(2);
else
    strikeDipVec(1) = dDirDipVec(1) - 90;
    strikeDipVec(2) = dDirDipVec(2);
endif
endfunction

