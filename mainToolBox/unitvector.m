function [ uVec ] = unitvector( vector )
%[ uVec ] = unitvector( vector )
%DeEfinition:
%Returns the unitary vector of a non-unitary vector
%Input(s):
%Vector from which an unitary vector will be calculated (vector)
%Output(s):
%Unitary vector of the input vector (uVec)
%Example:
%uVec01 =unitvector( [ 3 ,4 ,5 ] ) gives [0.4243    0.5657    0.7071]
%%%%%%%%%%%%%%
%[ uVec ] = unitvector( vector )
    
uVec =vector /norm(vector);


end


 uVec1  = unitvector( [ 3.6 56 70 ] )
 
 uVec2 = unitvector( [ 3 ,4 ,5 ] )
 
 
 
