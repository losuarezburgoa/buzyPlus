function [P2, D2] = sortem (P, D)
## -*- texinfo -*- 
## @deftypefn {} {@var{P2} @var{D2} =} sortem (@var{P}, @var{D})
##
## This function takes two matrices: @var{P} (the eigen vector orthonormal matrix) 
## and @var{D} (the eigen value diagonal matrix), both obtained from the output 
## of the @ff{eig} function, and then sorts the columns of @var{P} to 
## match the sorted columns of @var{D} going from largest to smallest eigen values.
##
## @seealso{eig}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa @email{losuarezb@unal.edu.co}.
## Created: 2018-05-30.

## Make diagonal matrix out of sorted diagonal values of input D
D2 = diag (sort (diag(D), 'descend')); 

## Store the indices of which columns the sorted eigenvalues come from
[c, ind] = sort (diag(D), 'descend'); 

## Arrange the columns in this order.
P2 = P(:, ind);
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