function [ reducedInteger ] = reduceminimalanyinteger( integerLimit ,integer )
%lsb code
%[ reducedInteger ] = reduceminimalanyinteger( integerLimit ,integer )
%Description:
%Reduces an integer that has a value greater to a determined reference
%integer, to the corresponding value in a circular circle from 1 to the
%reference integer. 
%
%Input(s):
%Limit evaluation reference integer (integerLimit)
%
%Integer vector (iteger).
%
%Output(s):
%Reduced integer vector (reducedInteger).
%%%%%%%%%%%%%%%%%%%%%
%[ reducedInteger ] = reduceminimalanyinteger( integerLimit ,integer )

%Convert to integer integer of any range
verifiedInteger =round(integer);
reducedInteger =zeros( size(integer) );

for i=1 :length(integer)
    %Discretize positive and negative and make the calculations
    if verifiedInteger(i) >0
        if verifiedInteger(i) >integerLimit
            reducedInteger(i) =verifiedInteger(i) -integerLimit *floor(verifiedInteger(i) /integerLimit);
            if reducedInteger(i) ==0
                reducedInteger(i)  =integerLimit;
            end
        else
            if verifiedInteger(i) ==integerLimit
                reducedInteger(i) =integerLimit;
            else
                reducedInteger(i) =verifiedInteger(i);
            end
        end
    else
        if verifiedInteger(i) ==0
            reducedInteger(i) =integerLimit;
        else
            if verifiedInteger(i) <-integerLimit
                reducedInteger(i) =verifiedInteger(i) +integerLimit *abs( ceil(verifiedInteger(i) /integerLimit) ) +integerLimit;
            else
                if verifiedInteger(i) ==-integerLimit
                    reducedInteger(i) =integerLimit;
                else
                    reducedInteger(i) =verifiedInteger(i) +integerLimit;
                end
            end
        end
    end
end
end


reducedInteger1 = reduceminimalanyinteger( 1 ,34.5 )

reducedInteger2 = reduceminimalanyinteger( 34 ,[ 34.5 23 -0.2 ] )

reducedInteger3 = reduceminimalanyinteger( -4 ,0 )

reducedInteger4 = reduceminimalanyinteger(-200.6,[ 34.5 23 -0.2 ]  )
