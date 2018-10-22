## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{str} =} createfilename (@var{trdplgArray}, @var{fileStr})

## Create a file name from the values of a direction given by a trend and plunge
## pais or dip-direction and dip pairs.

## Input(s):
## Array of 1 x 2 with the trend and plunge values (trdplgArray).
## String with the name of the file that will prrcede the numerical code, 
## by default is 'file_' (fileStr).
## String with the name of the extension of the file (with the point included)
## by default is '.mat' (extStr).

## Output(s):
## String with the complete conformed file name (str).

## Example 1:
## Create a file name that correspond to data of an oriented data with values of
## trend = 67.896 and plunge = 13.7. The file name should begins with a string 
## of 'project1_' and its extension should be '.txt'. Then, you write:
##     createfilename ([67.897, 13.7], 'project1_', '.txt')
## The output string is 'project1_067-9_13-7.txt'.

## @seealso{num2stringgeol}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-20

function str = createfilename (trdplgArray, fileStr, extStr)

if nargin < 2
    fileStr = 'file_';
    extStr = '.mat';
elseif nargin < 3
    extStr = '.mat';
endif

decPointStr = '-';
trdStr = num2stringgeol (trdplgArray(1), 3, 1, decPointStr);
plgStr = num2stringgeol (trdplgArray(2), 2, 1, decPointStr);
str = [fileStr, trdStr, '_', plgStr, extStr];

endfunction