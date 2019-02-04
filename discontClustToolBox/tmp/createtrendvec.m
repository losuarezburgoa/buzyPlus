function [equalTrendPrinVec, equalTrendSecondVec] = createtrendvec ...
    (prinTrendStepsDeg)

## -*- texinfo -*- 
## @deftypefn {} {@var{equalTrendPrinVec}, @var{equalTrendSecondVec} =} 
## createtrendvec (@var{prinTrendStepsDeg})
##
## Description:
## Creates a vector of values of the principal and secondary scales in order
## to plot grids or scales.
##
## Input(s):
## Primary scale steps of the trend, in sexagesimal degrees. The generation
## of points is independent of the spherical projection type
## (@var{prinTrendStepsDeg}). 
##
## Note: Secondary scale steps will be ever one fifth of the principal scale
## step. 
##
## Output(s):
## The trend grid vector of principal scale (@var{equalTrendPrinVec}) having 
## points values to plot the radial lines of equal trend value. 
##
## The trend grid matrix of secondary scale (@var{equalTrendSecondVec}).
##
## @example
## Example:
## In orde to have a vector to generate a trend scale of 10 degrees
## interval; it est, 18 positions ...
## [equalTrendPrinVec, equalTrendSecondVec] = createtrendvec (10);
## @end example
##
## @seealso{equalareapolar2planepolar}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa @email{losuarezb@unal.edu.co}
## Created: 2018-10-25

## Input management.
if nargin < 1
   prinTrendStepsDeg = 10;
endif

## General parameters.
# internal graphic control parameters
trendStepsGrad = prinTrendStepsDeg / 5;
# number of secondary points
trendNumPoints = floor (360 / trendStepsGrad) + 1;

# creating the trend-series and the plunge-series vectors
trendGrad = linspace (0, 360, trendNumPoints);

## Equal-trend vector.
# creating the complete equal-trend matrix (equalTrendMatC)
equalTrendMatC = zeros(1, 2 * length(trendGrad));
# filling the complete equal-trend matrix
for i = 1 : length(trendGrad)
% [equalTrendMatC(1, 2*i-1), equalTrendMatC(1, 2*i)] = ...
    eqTrgMat = equalareapolar2planepolar ([trendGrad(i), 0]);
    equalTrendMatC(1, 2 * i - 1) = eqTrgMat(1);
    equalTrendMatC(1, 2 * i) = eqTrgMat(2);
endfor
sizeETMatC = size(equalTrendMatC);

# extracting the Primary Scale of radial lines of equal-trend.
indexTp = 1 : 10 : sizeETMatC(2);
equalTrendPrinMat = zeros (sizeETMatC(1), length(indexTp) * 2);
for i = 1 : length(indexTp)
    equalTrendPrinMat(:, 2 * i - 1 : 2 * i) = equalTrendMatC(:, ...
        indexTp(i):indexTp(i) + 1);
endfor

## Extracting the Secondary-Scale of radial lines of equal-trend.
indexTs = zeros(1, (length(indexTp) - 1) * 8);
for i = 1 : length(indexTp) - 1
    indexTs(8 * (i - 1) + 1 : 8 * i) = indexTp(i) + 2 : 1 : indexTp(i + 1) - 1;
endfor

equalTrendSecondMat = zeros(sizeETMatC(1), length(indexTs));
for i = 1 : length(indexTs)
    equalTrendSecondMat(:, i) = equalTrendMatC(:, indexTs(i));
endfor

## Final output variables.
equalTrendSecondVec = equalTrendSecondMat;
equalTrendPrinVec = equalTrendPrinMat;

endfunction

## Copyright (C) 2018 Ludger O. Suarez-Burgoa & Universidad Nacional de Colombia.
## 
## This program is free software; redistribution and use in source and
## binary forms, with or without modification, are permitted provided that
## the following conditions are met:
## 
##    1.Redistributions of source code must retain the above copyright
##      notice, this list of conditions and the following disclaimer.
##    2.Redistributions in binary form must reproduce the above copyright
##      notice, this list of conditions and the following disclaimer in the
##      documentation and/or other materials provided with the distribution.
## 
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
## ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
## FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
## DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
## OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
## LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
## OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
## SUCH DAMAGE.