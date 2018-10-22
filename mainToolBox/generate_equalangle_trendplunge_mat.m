function [ trendPlungeMat ] =generate_equalangle_trendplunge_mat...
    ( numberTrendDivisions ,numberPlungeDivisions)
%lsb code
%[ trendPlungeMat ] = generate_equalangle_trendplunge_mat...
%          ( numberTrendDivisions ,numberPlungeDivisions)
%
%Description:
%Generates an equalangle trend and plunge mat.
%
%Nested function(s):
%sortorientations
%
%Input(s):
%Number of trend divisions ().
%
%Number of plunge divisiona ().
%
%Output(s):
%Matrix of trend and plunge values
%%%%%%%%%%%%%%%%%%%
%[ trendPlungeMat ] = generate_equalangle_trendplunge_mat...
%          ( numberTrendDivisions ,numberPlungeDivisions)

trendArray =linspace( 0 ,360 ,numberTrendDivisions +1 );
trendArray =trendArray(1 :end -1);
plungeArray =linspace( 0 ,90 ,numberPlungeDivisions +1 );

totalPoints =length(trendArray) *length(plungeArray);

%Filling the 'trendPlungeMat' with values
trendPlungeMat =zeros( totalPoints, 2 );
for i=1 :length(plungeArray)
    for j=1 :length(trendArray)
        trendPlungeMat( (i-1)*length(trendArray) +j ,1) =trendArray(j);
        trendPlungeMat( (i-1)*length(trendArray) +j ,2) =plungeArray(i);
    end
end
trendPlungeMat =trendPlungeMat( 1: end-length(trendArray)+1 ,: );
trendPlungeMat =sortorientations( trendPlungeMat );

end

