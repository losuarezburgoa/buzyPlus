function [ fifteenPointsMat ] =create_subcluster( subClusterlocationVec...
                ,type2SubClusters, type3SubClusters ,want2plot )
%lsb code
%[ fifteenPointsMat ] =create_subcluster( subClusterlocationVec
%      ,type2SubClusters, type3SubClusters )
%
%Description:
%Creates the side cllluster by specifying the points that makes the closed
%region of it.
%
%Input(s):
%Vector 1x3 specifying the location of the cluster. 
%The first column refers to the number that locates the sub-cluster
%annulus. It varies from 1 to 10. The first is located at the most close to
%center of the global net and the last is located at the most close to the
%extreme of the global net.
%The second column refers to so called 'pseudo-radius', it varies also from
%1 to 10, being the first one refering to the horizontal radius.
%The thrid column refers to the Subcluster Type. It is an integer number
%form 2 to 3 specifying sub-cluster type.
%
%Matrix of fourth dimension (10 x10 x3 x2 ) of sub-clusters of type 2
%(type2SubClusters). The first dimension refers to the annulus location,
%the second dimension to the pseudo-rdius location, the thrid dimension
%refers each of the three points that the triangular sub-cluster has and
%the fourth dimension refers to the polar cordinates angle and radius.
%
%Matrix of fourth dimension (10 x10 x3 x2 ) of sub-clusters of type 3
%(type3SubClusters). It has the same structre as the last mentioned.
%
%Output(s):
%Matrix of 15x2 size giving the polar coordinates of the points that
%conforms the closed sub-cluster (fifteenPointsMat)
%%%%%%%%%%%%%%%%%%%%%%%%%5
%[ fifteenPointsMat ] =create_subcluster( subClusterlocationVec
%      ,type2SubClusters, type3SubClusters )

referenceSphereRadius =1;

scAnnulus =subClusterlocationVec(1);
scPseudoRadius =subClusterlocationVec(2);
scType =subClusterlocationVec(3);

switch scType
    case 1
        %Type 1 subcluster
        threePtsPolCoordMat =squeeze( type2SubClusters(scAnnulus ,scPseudoRadius ,: ,:) );
        
        totalArcLengthRad =threePtsPolCoordMat(3,1) -threePtsPolCoordMat(2,1);
        arcSegmentRad =totalArcLengthRad /12;
        arcPointsMat =ones(13 ,2) *threePtsPolCoordMat(2,2);
        arcPointsMat(:,1) =linspace(0 ,12, 13) *arcSegmentRad +threePtsPolCoordMat(2,1);
        fifteenPointsMat =[ threePtsPolCoordMat(1,:) ;arcPointsMat ;threePtsPolCoordMat(1,:) ];
    case 2
        %Type 2 subcluster
        threePtsPolCoordMat =squeeze( type3SubClusters(scAnnulus ,scPseudoRadius ,: ,:) );
        
        totalArcLengthRad =threePtsPolCoordMat(3,1) -threePtsPolCoordMat(1,1);
        arcSegmentRad =totalArcLengthRad /12;
        arcPointsMat =ones(13 ,2) *threePtsPolCoordMat(1,2);
        arcPointsMat(:,1) =linspace(0 ,12, 13) *arcSegmentRad +threePtsPolCoordMat(1,1);
        fifteenPointsMat =[ threePtsPolCoordMat(1,:) ;threePtsPolCoordMat(2,:) ;flipud(arcPointsMat) ];
    otherwise
        error('bad type option');
end
%Plotting the sub-cluster
if want2plot
    hold on
    axis( referenceSphereRadius *[-1 1 -1 1], 'square' , 'off' );
    polar( fifteenPointsMat(:,1) ,fifteenPointsMat(:,2) ,'-');
end

end
