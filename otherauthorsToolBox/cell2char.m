function S = cell2char(C)
%
% Converts the contents of a cell array of strings into a character 
% array. The contents of the cell C are read element-wise and 
% converted into a char array of length MAXCOL where MAXCOL is 
% the length of the longest string inside the array. 
% Thus the dimensions of the resulting character array S are 
% [NROW, MAXCOL], with NROW being the number of strings in C.
% Strings inside the array that are of shorter length than 
% MAXCOL, are padded with blank spaces, so that S has an homogeneous
% number of columns. In addition, any rows in C that are NaN's
% in IEEE arithmetic representation are replaced by the string 
% 'NaN'.
%
% Syntax: S = CELL2CHAR(C);
%
% Inputs: 
%        c: cell array 
% Outputs:
%        S: character array
%
% See also: mat2cell, num2cell
% 
% Tonatiuh Pena-Centeno
% Created: 08-Jun-10   Last modified: 16-Jun-10
%

% Verifying C has the correct dimensions
if size(C,2) ~= 1
  error('CELL2CHAR: dimensions of input array C dont seem to be correct');
end

% Character array must have a constant number of columns, 
% so they're retrieved first by computing the MAXCOL 
% number from the entire cell C
nRow = size(C,1);
maxCol = 1;
for it = 1:nRow
  Cit = C{it,:};
  % If cell contents is a number, convert to string
  if isnumeric(Cit)
    Cit = num2str(Cit);
  end
  % If cell contents is NaN, then do not take into account
  if isnan(Cit)
    nCol = 0;
  else
    charC = char(Cit);
    nCol = size(charC,2);
  end
  % Updating maxCol
  if nCol > maxCol
    maxCol = nCol;
  end
end  

S = NaN(nRow,maxCol);
for it = 1:nRow
  Cit = C{it,:};
  % If cell contents is numeric, convert to string
  if isnumeric(Cit)
    Cit = num2str(Cit);
  end
  % If cell contents is NaN, then replace with string
  if isnan(Cit)
    Cit = 'NaN';
  end
  charC = char(Cit);
  nCol = size(charC,2);
  eval(['S(it,:) = [charC, blanks(', num2str(maxCol-nCol), ')];']); 
end

% Converting everything into char code
S = char(S);

end

% Copyright (c) 2010, Tonatiuh Pena Centeno
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
