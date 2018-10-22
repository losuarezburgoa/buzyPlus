function [ logicAfirm ,errMsg ] = verifyorthonorm( transMat )

%Description:
% Verifies the orthonormality of the transformation matrix
% (transMat) by given the result of a logical variable (logicAfirm) and explaining
% a possible error in the message stored in errMsg. 
% If logicAfirm is true, the transformation matrix is orthonormal.
% If this variable is false, a calibration process should be performed.
%
% Inputs:
% Transformation matrix, a 3x3 matrix (transMat)
%
% Outputs: 
% A logical variable (logicAfirm), if 'true' the verification is
% acomplished and the error message (errMsg) is an empty text chain.
% If logicAfirm is false an error mesage is stored in (errMsg).
%
% Example1:
% Example2:
%%%%%%%%%%%%
% [ logicAfirm ,errMsg ] = verifiesorthonorm( transMat )
%%%%%%%%%%%%


%% Ortogonality
%Verification by rows
verOrtRow01 =dot( transMat(1,:), transMat(2,:) );
verOrtRow02 =dot( transMat(1,:), transMat(3,:) );
verOrtRow03 =dot( transMat(2,:), transMat(3,:) );
%Verification by colums
verOrtCol01 =dot( transMat(:,1), transMat(:,2) );
verOrtCol02 =dot( transMat(:,1), transMat(:,3) );
verOrtCol03 =dot( transMat(:,2), transMat(:,3) );

nearZero = verOrtRow01 +verOrtRow02 +verOrtRow03 +verOrtCol01 +verOrtCol02 +verOrtCol03;

%% Unitary
%Verification by rows (e.g. verUnitRow01 comes from 'verfication of unitary row
%01')
verUnitRow01 =norm( transMat(1,:) );
verUnitRow02 =norm( transMat(2,:) );
verUnitRow03 =norm( transMat(3,:) );
%Verification by colums (e.g. verUnitCol01 comes from 'verification of
%unitary column 01')
verUnitCol01 =norm( transMat(:,1) );
verUnitCol02 =norm( transMat(:,2) );
verUnitCol03 =norm( transMat(:,3) );

nearOne = verUnitRow01 *verUnitRow02 *verUnitRow03 *verUnitCol01 *verUnitCol02 *verUnitCol03;
% The nearOne variable evals the unitary condition, since the nearZero
% variable evals the orthogonality condition.
% For future versions, look for a mathematical method to evaluated
% unitarity and orthogonality of a transformation matrix.
% Values of 10^-10 and 10^-5 for the limiting vallues of where assummed without any analytical criteria.
errMsg= '';
if nearZero <= 10^-(10)
    logicOrtho =true;
else
    logicOrtho =false;
    errMsg ='The matrix is not othonormal';
end
if nearOne > 1 -10 ^(-5)
    if nearOne <1 +10 ^(-5)
    logicUnit =true;
    else
        logicUnit =false;
        errMsg ='One column or row of the matrix is not unitary';
    end
else
    logicUnit =false;
    errMsg ='One column or row of the matrix is not unitary';
end
logicAfirm = and(logicOrtho, logicUnit); %logicAfirm comes from loical affirmation
end
