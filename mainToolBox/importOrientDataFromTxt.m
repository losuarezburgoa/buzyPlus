function [ doubleColOrientArray ] =importOrientDataFromTxt( filenameString, ...
    separatedBy, withHeaderlineTrue )
%
% Description:
% Import a file containing dip-direction and dip data at a 'txt' file and
% stores in a n x 2 matricial variable.
% 
% Input(s):
% Name of the file, without typing the txt extension, and between single
% quotes, i.e. is a string type (filenameString). 
%
% String enclosed by single quotes of the type of column separator. Use
% 'T' or 'tab' if data columns in the importing file are separated by a
% tabular space, or 'C' or 'comma'if columns are separated by that
% separator. The first row is reserved to the headerline of the table. 
%
% Output(s):
% Array (n x 2) containing in the first column the dip-direction values and
% in the second column the dip values.
%
%%%%%%%%%%%%%%%%%%%%%
% doubleColOrientArray =importOrientDataFromTxt( filenameString );
%%%%%%%%%%%%%%%%%%%%%

if nargin < 2
    separatedBy ='T';
    withHeaderlineTrue =false;
elseif nargin < 3
    withHeaderlineTrue =false;
end

switch separatedBy
    case {'T', 'tab','    ', 't'}
        columnSeparator ='\t';
    case {'C', 'comma', ',', 'c'}
        columnSeparator =',';
end

extensionString ='txt';
doubleColOrientSTR =importdata( [filenameString, '.', extensionString], ...
    columnSeparator, withHeaderlineTrue);
doubleColOrientArray =doubleColOrientSTR.data;

end

