## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} createisogoniocfield (@var{input1}, @var{input2})
##
## Output(s)
## A a structure 'terzaguiPlotSTR' with the following fields:
##    .lineOrient: orientation of the borehole.
##    .x, grid with x coordiantes and
##    .y, grid with y coordiantes, both in the cartesian coordiante system;
##    .z, grid with z coordiantes that represent the sin(\alpha);
##    .proj, string of the projection used for the calculation;
##    .alphaThres, alpha threshold (see Terzaghy article for this value);
##    .intervalVec, vector with the gross and fine angle inteval widths.
## This function makes two main calculi.

## Example 1:
## terzaguiPlotSTR = createisogoniocfield ([156, 23]);

## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-20

function terzaguiPlotSTR = createisogoniocfield (bhTPVec, projType, ...
    alphaTheshold, intvalAngDegVec, wantplot, colormapStr)

## Input management.
if nargin < 2
    projType = 'equalarea';
    alphaTheshold = 0;
    intvalAngDegVec = [2, 0.1]; 
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 3
    alphaTheshold = 0;
    intvalAngDegVec = [2, 0.1];
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 4
    intvalAngDegVec = [2, 0.1];
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 5
    wantplot = false;
    colormapStr = 'jet';
elseif nargin < 6
    colormapStr = 'jet';
endif

## Warning about the cubersome process of calculation of this function.
explanation = 'This function consumes some tens of minutes to process. ';
prompt = 'Do you want to continue?';

# In the console.
%str = input([explanation, prompt, 'Y/N [Y]: '],'s');
%if isempty(str)
%    str = 'Y';
%    %display('Please, be patient!');
%    tic
%elseif strcmp(upper(str), 'N')
%    if nargout > 0
%        %display ('The function was cancelled!');
%        terzaguiPlotSTR = NaN;
%    end
%    break
%endif

# In a GUI
answer = questdlg ([explanation, prompt], 'Warning!', 'Yes', 'No', 'No');
switch answer
    case 'Yes'
        % pass
    case 'No'
        if nargout > 0
        terzaguiPlotSTR = NaN;
        end
        break;
endswitch

tStart = tic;

## Input data.
bhTrendPlungeVec = dipdirdip2pole ([bhTPVec(1) + 270, bhTPVec(2)]);
trendRotAngleRad = nepolar2polar (bhTrendPlungeVec(1) * pi / 180);
plungeRotAngleDeg = nepolar2polar ((90 - bhTrendPlungeVec(2)) * pi / 180) * 180 / pi;

angleIntervalDeg = intvalAngDegVec(1);
fineAngleIntervalDeg = intvalAngDegVec(2);

## Create the isogonic field for a vertical orientation.
# The alpha angle varing from 0 to 90.
trendDeg = [0 : angleIntervalDeg : 360];
plungeDeg = [0: angleIntervalDeg : 90];

ncols = length(trendDeg);
nrows = length(plungeDeg);


[trndDeg, plgeDeg] = meshgrid (trendDeg, plungeDeg);

## Rotate two times.
rotTrndDeg = zeros(nrows, ncols);
rotPlgeDeg = zeros(nrows, ncols);

perc = 0; step = 1;
max = ncols * nrows;
p1 = waitbar(0);

for j = 1 : nrows
    for k = 1 : ncols
        # Rotating.
        rot2TrendPlungeVec = rot_orient_arnd_northernstrike ...
            ([trndDeg(j, k), plgeDeg(j, k)], - plungeRotAngleDeg);
        rotTrndDeg(j, k) = rot2TrendPlungeVec(1);
        rotPlgeDeg(j, k) = rot2TrendPlungeVec(2);
        # Process dialog for rotating.
        perc = perc + 1;
        p1 = waitbar(perc*step/max, p1, ...
            sprintf('Process 1 of 3: Rotating %d of %d (%.1f %%).', [perc, max, perc*step/max*100]));
    endfor
endfor
close (p1);

## Changing the thresholdd after creating the alphaDeg array.
alphaDeg = plgeDeg;
alphaDeg(alphaDeg <= alphaTheshold) = 0;
sinAlpha = sin(alphaDeg * pi / 180);

# Using Buzy plus functions to obtain the rho distance in spherical projection.
thetaProjRad = zeros(nrows, ncols);
rhoProjDist = zeros(nrows, ncols);

perc = 0; step = 1;
max = ncols * nrows;
p2 = waitbar(0);

for j = 1 : nrows
    for k = 1 : ncols
        switch projType
            case 'equalangle'
            planePolarArrayEq = equalanglepolar2planepolar ...
                ([rotTrndDeg(j, k), rotPlgeDeg(j, k)]);
            case 'equalarea'
            planePolarArrayEq = equalareapolar2planepolar ...
                ([rotTrndDeg(j, k), rotPlgeDeg(j, k)]);
            otherwise
            error('Bad projection type!');
        endswitch
      thetaProjRad(j, k) = planePolarArrayEq(1);
      rhoProjDist(j, k) = planePolarArrayEq(2);
      # Process dialog for rotating.
      perc = perc + 1;
      p2 = waitbar(perc*step/max, p2, ...
          sprintf('Process 2 of 3: Projecting %d of %d (%.1f %%).', [perc, max, perc*step/max*100]));
    endfor
endfor
close (p2);

## Rotate to the corresponding trend
[xk, yk] = pol2cart (thetaProjRad + trendRotAngleRad, rhoProjDist);
zk = sinAlpha;


## Creating a more dense grid in order to interpolate the x, y, z results.
tic
measuredTimeSec = [98.4, 103.5];
p3 = waitbar(0, 'Process 3 of 3: Refinning the grid, just wait!');

newTrendRad = [0 : fineAngleIntervalDeg : 360] * pi / 180;
newPlungeRad = [0: fineAngleIntervalDeg : 90] * pi / 180;
[th, r] = meshgrid (newTrendRad, newPlungeRad);
[x, y] = pol2cart (th, r);

p3 = waitbar(1, p3, 'Process 3 of 3: Refinning the grid, just wait!');  
z = griddata (xk, yk, zk, x, y);
close (p3);

## Create a data structure of the main data.
# In order to plot further without runing this script.
terzaguiPlotSTR = struct('lineOrient', bhTPVec, 'x', x, 'y', y, 'z', z, ...
    'proj', projType, 'alphaThres', alphaTheshold, 'intervalVec', intvalAngDegVec);
    
## Plotting the results.
if wantplot
    plotisogonicfield (terzaguiPlotSTR, colormapStr, 2);
endif
    
tEnd = toc(tStart);
a = sprintf('Processing time was %d minutes and %.0f seconds.', ...
    floor(tEnd/60), rem(tEnd,60));
display(a);
endfunction
