function [ logicalValue ] = twovectorscolinearity( vectorOne , vectorTwo )
%lsb code
%[ logicalValue ] = twovectorscolinearity( vectorOne , vectorTwo )
%
%Description:
%Compares if two vectors are colinear, if so a true value is trown.
%
%Nested function(s):
%unitvector
%
%Input(s):
%First vector (vectorOne);
%Second vector (vectorTwo)
%
%Output(s):
%Logical value. When the two vectors are colinear a true value is trown.
%%%%%%%%%%%%%%%%%%
%[ logicalValue ] = twovectorscolinearity( vectorOne , vectorTwo )

vectorOne =unitvector(vectorOne);
vectorTwo =unitvector(vectorTwo);

%Prolems exist when the two vectors are colinear
comparisonVec =vectorTwo;
logicalVec =true( size(comparisonVec) );
for i=1 :2
    signVar =(-1)^i;
    eval =true;
    for j=1 :length(logicalVec)
        if vectorOne(j) ==signVar *comparisonVec(j)
            logicalVec(j) =true;
        else
            logicalVec(j) =false;
        end
        eval =and( eval, logicalVec(j) );
    end
end
logicalValue =eval;
end

