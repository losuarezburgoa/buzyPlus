## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## -*- texinfo -*- 
## @deftypefn {} {@var{acuteAngRad}, @var{obtuseAngRad} =} acuteobtuseangbtwen2dirs (@var{uVec1}, @var{uVec2})

## Two directions given by two unit vectors, if they are concurrent at orign
## they form an acute and an obtuse angle. 
## This function calculates the acute and the obtuse angles of two unit vectors.

## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-21

function [acuteAngRad, obtuseAngRad] = acuteobtuseangsbtwen2dirs (uVec1, uVec2)

acuteAngRad = mod(acos(dot(uVec1, uVec2)), pi);
obtuseAngRad = mod(acos(dot(-uVec1, uVec2)), pi);

if acuteAngRad > obtuseAngRad
    b = acuteAngRad;
    acuteAngRad = obtuseAngRad;
    obtuseAngRad = b;
endif

endfunction
