function [s_cap,n_regions] = eq_caps(dim ,N)
%EQ_CAPS Partition a sphere into to nested spherical caps
%
%Syntax
% [s_cap,n_regions] = eq_caps(dim,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % Given dim and N, determine c_polar,
    % the colatitude of the North polar spherical cap.
    %
    c_polar = polar_colat(dim,N);
    %
    % Given dim and N, determine the ideal angle for spherical collars.
    % Based on N, this ideal angle, and c_polar,
    % determine n_collars, the number of collars between the polar caps.
    %
    n_collars = num_collars(N,c_polar,ideal_collar_angle(dim,N));
    %
    % Given dim, N, c_polar and n_collars, determine r_regions,
    % a list of the ideal real number of regions in each collar,
    % plus the polar caps.
    % The number of elements is n_collars+2.
    % r_regions[1] is 1.
    % r_regions[n_collars+2] is 1.
    % The sum of r_regions is N.
    %
    r_regions = ideal_region_list(dim,N,c_polar,n_collars);
    %
    % Given N and r_regions, determine n_regions,
    % a list of the natural number of regions in each collar and
    % the polar caps.
    % This list is as close as possible to r_regions.
    % The number of elements is n_collars+2.
    % n_regions[1] is 1.
    % n_regions[n_collars+2] is 1.
    % The sum of n_regions is N.
    %
    n_regions = round_to_naturals(N,r_regions);
    %
    % Given dim, N, c_polar and n_regions, determine s_cap,
    % an increasing list of colatitudes of spherical caps which enclose the same area
    % as that given by the cumulative sum of regions.
    % The number of elements is n_collars+2.
    % s_cap[1] is c_polar.
    % s_cap[n_collars+1] is Pi-c_polar.
    % s_cap[n_collars+2] is Pi.
    %
    s_cap = cap_colats(dim,N,c_polar,n_regions);
    %

end

