function [ type2SubClusters ,type3SubClusters ] =...
    create_kalsbeek_sector_countnet( kalsbeekSector ,want2plot )

%Description:
%Creates the triagles of equal area of the any of the six main sectors of
%Kalsbeek couting net and displays it. 
%
%Nested function(s):
%create_subcluster
%
%Related function:
%clusterwithtrinagulatprojectedwindowmanually,
%
%Input(s)
%Integer number from 1 to 6 to specify the sector which cuntnets is desired
%to create (kalsbeekSector).
%
%Outputs(s)
%Matrix of fourth dimension (10 x10 x3 x2 ) of sub-clusters of type 2
%(type2SubClusters). The first dimension refers to the annulus location,
%the second dimension to the pseudo-rdius location, the thrid dimension
%refers each of the three points that the triangular sub-cluster has and
%the fourth dimension refers to the polar cordinates angle and radius.
%
%Matrix of fourth dimension (10 x10 x3 x2 ) of sub-clusters of type 3
%(type3SubClusters). It has the same structre as the last mentioned.


if kalsbeekSector >=1
    if kalsbeekSector <=6
        kalsbeekSector =floor(kalsbeekSector);
    else
        error('kalsbeek has only from 1 to 6 sectors. Specify an interger number from 1 to 6');
    end
else
    error('kalsbeek has only from 1 to 6 sectors. Specify an interger number from 1 to 6');
end

referenceSphereRadius =1;
sectorAngleRad =2 *pi /6;
initialSectorAngle =(kalsbeekSector -1) *60 *pi /180;

annulusVec =linspace(1 ,10, 10);

%Sector vertices
[ a ,b ] =meshgrid(annulusVec);
alphaMat =a ./b .*sectorAngleRad +initialSectorAngle;
alphaMat1 =tril(alphaMat);
ind = alphaMat1 ==0;
alphaMat1(ind) =NaN;

rhoVec =referenceSphereRadius /10 *annulusVec;
tempo01 =length(alphaMat);
rhoMat =zeros(tempo01);
for i=1 :tempo01
    rhoMat(i ,:) =rhoVec(i);
end
rhoMat1 =tril(rhoMat);
ind = rhoMat1 ==0;
rhoMat1(ind) =NaN;
%polar( alphaMat1(:) ,rhoMat1(:) ,'bo' );

%subClusters vertices matrices
tempo02 =ones( size(alphaMat1,1) , 1) *initialSectorAngle;
alphaSubClustVertexMat =[ tempo02 ,alphaMat1 ];
tempo03 =NaN( 1, size(alphaSubClustVertexMat ,2) );
tempo03(1 ,1) =0;
alphaSubClustVertexMat =[ tempo03 ; alphaSubClustVertexMat ];

tempo04 =rhoMat(: ,1);
rhoSubClustVertexMat =[ tempo04 ,rhoMat1 ];
rhoSubClustVertexMat =[ tempo03 ;rhoSubClustVertexMat ];
%polar( alphaSubClustVertex(:) ,rhoSubClustVertex(:) ,'bo' );


%Creating Type 2 and 3 sub clusters. They are a four dimension matrix of
%the form: annulus, pseudo_radius, vertex_point, polar_coordinate
pseudoRadiusQuantity =size( alphaSubClustVertexMat ,2 ) -1;
annulusQuantity =size( alphaSubClustVertexMat, 1 ) -1;
vertexPointsQnt =3;
polarCoordsQnt =2;
type2SubClusters =NaN( pseudoRadiusQuantity ,annulusQuantity ,vertexPointsQnt ,polarCoordsQnt );
type3SubClusters =NaN( pseudoRadiusQuantity ,annulusQuantity ,vertexPointsQnt ,polarCoordsQnt );

%FILLING THE MATRICES
%Matrix of Type 2 subclusters
%The first point of the subcluster type 2 is low-left one, the second is the
%low-rigth node and the third is the upppest node. Count of point numbers is made
%couterclockwise.
%For example if is desired to know the alpha value of the firt point of the
%type 2 subcluster located at the 5th annulus and 4th pseudoradius one
%should calle the matrix as: type2SubClusters(5 ,4 ,1, 1)
%Alpha coordinates of point 1
type2SubClusters(:,:,1,1) =alphaSubClustVertexMat(1:end-1 ,1:end-1);
%Alpha coordinates of point 2
type2SubClusters(:,:,2,1) =alphaSubClustVertexMat(2:end ,1:end-1);
%Alpha coordinates of point 3
type2SubClusters(:,:,3,1) =alphaSubClustVertexMat(2:end ,2:end);

%Rho coordinates of point 1
type2SubClusters(:,:,1,2) =rhoSubClustVertexMat(1:end-1 ,1:end-1);
%Rho coordinates of point 2
type2SubClusters(:,:,2,2) =rhoSubClustVertexMat(2:end ,1:end-1);
%Rho coordinates of point 3
type2SubClusters(:,:,3,2) =rhoSubClustVertexMat(2:end ,2:end);

%Matrix of Type 3 subclusters
%The first point of the subcluster type 3 is lowest one, the second is the
%up-rigth node and the third is the up-left node. Count of poit numbers is made
%couterclockwise.
%For example if is desired to know the rho value of the second point of the
%type 3 subcluster located at the 7th annulus and 5th pseudoradius one
%should calle the matrix as: type3SubClusters(7 ,5 ,2, 2)
%Alpha coordinates of point 1
type3SubClusters(2:end ,1:end-1 ,1 ,1) =alphaSubClustVertexMat(2:end-1 ,1:end-2);
%Alpha coordinates of point 2
type3SubClusters(2:end ,1:end-1 ,2 ,1) =alphaSubClustVertexMat(3:end ,2:end-1);
%Alpha coordinates of point 3
type3SubClusters(2:end ,1:end-1 ,3 ,1) =alphaSubClustVertexMat(2:end-1 ,2:end-1);

%Rho coordinates of point 1
type3SubClusters(2:end ,1:end-1 ,1 ,2) =rhoSubClustVertexMat(2:end-1 ,1:end-2);
%Rho coordinates of point 2
type3SubClusters(2:end ,1:end-1 ,2 ,2) =rhoSubClustVertexMat(3:end ,2:end-1);
%Rho coordinates of point 3
type3SubClusters(2:end ,1:end-1 ,3 ,2) =rhoSubClustVertexMat(2:end-1 ,2:end-1);

%PLOTTING ONE BY ONE ALL THE SUBCLUSTERS
if want2plot ==true
    types =1:2;
    annulus =1:10;
    pseudoRadius =1:10;
    
    [ dim1, dim3 ,dim2 ] =meshgrid( types, annulus ,pseudoRadius );
    X =[ dim2(:) ,dim3(:) ,dim1(:) ];
    for i=1 :length(X)
        create_subcluster( X(i,:) ,type2SubClusters ,type3SubClusters, true );
    end
end

end

