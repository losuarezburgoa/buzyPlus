function [ dipdirDipArray ] =strikedip2dipdirdip( strikeDipArray )
% Description:
% Transforms data expressed un strike/dip into dip-direction/dip.
%
% Example1:
% strikeDipArray =[ 0, 10; 90, 50; 180, 60; 270, 85; 360, 20 ];
%

numData =size( strikeDipArray, 1 );

dipdirDipArray =zeros( numData, 2 );
for i=1 :numData
    dipdirDipArray(i,:) =strk2dipditconv( strikeDipArray(i,:) );
end

end

function dipdirDip =strk2dipditconv( strikeDip )
  %strikeDip =prepareorientationangles( strikeDip );
  dipdirDip =zeros(1,2);
  
  dipdirDip(1) =strikeDip(1) +90;
  dipdirDip(2) =strikeDip(2);
  
  if dipdirDip(1) >360;
      dipdirDip(1) =dipdirDip(1) -360;
  end
end
