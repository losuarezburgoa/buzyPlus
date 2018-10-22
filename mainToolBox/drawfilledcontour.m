function [ ] =drawfilledcontour( extendedAverageValuesGrid...
    ,contourIntervalPercentaje ,filledCountType ,colorMap )
%lsb code
%
%Description:
%Draws appoximately the filled contours, accordingly a desired color-map.
%In this case a polar interpolatioin grid is created. Grids are composed by
%circular sector of no constant area. Filled contour is accurate in the
%center of the great circle and decreases as the appear away of the
%center. It should be used in conjunction with the
%'interpolaterelativemovingaverages' funtion.
%
%Input(s):
%String specifyig the type of the filled contourn (filledCountType), can be
%'2Dfilled' or '3Dmesh'.
%
%String specifying the type of color map of the filled contourns
%(colorMap), can be: gray inverted tones 'grayi', terrain colors 'terrain'
%and the standard MatLab colo maps (e.g. 'jet' 'gray' 'cool' 'hot').
%
%Example:
%drawfilledcontour( extendedAverageValuesGrid ,1 ,'2Dfilled' ,'grayi' );
%%%%%%%%%%%%%%%%%%%%%%%%

%Radius of the reference shere = radius of the reference major great circle
sphereRadius =1;
%Divisions in where the net will e divided,calcualted bu giving an angle
%interval
angleIntervalGrad =1;
alphaDivisions =floor(360 /angleIntervalGrad) +1;
rhoDivisions =floor(90 /angleIntervalGrad) +1;

%Creating the destine grid
rhoVector =linspace( 0 ,sphereRadius, rhoDivisions +1 );
alphaVector =linspace( 0 ,2 *pi ,alphaDivisions +1 );

[ destineThetaMat ,destineRhoMat ] =meshgrid( alphaVector ,rhoVector );
[ destineXMat ,destineYMat ] =pol2cart( destineThetaMat ,destineRhoMat );

%Assigning the reference matrices
referenceXVec =extendedAverageValuesGrid(:,1);
referenceYVec =extendedAverageValuesGrid(:,2);
referenceZVec =extendedAverageValuesGrid(:,4);

%Interpolation
% Methods can be: 'linear', 'cubic', 'nearest' or 'v4'
# In Octave: The 'cubic' interpolation method is not yet implemented.
#            The 'v4' interpolation method does not exisit.

destineZMat = griddata( referenceXVec ,referenceYVec ,referenceZVec...
    ,destineXMat ,destineYMat, 'linear' );

%Resampling ZMat for negative noisy values
negativeIndexes =destineZMat <0;
resampledDestineZMat =destineZMat;
resampledDestineZMat(negativeIndexes) =0;

%Final Zmat
finalDestineZmat =resampledDestineZMat;

%Number of countorns
maxValue =max( max( finalDestineZmat ) );
numberCountorns= floor( maxValue /contourIntervalPercentaje ) +1;
maxCountValue =numberCountorns *contourIntervalPercentaje;

%Monotonically increasing vector v
v =linspace( 0, maxCountValue ,numberCountorns+1 );

%NEW COLOR MAPS
%Gray Tones Color Map 'grayi'
uGrayColorMap =...
  [ 1.0000    1.0000    1.0000;
    0.9841    0.9841    0.9841;
    0.9683    0.9683    0.9683;
    0.9524    0.9524    0.9524;
    0.9365    0.9365    0.9365;
    0.9206    0.9206    0.9206;
    0.9048    0.9048    0.9048;
    0.8889    0.8889    0.8889;
    0.8730    0.8730    0.8730;
    0.8571    0.8571    0.8571;
    0.8413    0.8413    0.8413;
    0.8254    0.8254    0.8254;
    0.8095    0.8095    0.8095;
    0.7937    0.7937    0.7937;
    0.7778    0.7778    0.7778;
    0.7619    0.7619    0.7619;
    0.7460    0.7460    0.7460;
    0.7302    0.7302    0.7302;
    0.7143    0.7143    0.7143;
    0.6984    0.6984    0.6984;
    0.6825    0.6825    0.6825;
    0.6667    0.6667    0.6667;
    0.6508    0.6508    0.6508;
    0.6349    0.6349    0.6349;
    0.6190    0.6190    0.6190;
    0.6032    0.6032    0.6032;
    0.5873    0.5873    0.5873;
    0.5714    0.5714    0.5714;
    0.5556    0.5556    0.5556;
    0.5397    0.5397    0.5397;
    0.5238    0.5238    0.5238;
    0.5079    0.5079    0.5079;
    0.4921    0.4921    0.4921;
    0.4762    0.4762    0.4762;
    0.4603    0.4603    0.4603;
    0.4444    0.4444    0.4444;
    0.4286    0.4286    0.4286;
    0.4127    0.4127    0.4127;
    0.3968    0.3968    0.3968;
    0.3810    0.3810    0.3810;
    0.3651    0.3651    0.3651;
    0.3492    0.3492    0.3492;
    0.3333    0.3333    0.3333;
    0.3175    0.3175    0.3175;
    0.3016    0.3016    0.3016;
    0.2857    0.2857    0.2857;
    0.2698    0.2698    0.2698;
    0.2540    0.2540    0.2540;
    0.2381    0.2381    0.2381;
    0.2222    0.2222    0.2222;
    0.2063    0.2063    0.2063;
    0.1905    0.1905    0.1905;
    0.1746    0.1746    0.1746;
    0.1587    0.1587    0.1587;
    0.1429    0.1429    0.1429;
    0.1270    0.1270    0.1270;
    0.1111    0.1111    0.1111;
    0.0952    0.0952    0.0952;
    0.0794    0.0794    0.0794;
    0.0635    0.0635    0.0635;
    0.0476    0.0476    0.0476;
    0.0317    0.0317    0.0317;
    0.0159    0.0159    0.0159;
         0         0         0 ];
     
