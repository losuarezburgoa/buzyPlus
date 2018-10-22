function [ arrangedFreqArray, freqValNameArray, freqQuantArray, ...
    totalDataNums ] =findorientationsfrequencies( orientationArray )
%
% Description:
% Obtains the orientation frequencies of each-pair.
%
% Input(s):
% Matrix of n x 2, where the first column has the trend values and the
% second the plunge valiues (trendPlungeMat).
%
% Output(s):
% Arranged array of m x 3 having in the third column the frequency data
% (arrangedFreqArray). The first and the second column of this matrix
% are the azimuthal and inclinations arranged data of the input matrix,
% respectively. 
%
% Vector having the names of the actual frequencies (freqValNameArray).
%
% Vector having the actual quantities for each frequency specified in the
% 'freqValNameArray' variable (freqQuantArray).
%
% Scalar value reporting the total input data (totalDataNums).


%% Arranging the data.
arrangedTrendPlungeMat = sortorientations( orientationArray );

%% Calculating the repeated values foe each convination.
[table, ~, ~, labels] = crosstab (arrangedTrendPlungeMat(:,1), ...
    arrangedTrendPlungeMat(:,2));

labelsNum = str2double(labels);
FrequencyMat0 = zeros(size(table ,1)*size(table ,2), 3);

for i = 1 : size(table ,1)
    for j = 1 : size(table ,2)
        FrequencyMat0( (i-1)*size(table ,2) +j ,1 ) =labelsNum(i ,1);
        FrequencyMat0( (i-1)*size(table ,2) +j ,2 ) =labelsNum(j ,2);
        FrequencyMat0( (i-1)*size(table ,2) +j ,3 ) =table(i, j);
    end
end

%% Deleting zero frequencies values.
nonzeroIndexes =find(FrequencyMat0(:,3));
a =length(nonzeroIndexes);
FrequencyMat =zeros(a, 3);
for i=1 :a
    FrequencyMat(i ,:) =FrequencyMat0(nonzeroIndexes(i) ,:);
end

%% Sorting the frequencies.
[freq ,indexes] =sort(FrequencyMat(:,3) ,'ascend');
tempo1 =FrequencyMat(indexes(:,1) ,1);
tempo2 =FrequencyMat(indexes(:,1) ,2);
tempo3 =freq(:,1);
arrangedMat1 =[tempo1 ,tempo2 ,tempo3];

%% Sorting the plunges.
[plunge ,indexes] =sort(arrangedMat1(:,2) ,'ascend');
tempo1 =arrangedMat1(indexes(:,1) ,1);
tempo3 =arrangedMat1(indexes(:,1) ,3);
tempo2 =plunge(:,1);
arrangedMat2 =[tempo1 ,tempo2 ,tempo3];

%% Sorting the trends.
[trend ,indexes] =sort(arrangedMat2(:,1) ,'ascend');
tempo2 =arrangedMat2(indexes(:,1) ,2);
tempo3 =arrangedMat2(indexes(:,1) ,3);
tempo1 =trend(:,1);
arrangedFreqArray =[tempo1 ,tempo2 ,tempo3];

%% Obtaining the frequency value name vector.
freqValNameArray =unique(arrangedFreqArray(:,3));

%% Obtaining number of data vector of each frequency name.
freqQuantArray =zeros( length(freqValNameArray) ,1);
for i =1 :length(freqQuantArray)
    x =find( arrangedFreqArray(:,3) ==freqValNameArray(i) );
    freqQuantArray(i) =length( x ) ;
end

%% Calculating the total number of data.
totalDataNums =sum( freqQuantArray .*freqValNameArray );

end

