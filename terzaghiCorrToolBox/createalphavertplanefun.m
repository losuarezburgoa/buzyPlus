## Copyright (C) 2018 Ludger O. Suarez-Burgoa

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} createalphavetplanefun (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Ludger O. Suarez-Burgoa <ludger@ludger-Inspiron-3458>
## Created: 2018-07-19

## Create the isogonic plot for a vertical orientation.

function [plgAlphaArray] = createalphavertplanefun (bhPlg, refAngDeg, ...
    wantplot)

if nargin < 2
    refAngDeg = 8;
    wantplot = false;
elseif nargin < 3
    wantplot = false;
endif

# Where (at what plunge) do you want the blind line?
bhCplg = -mod (bhPlg, 90);

## The alpha angle varing from -90 to 90.
angleIntervalDeg = 1;
fa = angleIntervalDeg;
angleArrayDeg = [-90 + bhCplg : angleIntervalDeg : 90 + bhCplg];

sinAlpha = @(alpha) abs(sin((alpha + bhCplg) * pi / 180));
plgAlphaArray = [angleArrayDeg; sinAlpha(angleArrayDeg)]';

ta = plgAlphaArray(:,1)';
sa = plgAlphaArray(:,2)';

idx1 = find (ta > 90);
idx2 = find (and (ta >= -90, ta <= 90));
idx3 = find (ta <- 90);

nta = [fliplr(-mod(ta(idx1), -90)), ta(idx2), mod(ta(idx3), 90)];
nsa = [fliplr(sa(idx1)), sa(idx2), sa(idx3)];

nplgAlphaArray = [nta', nsa'];
snplgAlphaArray = sortrows (nplgAlphaArray);
snplgAlphaArray = [snplgAlphaArray; ...
                   [-snplgAlphaArray(1,1), snplgAlphaArray(1,2)]];

## Changing names only, x is the plunge valur, and y is the 'sin(alpha)' value.
x = snplgAlphaArray(:,1);
y = snplgAlphaArray(:,2);

# The blind zone.
# Upon Terzaghi, the blind zone is considered for values of sin(alpha) < sin(14). 
ybl = y;
idxY = find (y < sin(refAngDeg * pi / 180));
ybl(idxY) = sin(refAngDeg * pi / 180);

plgAlphaArray = [x, ybl];

## Ploting.
if wantplot
    hold on
    # The curve.
    %plot (x, y, 'k-', 'LineWidth', 2);
    # The curve with the blindzone.
    plot (x, ybl, 'b-', 'LineWidth', 1);
    # The legend.
    lgndStr2 = sprintf ('With blind threshold of %d °.', refAngDeg);
    legend ('Without blind threshold', lgndStr2);
    legend ('boxoff');
    # Managing scales and axes.
    xlabel ('\alpha [°].');
    ylabel ('sin{(\alpha)} [1].');
    set (gca, 'xtick', [-90 : 15 : 90]); 
    set (gca, 'ytick', [0 : 0.2 : 1]);
    set (gca,'TickDir','out');
    xlim ([-90 , 90]);
    ylim ([0, 1]);
endif

endfunction
