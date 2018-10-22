function points_s = eq_point_set_polar(N)
%EQ_POINT_SET_POLAR Center points of regions of an EQ partition
%

extra_offset =false;  %added by lsb 
dim =2; %added by lsb

if N == 1
    % We have only one region, which must be the whole sphere.
    points_s = zeros(dim,1);
    return;
end
% Start the partition of the sphere into N regions by partitioning
% to caps defined in the current dimension.
[a_cap, n_regions] = eq_caps(dim,N);
% a_cap is an increasing list of angles of the caps.

% We have a number of zones: two polar caps and a number of collars.
% n_regions is the list of the number of regions in each zone.

    n_collars = size(n_regions,2)-2;

        cache_size = floor(n_collars/2);
        cache = cell(1,cache_size);

    % Start with the 'centre' point of the North polar cap.
    % This is the North pole.
    points_s = zeros(dim,N);
    point_n = 2;
    % Determine the 'centre' points for each collar.

    offset = 0;

    for collar_n = 1:n_collars
        % a_top is the colatitude of the top of the current collar.
        a_top = a_cap(collar_n);
        % a_bot is the colatitude of the bottom of the current collar.
        a_bot = a_cap(1+collar_n);
        % n_in_collar is the number of regions in the current collar.
        n_in_collar = n_regions(1+collar_n);
         % The top and bottom of the collar are small (dim-1)-spheres,
        % which must be partitioned into n_in_collar regions.
        % Use eq_point_set_polar recursively to partition
        % the unit (dim-1)-sphere.
        % points_1 is the resulting list of points.

            twin_collar_n = n_collars-collar_n+1;
            if twin_collar_n <= cache_size && ...
                size(cache{twin_collar_n},2) == n_in_collar
                points_1 = cache{twin_collar_n};
            else
%%%%%%%%%%%points_1 =eq_point_set_polar_lsb(dim-1,n_in_collar); %added by lsb
            if n_in_collar ==1
                % We have only one region, which must be the whole sphere.
                points_1 =zeros(dim-1 ,1);
            else
                % We have a circle. Return the angles of N equal sectors.
                sector_1 =1 :n_in_collar;
                a_cap_1 =sector_1 *2 *pi /n_in_collar;
                points_1 =a_cap_1 -pi /n_in_collar;          
            end                
%%%%%%%%%%%%    
                cache{collar_n} = points_1;
            end
        % Given points_1, determine the 'centre' points for the collar.
        % Each point of points_1 is a 'centre' point on the (dim-1)-sphere.
        %
        % Angular 'centre' point;
        % The first angles are those of the current 'centre' point
        % of points_1, and the last angle in polar coordinates is the average of
        % the top and bottom angles of the collar,
        %
        a_point = (a_top+a_bot)/2;
        point_1_n = 1:size(points_1,2);

            % The (dim-1)-sphere is a circle

            points_s(1:dim-1,point_n+point_1_n-1) = mod(points_1(:,point_1_n)+2*pi*offset,2*pi);
            % Given the number of sectors in the current collar and
            % in the next collar, calculate the next offset.
            % Accumulate the offset, and force it to be a number between 0 and 1.

            offset = offset + circle_offset(n_in_collar,n_regions(2+collar_n),extra_offset);
            offset = offset - floor(offset);

        points_s(dim, point_n+point_1_n-1) = a_point;
        point_n = point_n + size(points_1,2);
    end
    
    % End with the 'centre' point of the bottom polar cap.

    points_s(:,point_n) = zeros(dim,1);
    points_s(dim,point_n) = pi;
end

