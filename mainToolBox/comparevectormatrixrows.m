function [ locationVec ] =comparevectormatrixrows( vector, matrix )
%
% Description:
% Compares the elements of a row vector (1xn) with the row elemets of a mxn
% matrix. The variable 'locationVec' gives those row-indexes where the
% coincidence at the input matrix is attained. 
%
% Input(s):
% Row vector that is wanted to compare (vector), is size 1xn.
%
% Matrix (mxn) whose rows will be compared with the vector (matrix); m is
% the number of data.
%
% Output(s):
% A vector of 1xp size, where p is the number of true coincidences and each
% element gives the index of the row location in the input matrix.
%
% Example1:
% vector =[ 3, 4, 5 ]
% matrix =[ 5, 8, 7; 3, 4, 5; 8, 7, 4 ]
% returns a 1x1 vector with a value of 2, bacause the row vector repeats in
% the second row of the matrix. 
%
% Example2:
% vector =[ 3, 4, 5 ]
% matrix =[ 5, 8, 7; 3, 4, 5; 8, 7, 4; 5, 8, 6; 3, 4, 5 ]
% returns a 1x2 vector with values of 2 and 5, because the row vector
% repeasts in the rows of the matrix in the rows 2 and 5.
%
% Example3:
% vector =[ 5 8 9 3 4 6 ];
% matrix =[ 8 5 8 9 6 3; 4 1 2 8 2 4; 4 0 5 2 -9 5; 5 8 9 3 4 6 ];
% returns [4].
% 
% Example4:
% vector =[]; matrix =[], returns [empty]
%
% Example5:
% vector =[ 1 2 3 ]; matrix =[ 1 1 1; 5 8 5 ] returns [empty].
%
% Example6:
% vector =[ 1 8 5 6 ]; matrix =[ 5 8 7; 3 4 5; 8 7 4 ] returns error.
% Example 7:
% vector =[1; 8; 3]; matrix =[1 8 3] returns [1].
%
%%%%%%%%%%%%
% logicalVec =comparevectormatrixrows( vector, matrix )
%%%%%%%%%%%%

% Guaratying that vector is always a row vector, otherwise this function
% converts to that for evaluation.
vector =vector(:);
vector =transpose(vector);

% If size do not match raises an error.
if length(vector) ~= size(matrix,2)
    error( 'Matrix  number of columns are not equal to the length of the vector');
end
    
% Evaluationg each row.
errorTol =eps; % tolerance
logicalVec =true(1,size(matrix,1));
for j=1:size(matrix,1)
    for i=1:length(vector)
         % for float numbers comparisons exist a tolerance
        if abs(vector(i)-matrix(j,i)) <=errorTol
            eval1 =true;
        else
            eval1 =false;
        end
    logicalVec(j) =and(logicalVec(j), eval1);
    end
end
locationVec =find(logicalVec);

end