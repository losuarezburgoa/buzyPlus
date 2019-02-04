function [reducedAngleDeg] = reduceminimal90angle (angleDeg)

## -*- texinfo -*- 
## @deftypefn {} {@var{reducedAngleDeg} =} reduceminimal90angle 
##    (@var{angleDeg})
##
## Description:
## Reduces an angle that has a magnitude greater to 180 to an equivalent
## angle expressed between 0 to 90. Usefull for pitch angles.
##
## Input(s):
## Angle or angle vector in hexagesimal angular degrees, @code{angleDeg}.
##
## Output(s):
## Reduced angle in hexagesimal angular degrees, @code{reduceAngleGrad}.
## 
## @example
## Example1:
## With @code{angleDeg = [0, 90, 105, 230]}, one returns a data of 
## @result{[0, 90, 15, 50]}.
## @end example
##
## @example
## Other examples
## @code{reduceminimal90angle ([0 90 180 230 260 300 350])}
## @code{reduceminimal90angle (-[0 90 180 230 260 300 350])}
## @code{reduceminimal90angle (240)}
## @code{reduceminimal90angle (-160)}
## @endexample
##
## @seealso{reduceminimal360angle}
## @end deftypefn

reducedAngleDeg = angleDeg;
for i = 1 : length (angleDeg)
    if angleDeg(i) > 90
        reducedAngleDeg(i) = angleDeg(i) - floor(angleDeg(i) / 90) * 90;
    else
        if angleDeg(i) <- 90
           reducedAngleDeg(i) = angleDeg(i) - ceil(angleDeg(i) / 90) * 90; 
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