function [unitVectorArray] = trendplunge2unitvect (trendPlungeDegArray)

## -*- texinfo -*- 
## @deftypefn {} {@var{unitVectorArray} =} trendplunge2unitvect 
##    (@var{trendPlungeDegArray})
##
## Description:
## Transforms trend/plunge orientation angles expressed in hexagesimal
## degrees to an unitary vector expressed in the NED coordinate system.
## Here NED is a North, East and Depth coordinate system.
##
## Note(s):
## If the line plunges upwards the horizontal plane, specify a negative
## value. If the line plunges downwards the horizontal plane, specify a
## positive value.
## Plunge varies from -90 to 90 and trend varies from 0 to 360.
## If any of those values are specified outside this range, the program will
## convert properly.
## All vertical plunge has a zero trend by convention.
## 
## Input(s):
## The trend and plunge (1 x 2) array (@var{trendPlungeDegArray}), where values
## are given in sexagesinmal degrees.
##
## Output(s):
## Unit row vector of (1 x 3) which represents the line direcction in the NED
## coordinate, @var{unitVectorArray}.
##
## @example
## Example:
## @code{tpArray = [235 ,12]}
## A line direction expressed with their trend and plunge of 235 and 12
## degrees, respectively has an unit vector of 
## @result{[ -0.5610, -0.8013, 0.2079 ]}.
## @end example
##
## @seealso{reduceminimal360angle, reduceminimal90angle}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa qemail{losuarezb@unal.edu.co}
## Created: 2018-10-25

## In case the input data is an array.
numData = size (trendPlungeDegArray, 1);
unitVectorArray = zeros (numData, 3);
for i = 1 : numData
    unitVectorArray(i,:) = tp2uvec (trendPlungeDegArray(i,:));
endfor

endfunction

## Function that performs the transformation per se.
function [uVec] = tp2uvec (tpArray)
    
## Distributing the array in each component.
trendDeg = tpArray(1);
plungeDeg = tpArray(2);

## Guaratiying 360 or 90 circular numbers.
trendRad = (pi / 180) * reduceminimal360angle (trendDeg);
plungeRad = (pi / 180) * reduceminimal90angle (plungeDeg);

## Unit vector elements from the angles.
orientVector = [ ...
    cos(trendRad) * cos(plungeRad); ...
    sin(trendRad) * cos(plungeRad); ...
    sin(plungeRad)];

## Converting to unit vector.
uVec = orientVector / norm(orientVector);
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