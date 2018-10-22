function [ outputPercentValue ] =obtainequalmultiplesareas...
    ( initialpercentValue ,interval ,multipleGroup ,bottomNotAcomplishedCollars )
%lsb code
%Description:
%Obtains the area percentage 'outputPercentValue', respect the total half
%hemisphere, in where each collar of a counting equal area net divides in a
%determined multiple number 'multipleGroup', except those
%'bottomNotAcomplishedCollars' collars located at the bottom of the 
%sphere.
%The function make the search from a initial seed value
%'initialpercentValue' and adding an interval value 'interval'.
%
%Input(s):
%Initial seed value upon where the search will be performed
%(initialpercentValue). This is a real number that express the initial are
%percentage of the search.
%Interval preceision (interval).
%Value of the desired multiple (multipleGroup).
%Number of those collars that will no acomplish the multiple restriction
%(bottomNotAcomplishedCollars). 
%
%Output(s):
%Percentage of the area, respect the total half hemisphere, that
%accomplished the input conditions.
%
%Example:
%Obtain that percentage area which allows to have a collars that can be
%divisible four times, except the last collar.
%[ outputPercentValue ] =obtainequalmultiplesareas( 0.01 ,0.001 ,4 ,1 );
%The searched value is 1.5152% that results by dividing the half hemisphere
%in 66 equal area parts.

logicalVerification =true;

while logicalVerification
        want2plot =false;
        [ finalUnitPercentArea ,areaFactorVec , numHalfRegVec] =createcountingequalareanet( initialpercentValue ,want2plot);
        comparisonVec =floor(numHalfRegVec(1:end-1-bottomNotAcomplishedCollars) /multipleGroup);
        multipleFourVec =numHalfRegVec(1:end-1-bottomNotAcomplishedCollars) /multipleGroup;
        equalnessVec =~logical( minus(multipleFourVec, comparisonVec) );
        
        vecLength =length(equalnessVec);
        logicalVal =true;
        for i =1:vecLength
            logicalVal =and(logicalVal ,equalnessVec(i));
        end
        logicalVerification =~logicalVal;
        initialpercentValue =initialpercentValue +interval;
end
outputPercentValue =initialpercentValue;
end

