## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} genequalanglecountnet1 (@var{input1}, @var{input2})

#
# Description:
# Create an array of pair-values of trend and plunge that represetns the axis of
# a cone to the sphere, that in spherical projection is a equal-size circle
# that moves a constant angle in trend and plunge in the southern hemisphere.
#
# Nested function(s):
# generate_equalangle_trendplunge_mat
#
# Input(s):
# Area of the counting circle expressed in percentaje of the total projeted
# area (countingCircleAreaInPercent).
#
# Boolena valu if a plot is wanted to show.
# String of the type of projection is wantred to be used for the plot: could be
# equalangle or equalarea.
#
# Output(s):
# Array having the trend-plunge values of the orientation of the cone-axis
# (coneAxisTrendPlungeArray).
#
# Recalculated area value of the cluster window in percentaje of the total
# projected area (evalCountCircAreaInPercent).
#
# Example1:
# Using circle areas of 2 % the maximum great circle area, create the array
# of all circles in the lower hemisphere.
# [coneAxisTrendPlungeArray evalCountCircAreaInPercent] = evalaxesonsouthhemisphere(2, true, 'equalangle');
#
# Nested function(s):
# planepolar2equalareapolar, generate_equalangle_trendplunge_mat, 
# plotplaneorientationdata

##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-23

function [coneAxisTrendPlungeArray, evalCountCircAreaInPercent, ...
  coneSemiAngleGrad] = genequalanglecountnet1 ...
  (countingCircleAreaInPercent, wantplot, projectionType)

  ## Input management.
if nargin < 1
    countingCircleAreaInPercent = 2;
    wantplot = false;
    projectionType = 'equalangle';
elseif nargin < 2
    wantplot = false;
    projectionType = 'equalangle';
elseif nargin < 3
    projectionType = 'equalangle';
endif

# Maximum great circle radius, i.e. radius of the reference sphere
greatCircleRadius = 1;
# Area of the maximum great-circle (globalGcArea)
globalGcArea = pi * greatCircleRadius^2;

# Area and radius of the equal-area counting circle (countingEaCircleArea,
# countinigEaCircleRadius)
countingEaCircleArea = countingCircleAreaInPercent / 100 * globalGcArea;
countingEaCircleRadius = sqrt(countingEaCircleArea / pi);

# Obtaining the cone semiangle for the equal-area counting circle
# (countingConeSemiangleGrad)
tpv = planepolar2equalareapolar(0, countingEaCircleRadius);
resultOfBetaGrad = tpv(2);
countingConeSemiangleGrad = 90 - resultOfBetaGrad;

%Interations using the 'fsolve' function
% r =countingEaCircleRadius;
% R =greatCircleRadius;
% seed =45 *pi /180;
% resultOfBetaRad =fsolve(@(beta) r*(1 +sqrt(2) +sin(beta))-R*(1+sqrt(2))*cos(beta) ,seed);
% countingConeSemiangleGrad =90 -resultOfBetaRad *180 /pi;

# Reevaluating the counting circle area and the percentage value
# (evalCountCircAreaInPercent) 
angleDivisions = floor(90 / countingConeSemiangleGrad);
coneSemiAngleGrad = 90 / angleDivisions;

evaluatedBetaAngRad = pi / 2 - coneSemiAngleGrad *pi / 180;
evaluatedEaCircleRadius = greatCircleRadius * (1 + sqrt(2)) * cos(evaluatedBetaAngRad) / (1 + sqrt(2) + sin(evaluatedBetaAngRad));
    
evaluatedCountingEaCircleArea = pi * evaluatedEaCircleRadius .^2;
evalCountCircAreaInPercent = evaluatedCountingEaCircleArea / globalGcArea * 100;

## CALCULATING THE AVERAGE MATRIX
# To perform the moving average, the axis will move every half of the
# coneSemiAngleGrad
numberTrendDivisions = (4 * angleDivisions + 1) * 2 - 1;
numberPlungeDivisions = (angleDivisions + 1) * 2 - 1;

coneAxisTrendPlungeArray = generate_equalangle_trendplunge_mat(numberTrendDivisions, numberPlungeDivisions);
if wantplot
    hold on
    plotplaneorientationdata(coneAxisTrendPlungeArray, projectionType, 'x', false, 4, 'w', 'k');
endif

endfunction
