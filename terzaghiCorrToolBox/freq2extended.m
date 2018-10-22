## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{extendedTrdPlgFreqArray} =} freq2extended 
##    (@var{trendPlungeFreqArray})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludgerWork>
## Created: 2018-07-06

## Given a trend and plunge array, in the first two columns (i.e. in the first 
## column the trend and in the second column the plunge) and the frequecies in
## the third column; this function creates a two column trend and  plunge array
## where the data is repeated 'f' times the frequency given in the third column.

## Example1:
## freq2extended ([350, 34, 2; 089, 13, 5]);
##
## Example2:
## tpFreqArray = [256 23 3; 125 12 2; 345 56 1];
## exdedTPfreqArray = freq2extended (tpFreqArray);
## gives the following array
##   256    23
##   256    23
##   256    23
##   125    12
##   125    12
##   345    56
##

function [extendedTrdPlgFreqArray] = freq2extended (trendPlungeFreqArray)

extendedTrend = repelems ( ...
    trendPlungeFreqArray(:,1), ...
    [1:1:size(trendPlungeFreqArray,1); transpose(trendPlungeFreqArray(:,3))]);

extendedPlunge = repelems ( ...
    trendPlungeFreqArray(:,2), ...
    [1:1:size(trendPlungeFreqArray,1); transpose(trendPlungeFreqArray(:,3))]);

extendedTrdPlgFreqArray = [extendedTrend', extendedPlunge'];
    
endfunction
