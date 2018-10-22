function matrix2tabularlatex( dataArray, filenameString, formatString, inlineNumberFormatTrue )

% Description:
% Creates data in the form as needed by the environment 'tabular' of LaTeX
% form a dataArray or a cell, and stores it in a file. Numbers are exported as
% text chain, therefore the transformation formatString should be specified.
%
% Inputs(s):
% A 2 dimensional numerical cell or array (dataArray).
% Filename in which the resulting LaTeX code will be stored (filenameString).
% String to be used to formatString the numerical data to a string data (formatString).
% Boolean value of true if numbers are wanted to be between the $ sign
% (inlineNumberFormatTrue).
%
% Output(s):
% Nothinf into memory, but a file is stored on disk with the name given
% above.
%
% Example1:
% dataArray =[ 1.5, 1.764; 3.523, 0.2 ];
% matrix2latex( dataArray, 'out.tex', '%-6.2f', true );
%
%%%%%%%%%%%%%%%%%%%
% matrix2tabularlatex( dataArray, filenameString, formatString )
%%%%%%%%%%%%%%%%%%%

if nargin <4
    inlineNumberFormatTrue =true;
end

fid =fopen(filenameString, 'w');

numCols =size(dataArray, 2);
numRows =size(dataArray, 1);

if isnumeric(dataArray)
    dataArray =num2cell(dataArray);
    for h=1:numRows
        for w=1:numCols
            if(~isempty(formatString))
                dataArray{h, w} =num2str(dataArray{h, w}, formatString);
            else
                dataArray{h, w} =num2str(dataArray{h, w});
            end
        end
    end
end

for h=1:numRows
    if inlineNumberFormatTrue
        fprintf(fid, ['$', dataArray{h, numCols}] );
    end
    for w=1 :(numCols-1)
        if inlineNumberFormatTrue
            fprintf( fid, '%s$ & $', dataArray{h, w} );
        else
            fprintf( fid, '%s & ', dataArray{h, w} );
        end
    end
    if inlineNumberFormatTrue
        fprintf(fid, '%s$ \\\\\r\n', dataArray{h, numCols});
    else
        fprintf(fid, '%s \\\\\r\n', dataArray{h, numCols});
    end
end
fclose(fid);
end