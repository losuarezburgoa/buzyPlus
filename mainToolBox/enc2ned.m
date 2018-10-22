function [ nedCoordsArray ] =enc2ned( encCoordsArray )
%
%Description:
% Transforems coordiantes from the East-North-Cenit coordiante system to
% the North-East-Nadir coordiante system.
%
% Example1:
% encCoordsArray=[ -1.010101, -0.015873; -0.993266, -0.089947; ...
% -0.922559, -0.021164; 0.764310, 0.105820; 0.720539, 0.031746; ...
% 0.767677, -0.084656; 0.804714, 0.052910; 0.821549, -0.015873; ...
% 0.888889, 0.095238; 0.865320, -0.047619; 0.949495, -0.111111 ];
% 
% 

transformationMat =[ ...
    0, 1, 0; ...
    1, 0, 0; ...
    0, 0, -1 ];

numData =size( encCoordsArray, 1 );
numDims =size( encCoordsArray, 2 );

if numDims ==3
    nedCoordsArray =zeros( numData, 3 );
    
    for i=1 :numData
        nedCoordsArray(i,:) =encCoordsArray(i,:) *transformationMat;
    end
elseif numDims ==2
    nedCoordsArray =zeros( numData, 2 );
    for i=1 :numData
        nedCoordsArray(i,:) =encCoordsArray(i,:) *transformationMat(1:end-1,1:end-1);
    end
elseif numDimms ==1
    nedCoordsArray =encCoordsArray;
else
    error('transformation is only possible up to dimmension 3');
end

end

