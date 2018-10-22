function [ planeStrikeDipVec ,pitchAngleGrad ] =...
    trendplunge2pitch_northstriking_dip( trendPlungeVec )
%lsb code
%function [ planeStrikeDipVec ,pitchAngleGrad ] =...
%    trendplunge2pitch_northstriking_dip( trendPlungeVec )
%
%Description:
%Obtains the north or south striking plane, in strike and dip format, and
%the pitch angle in that plane of a given orientation line given in trend
%and plunge format.
%
%Nested function(s):
%trendplunge2unitvect, twovectors2trendplunge, dipdirdip2pole,
%dipdirdip2strikedip
%
%Input(s):
%Orientation of a line given in trend and plunge vector (trendPlungeVec)
%
%Output(s):
%Plane orientation that contains the line, in strike and dip format (planeStrikeDipVec)
%
%Pitch angle in hexagesimal angular grades (pitchAngleGrad)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [ planeStrikeDipVec ,pitchAngleGrad ] =...
%    trendplunge2pitch_northstriking_dip( trendPlungeVec )

%Trend-plunge orientation may vary only accordingly the southern hemisphere
trendPlungeVec =prepareorientationangles( trendPlungeVec );

%This analysis is restricted to a trend variation of 0 to 180
if trendPlungeVec(1) >=180
    if trendPlungeVec(1) ==180
        planeStrikeDipVec =[180 ,90];
        pitchAngleGrad =trendPlungeVec(2);
        return;
    end
    
    if trendPlungeVec(2) ==0
        planeStrikeDipVec =[180 ,0];
        pitchAngleGrad =trendPlungeVec(1) -180;
        return;
    end
    trendPlungeVec(1) =trendPlungeVec(1) -180;
    %In plane uni-vector
    orientationUnitVec =trendplunge2unitvect( trendPlungeVec );
    %Strike unit vector
    strikeUnitVec =[1 0 0];
    
    %Plane formed by line orientation and strike
    planePole =twovectors2trendplunge( strikeUnitVec ,orientationUnitVec );
    if planePole(2) ==90
        planePole(1) =0;
    end
    
    %Obtaining the pitch value of the orientation for that plane
    pitchDot =dot( strikeUnitVec ,orientationUnitVec );
    pitchAngleGrad =acos( pitchDot ) *180 /pi;
    
    planeDipdirDip =dipdirdip2pole( planePole );
    %Plane orientation dip-direction dip
    planeStrikeDipVec =dipdirdip2strikedip( planeDipdirDip );
    planeStrikeDipVec(1) =planeStrikeDipVec(1) +180;
else
    if trendPlungeVec(1) ==0
        planeStrikeDipVec =[0 ,90];
        pitchAngleGrad =trendPlungeVec(2);
        return;
    end
    
    if trendPlungeVec(2) ==0
        planeStrikeDipVec =[0 ,0];
        pitchAngleGrad =trendPlungeVec(1);
        return;
    end
    %In plane uni-vector
    orientationUnitVec =trendplunge2unitvect( trendPlungeVec );
    %Strike unit vector
    strikeUnitVec =[1 0 0];
    
    %Plane formed by line orientation and strike
    planePole =twovectors2trendplunge( strikeUnitVec ,orientationUnitVec );
    if planePole(2) ==90
        planePole(1) =0;
    end
    
    %Obtaining the pitch value of the orientation for that plane
    pitchDot =dot( strikeUnitVec ,orientationUnitVec );
    pitchAngleGrad =acos( pitchDot ) *180 /pi;
    
    planeDipdirDip =dipdirdip2pole( planePole );
    %Plane orientation dip-direction dip
    planeStrikeDipVec =dipdirdip2strikedip( planeDipdirDip );
end

end

