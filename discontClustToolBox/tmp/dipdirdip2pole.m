function [trendPlungeArray] = dipdirdip2pole (dipDirDipArray)

## -*- texinfo -*- 
## @deftypefn {} {@var{trendPlungeArray} =} dipdirdip2pole 
##    (@var{dipDirDipArray})
##
## Description:
## Transforms the information of a geological plane given by the dip-direction
## and dip row-vector (@var{dipDirDipArray}) to their correspondent pole
## vector (@var{trendPlungeArray}) proyected to the southern hemisfere.
##
## Input(s):
## THe (dip-direction \ dip) row-vector of the plane given in degrees, 
## @var{dDirDipVec}.
##
## Output(s):
## The (trend \ plunge pole) row-vector of the line normal to the plane in
## degrees, @var{poleVec}.
##
## Example 1:
## The corresponding dip-direction dip vector @code{[350, 12]} is in polar 
## vector equal to @code{[170, 78]}.
##
## @seealso{trendplunge2unitvect}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa qemail{losuarezb@unal.edu.co}
## Created: 2018-10-25

numData = size (dipDirDipArray, 1);
trendPlungeArray = zeros (numData, 2);
for i = 1 : numData
    trendPlungeArray(i, :) = ddd2p (dipDirDipArray(i, :)); 
endfor
endfunction

## Function that performs the transformation per se.
function [poleVec] = ddd2p (dDirDipVec)

## Distributing the array in each component.
dipDirection = dDirDipVec(1);
dip = dDirDipVec(2);

## Plunge of the pole.
polePlunge = 90 - dip;

## Trend of the pole.
dDirr = dipDirection + 180;
    if dDirr > 360
        poleTrend = dDirr - floor(dDirr / 360) * 360;
    else
        poleTrend = dDirr;
    endif
poleVec = [poleTrend, polePlunge];
endfunction

## Copyright (C) 2013, 2018 Ludger O. Suarez-Burgoa & Universidad Nacional de Colombia.
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