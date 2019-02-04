function [reducedAngleDeg] = reduceminimal360angle (angleDeg)
    
## -*- texinfo -*- 
## @deftypefn {} {@var{reducedAngleDeg} =} reduceminimal360angle 
##    (@var{angleDeg})
##
## Description:
## Reduces an angle that has a magnitude greater to 360, to an equivalent
## angle expressed between 0 to 360.
##
## Input(s):
## Angle or angle vector in hexagesimal agular degrees (angleDeg).
##
## Output(s):
## Reduced angle in hexagesimal angular degrees (reduceAngleGrad).
##
## @example
## Example:
## @code{angleDeg = [0, 360, 400, 540, 850];}
## Using this function one returns a reduced data of @code{[0, 360, 40, 180, 130]}.
## @end example
##
## @seealso{reduceminimal90angle}
## @end deftypefn

reducedAngleDeg = angleDeg;
for i = 1 :length( angleDeg )
    if angleDeg(i) > 360
        reducedAngleDeg(i) = angleDeg(i) - floor(angleDeg(i) / 360) * 360;
    else
        if angleDeg(i) <- 360
           reducedAngleDeg(i) = angleDeg(i) - ceil(angleDeg(i) / 360) * 360; 
        endif
    endif
endfor

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