%Terrain Color Map 'terrain'
uTerrainColorMap =...
[
    0.6784    0.9216    1.0000;
    0.0105    0.4187    0.2019;
    0.0219    0.4375    0.2037;
    0.0342    0.4563    0.2057;
    0.0475    0.4750    0.2078;
    0.0617    0.4938    0.2102;
    0.0769    0.5125    0.2130;
    0.0930    0.5313    0.2162;
    0.1100    0.5500    0.2200;
    0.1280    0.5688    0.2244;
    0.1469    0.5875    0.2295;
    0.1667    0.6062    0.2354;
    0.1875    0.6250    0.2422;
    0.2092    0.6438    0.2500;
    0.2319    0.6625    0.2588;
    0.2555    0.6812    0.2688;
    0.2800    0.7000    0.2800;
    0.3184    0.7188    0.3055;
    0.3572    0.7375    0.3319;
    0.3964    0.7563    0.3592;
    0.4359    0.7750    0.3875;
    0.4756    0.7937    0.4167;
    0.5154    0.8125    0.4469;
    0.5552    0.8313    0.4780;
    0.5950    0.8500    0.5100;
    0.6346    0.8687    0.5430;
    0.6739    0.8875    0.5769;
    0.7130    0.9063    0.6117;
    0.7516    0.9250    0.6475;
    0.7897    0.9438    0.6842;
    0.8271    0.9625    0.7219;
    0.8640    0.9812    0.7605;
    0.9000    1.0000    0.8000;
    0.8777    0.9806    0.7592;
    0.8573    0.9613    0.7194;
    0.8387    0.9419    0.6806;
    0.8218    0.9226    0.6428;
    0.8066    0.9032    0.6060;
    0.7928    0.8839    0.5702;
    0.7805    0.8645    0.5354;
    0.7694    0.8452    0.5016;
    0.7596    0.8258    0.4688;
    0.7508    0.8065    0.4370;
    0.7431    0.7871    0.4062;
    0.7362    0.7677    0.3764;
    0.7301    0.7484    0.3476;
    0.7246    0.7290    0.3198;
    0.7097    0.6996    0.2930;
    0.6903    0.6653    0.2672;
    0.6710    0.6306    0.2424;
    0.6516    0.5957    0.2186;
    0.6323    0.5607    0.1958;
    0.6129    0.5256    0.1740;
    0.5935    0.4906    0.1532;
    0.5742    0.4557    0.1334;
    0.5548    0.4211    0.1145;
    0.5355    0.3869    0.0967;
    0.5161    0.3531    0.0799;
    0.4968    0.3200    0.0641;
    0.4774    0.2875    0.0493;
    0.4581    0.2559    0.0355;
    0.4387    0.2251    0.0226;
    0.4194    0.1953    0.0108;
    0.4000    0.1667         0 ];

%PLOTTING THE FILLED CONTOURNS
hold on
axis( sphereRadius *[-1 ,1 ,-1 ,1], 'equal', 'off' );
%Specifiyng the filled contourn type
switch filledCountType
    case '2Dfilled'
        contourf( destineXMat ,destineYMat ,finalDestineZmat, v );
    case '3Dmesh'
        meshz( destineXMat ,destineYMat ,finalDestineZmat );
    otherwise
        error('Bad filled-contourn-graph type defined');
end
%Other colormaps 'jet' 'gray' 'cool' 'hot'
switch colorMap
    case 'grayi'
        colormap(uGrayColorMap);
    case 'terrain'
        colormap(uTerrainColorMap);
    otherwise
        colormap(colorMap);
end

end

