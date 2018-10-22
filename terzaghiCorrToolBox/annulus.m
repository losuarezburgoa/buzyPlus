function [P, majCircSTR, minCircSTR] = annulus (r, R, Ccent, ccent, ...
    numSegs, color, varargin)
    
% Creates a annulus patch object and returns the handle.  Input arguments 
% are the inner radius, outer radius, inner x offset, outer x offset, inner
% y offset and outer Y offset.  Changes to the edgecolor and linestyle are
% allowed, and will preserve the correct look of the annulus

## Example 1
## annulus (1/2, 1, [0, 0], [0.2, 0.2], 180, 'red');
##
## Example 2
## annulus (1/2, 1, [0, 0], [0.2, 0.2], 180, 'red', 'EdgeColor','none');
##
## Example 3
## Figure()
## hold on
## [P, A, a] = annulus (1/2, 1, [0, 0], [0.2, 0.2], 180, rand(1,3), 'EdgeColor','none');
## plot(A.x, A.y, 'k-');
## plot(a.x, a.y, 'k-');
## axis equal
## axis off
##

## Input management.
if nargin < 2
  R = r;
  Ccent = zeros(1,2);
  ccent = zeros(1,2);
  numSegs = 180;
  color = 'k';
elseif nargin < 3
  Ccent = zeros(1,2);
  ccent = Ccent;
  numSegs = 180;
  color = 'k';
elseif nargin < 4
  ccent = Ccent;
  numSegs = 180;
  color = 'k';
elseif nargin < 5
  numSegs = 180;
  color = 'k';
elseif nargin < 6
  color = 'k';
endif

## The center of the annulus.
## Major circle center.
Xf = Ccent(1);
Yf = Ccent(2);
## Minor circle center.
xf = ccent(1);
yf = ccent(2);

## Creating the ring coordiantes.
t = linspace(0, 2 * pi, numSegs);
x = xf + r * cos(t);
y = yf + r * sin(t);
X = Xf + R * cos(t);
Y = Yf + R * sin(t);

## Cordinates.
majCircSTR = struct('r', R, 'center', Ccent, 'x', X, 'y', Y);
minCircSTR = struct('r', r, 'center', ccent, 'x', x, 'y', y);

## Creating the patch handle 'P'.
hold on
P = patch([x, X], [y, Y], color, varargin{:});

endfunction
