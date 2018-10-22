function [ attitudeStructure ] =createattitudestructure01( trendPlungeMat ,scanlineDirectionVec )
%lsb code
%
%Description:
%Creates a attitude structure obtained by a scanline survey. The function
%groups attitudes that are equal and corrects the bias error of the survey.
%
%Input(s):
%The matrix having the planes poles orientation given in trend and plunge
%format (trendPlungeMat).
%
%Vector having the direction of the scan line used to obtain the planes
%orietations (scanlineDirectionVec).
%
%Output(s):
%Structure of the attitude values (attitudeStructure). Is a n x 4 matrix,
%where the two first columns are the trend and plunge values of non
%repeated pole orientations, the third column has the frequencies values of
%each orientation value, if there is so, and the fourth column gives the
%individual correction weigth given by the bias correction procedure.

arrangedFrequencyMat =findorientationsfrequencies( trendPlungeMat );
[ correctedTrendPlungeVec, weigthFactorsVec ] =correctbiasinscanlineorientations( arrangedFrequencyMat(: ,1:2) ,scanlineDirectionVec );

attitudeStructure =[ correctedTrendPlungeVec ,arrangedFrequencyMat(: ,3) ,weigthFactorsVec ];

end

