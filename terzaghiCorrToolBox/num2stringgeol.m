## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{yStr} =} num2stringgeol (@var{x}, @var{ntens}, @var{decimalSign})

## Convert a number to a string for geology numbers.

## A number is transformed into a string, but the integer part is filled with
## zeros at the left part if the integer part is less than 10^(ntens).
## This is useful for geologic measures of trend and plunge. By norm, the trend
## values should be specied in tree digits (i.e. 10^3) and the plunge in 
## two digits (i.e. 10^2).
## The numbers after the decimal is controlled also with the variable (mtens).

## Example 1 (trend cases):
## The number 34.523 in transformed to '034.5' with num2stringgeol(34.523, 3, 1)
## The number 4.63 in transformed to '004.63' with num2stringgeol(4.63, 3, 2)

## Example 2 (plunge cases):
## The number 34.523 in transformed to '34.5' with num2stringgeol(34.523, 2, 1)
## The number 4.63 in transformed to '04.63' with num2stringgeol(4.63, 2, 2)

## @seealso{createfilename}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-20

function [yStr] = num2stringgeol (x, ntens, mtens, decimalSign)

if nargin < 3
    mtens = 1;
    decimalSign = '.';
elseif nargin < 4
    decimalSign = '.';
endif

## Avoiding the numbers over the hundreds.
x = rem (x, 10^ntens);

## The integer part and the remainder.
xIntPart = fix(x);
xRemPart = x - xIntPart;

## Converting the integer part to string and complete to hundreds with zeros.
xIntStr = num2str (xIntPart);
nx = length (xIntStr);
preStr = '';
for k = 1 : ntens-nx
    preStr = [preStr, '0'];
endfor

## It will catch only one decimal of the number.
nPstx = num2str (round (xRemPart * 10^mtens));
postStr = nPstx(mtens);

## Ensambling the string number
yStr = [preStr, xIntStr, decimalSign, postStr];

endfunction
