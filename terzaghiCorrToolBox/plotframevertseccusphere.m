## Copyright (C) 2018 Ludger O. Suarez-Burgoa
## 

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} plotframevertseccusphere (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-18

function [ ] = plotframevertseccusphere (wantplotpatch, patchColor)
    
if nargin < 1
    wantplotpatch = false;
    patchColor = 'c';
elseif nargin < 2
    patchColor = 'c';
endif

hold on
# The lower hemisphere patch
if wantplotpatch
    h = arcpatch (0, 0, 1, rad2deg([pi, 2*pi]));
    set(h, 'facecolor', 'c', 'edgecolor', patchColor);
endif
    
# The unit circle.
numDivCirc = 90;
[xcc, ycc] = pol2cart (linspace(0, 2*pi, numDivCirc), ones(1, numDivCirc));
plot (xcc, ycc, 'k-');

# The horizontal line.
plot([-1, 1], zeros(1,2), 'k-');
# The center of the circle.
plot(0, 0, 'kx');
# Other final corrections.
axis equal
axis off
    
endfunction
