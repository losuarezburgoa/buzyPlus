function [ interesectionTrendPlungeVec ,calcCriteriumResidual ] =...
    first_point_cluster_greatcircle_intersection( coneAxisPlunge ,coneSemiAngleGrad )
%lsb code
%
%[ interesectionTrendPlungeVec ,calcCriteriumResidual ] =...
%    first_point_cluster_greatcircle_intersection( coneAxisPlunge ,coneSemiAngleGrad )
%
%Description:
%Search the point of intersection of a circular cluster, trending
%90, with the extreme northeastward part of the great circle. This pont is
%also located also in he north east quadrant.
%
%Nested function(s):
%reduceminimal90angle, rot_orient_arnd_northernstrike
%
%Input(s):
%Plunge of the cone axis, or center of the circular cluster
%(coneAxislPunge).
%
%Angle between the cone axis and the generatrix of the cone, semi angle of
%the cone, in hexagesimal angular grades (coneSemiAngleGrad).
%
%Output(s):
%Orientation of the itersection point in trend and plunge format
%(interesectionTrendPlungeVec). Note that this orientation always has a
%plunge equal to zero and a trend between 0 and 90.
%
%Residue of the iterative calculation (calcCriteriumResidual). This is
%given as iformation, because the iteratie process is aproximated.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%[ interesectionTrendPlungeVec ,calcCriteriumResidual ] =...
%    first_point_cluster_greatcircle_intersection( coneAxisPlunge ,coneSemiAngleGrad )

%Input vallues may not be greater than 90
coneAxisPlunge =reduceminimal90angle( coneAxisPlunge );
coneSemiAngleGrad =reduceminimal90angle( coneSemiAngleGrad );

%Calculation accuracy
accuracy =10^(-10);

%Initial and final extreme trends
evaluationTrend1 =0;
evaluationTrend2 =90;

%Evaluation if it is necessary to do the iteration
a =coneAxisPlunge -coneSemiAngleGrad;
if a >=0
    calcCriteriumResidual =accuracy;
    interesectionTrendPlungeVec =zeros(0);
    return;
end

%Special case when cone axis plunge is zero
if coneAxisPlunge ==0
    calcCriteriumResidual =accuracy;
    interesectionTrendPlungeVec =[ (90 -coneSemiAngleGrad) ,0 ]; 
    return;
end

%Beginning the iteration for the rest of the cases
calcCriteriumResidual =100;
while calcCriteriumResidual >accuracy
    calcCriteriumResidual1 =iteration( coneAxisPlunge ,coneSemiAngleGrad ,evaluationTrend1 );
    calcCriteriumResidual2 =iteration( coneAxisPlunge ,coneSemiAngleGrad ,evaluationTrend2 );
    if and( calcCriteriumResidual1 >0, calcCriteriumResidual2 >0 )
        error('No convegension exist');
    else
        if and( calcCriteriumResidual1 <0, calcCriteriumResidual2 <0 )
            error('No convegension exist');
        else
            evaluationTrend =(evaluationTrend1 +evaluationTrend2) /2;
            calcCriteriumResidual =iteration( coneAxisPlunge ,coneSemiAngleGrad ,evaluationTrend );
            if and( calcCriteriumResidual1 >=0, calcCriteriumResidual2 <0 ) 
                if calcCriteriumResidual <0
                    evaluationTrend2 =evaluationTrend;
                else
                    evaluationTrend1 =evaluationTrend;
                end
            else
                if and( calcCriteriumResidual1 <0, calcCriteriumResidual2 >=0 )
                    if calcCriteriumResidual <0
                        evaluationTrend1 =evaluationTrend;
                    else
                        evaluationTrend2 =evaluationTrend;
                    end
                else
                    error('No convegension exist');
                end
            end        
        end
    end
    calcCriteriumResidual =abs(calcCriteriumResidual);
end
[ calcCriteriumResidual ,interesectionTrendPlungeVec ] =...
    iteration( coneAxisPlunge ,coneSemiAngleGrad ,evaluationTrend );  
end

function [ calcCriteriumResidual ,interesectionTrendPlungeVec ] =...
    iteration( coneAxisPlunge ,coneSemiAngleGrad ,evaluationTrend )
%lsb code
%
%Description:
%This subfunction englobes the iteration process
%
%Input(s):
%
%The evaluation angle (evaluationAnge) is that angle counting from the
%northern axis in clockwise sense of the evaluated radius of
%the cone. It varies from 0 when the cone radius coincides with
%north direction up to 90 when the cone radius coincides with the east
%direction.
%%%%%%%%%%%%%%%%%%%%%%%%%%

%With the cone vertically
%Angle may not be grater than 90 grades
evaluationTrend =reduceminimal90angle( evaluationTrend );
evaluationPlunge =(90 -coneSemiAngleGrad);

evaluationVec =[ evaluationTrend , evaluationPlunge ];

%Rotating the cone to the plunge inclination
interesectionTrendPlungeVec =rot_orient_arnd_northernstrike( evaluationVec ,-(90 -coneAxisPlunge) );

if interesectionTrendPlungeVec(1) >180
     interesectionTrendPlungeVec(1) =interesectionTrendPlungeVec(1)-180;
     interesectionTrendPlungeVec(2) =-interesectionTrendPlungeVec(2);
end
calcCriteriumResidual =interesectionTrendPlungeVec(2);

end


