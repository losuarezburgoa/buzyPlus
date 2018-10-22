function [ logicalVal ] = isevennumber( number )
%LSB code
%Description:
%Gives a true value if the inserted number is odd
%Input(s):
%Number to be evaluated if it is an even number
%Output(s):
%Logical value, where true indicates that the input number is an even
%number.

if mod(number,2)
    logicalVal =true;
else 
    logicalVal =false;
end 
end

