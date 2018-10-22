function [rotatedTrendPlungeVec] = rot_orient_arnd_northernstrike ...
    (trendPlungeVec, rotationAngleGrad)
%lsb code
%[ rotatedTrendPlungeVec ,planeStrikeDipVec ,pitchAngleGrad ] =...
%    rot_orient_arnd_northernstrike( inPlaneTrendPlungeVec ,rotationAngleGrad )
%
%Description:
%Rotates a orientation, contained in a northern striking plane, around its
%strike a given rotation angle. If the rotation angle is positive the
%rotation is clockwise, else is couterclockwise.
%
%Nested function(s):
%prepareorientationangles, trendplunge2unitvect, dipdirdip2strikedip,
%twovectors2trendplunge, dipdirdip2pole, pitchstrikedip2trendplunge
%
%Input(s):
%Vector of trend and plunge values of the orientation that belongs to the
%northern striking plane (inPlaneTrendPlungeVec).
%
%Rotation angle in hexadecimal angular grades. If it is positie it rotates
%clockwise when seeing northwards, if negative it rotates counterclockwise
%(rotationAngleGrad). 
%
%Output(s):
%Vector of trend and plunge values that indicates the rotated orientation
%(rotatedTrendPlungeVec)
%
% Example1:
% trendPlungeVec = [356, 0];
% rotationAngleGrad = 90;
% rotatedTrendPlungeVec = rot_orient_arnd_northernstrike(trendPlungeVec, rotationAngleGrad);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ rotatedTrendPlungeVec ,planeStrikeDipVec ,pitchAngleGrad ] =...
%    rot_orient_arnd_northernstrike( inPlaneTrendPlungeVec ,rotationAngleGrad )
%

%Rotation angle may vary only between ]-360, 360[
rotationAngleGrad =reduceminimal360angle( rotationAngleGrad );
%Trend-plunge orientation may vary only accordingly the southern hemisphere
trendPlungeVec =prepareorientationangles( trendPlungeVec );

%Obtaining the northern or southern striking plane that contains the
%orientation and the pitch angle
[ planeStrikeDipVec ,pitchAngleGrad ] =...
    trendplunge2pitch_northstriking_dip( trendPlungeVec );

%Creating the rotated plane vector
rotatedPlaneStrikeDipVec =zeros(1,2);

%Obtaining the dip +rotationAngle value
if planeStrikeDipVec(1) ==0
    %cases A
    totalAngle =planeStrikeDipVec(2) +rotationAngleGrad; 
else
    if planeStrikeDipVec(1) ==180
    %cases B
    totalAngle =planeStrikeDipVec(2) -rotationAngleGrad;
    else
        error('the funtion only evaluates 0 and 180 striking planes');
    end
end
totalAngle =reduceminimal360angle( totalAngle );
if totalAngle <0
    totalAngle =360 +totalAngle;
end

%Chossing the properly case to rotate the plane
if pitchAngleGrad <0
    error('The pitch angle may not be less than 0�');
else
    if pitchAngleGrad <=180
        if totalAngle >270
            caseType ='swpos';
        else
            if totalAngle >180
                caseType ='sepos';
            else
                if totalAngle >90
                    caseType ='nwpos';
                else
                    if totalAngle >=0
                        caseType ='nepos';
                    else
                        if totalAngle >=-90
                            caseType ='nwneg';
                        else
                            if totalAngle >=-180
                                caseType ='seneg';
                            else
                                if totalAngle >=-270
                                    caseType ='nwneg';
                                else
                                    caseType ='neneg';
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        error('The pitch angle may not be greater than 180!');
    end
end

%Evaluating cases
switch caseType
    case 'nepos'
        rotatedPlaneStrikeDipVec(1) =0;
        rotatedPlaneStrikeDipVec(2) =totalAngle;
        pitchAngleGrad =0 +pitchAngleGrad;
        %disp('north east positive');
    case 'nwpos'
        rotatedPlaneStrikeDipVec(1) =180;
        rotatedPlaneStrikeDipVec(2) =180 -totalAngle;
        pitchAngleGrad =180 -pitchAngleGrad;
        %disp('north west positive');
    case 'swpos'
        rotatedPlaneStrikeDipVec(1) =180;
        rotatedPlaneStrikeDipVec(2) =360 -totalAngle;
        pitchAngleGrad =0 +pitchAngleGrad;
        %disp('south west positive');
    case 'sepos'
        rotatedPlaneStrikeDipVec(1) =0;
        rotatedPlaneStrikeDipVec(2) =totalAngle -180;
        pitchAngleGrad =180 -pitchAngleGrad;
        %disp('south east positive');
    case 'neneg'
        rotatedPlaneStrikeDipVec(1) =0;
        rotatedPlaneStrikeDipVec(2) =360 +totalAngle;
        pitchAngleGrad =0 +pitchAngleGrad;
        %disp('north east negative');
    case 'nwneg'
        rotatedPlaneStrikeDipVec(1) =180;
        rotatedPlaneStrikeDipVec(2) =-totalAngle;
        pitchAngleGrad =0 +pitchAngleGrad;
        %disp('north west negative');
    case 'swneg'
        rotatedPlaneStrikeDipVec(1) =180;
        rotatedPlaneStrikeDipVec(2) =-180 -totalAngle;
        pitchAngleGrad =180 -pitchAngleGrad;
        %disp('south west negative');
    case 'seneg'
        rotatedPlaneStrikeDipVec(1) =0;
        rotatedPlaneStrikeDipVec(2) =180 +totalAngle;
        pitchAngleGrad =180 -pitchAngleGrad;
        %disp('south east negative');
    otherwise
        disp('otherwise');
        return;
end

%Transforming the orientation from pitch-strike-dip format to trend-plunge
%format
rotatedTrendPlungeVec = pitchstrikedip2trendplunge(rotatedPlaneStrikeDipVec, pitchAngleGrad);

if planeStrikeDipVec(1) == 180
    %cases B
    rotatedTrendPlungeVec(1) = rotatedTrendPlungeVec(1) + 180;
end
%Preparing the angle for correct answer
rotatedTrendPlungeVec = prepareorientationangles(rotatedTrendPlungeVec);

endfunction


