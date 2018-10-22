function [ regions ,s_cap ,n_regions ] = eq_regions( N )
%EQ_REGIONS Recursive zonal equal area (EQ) partition of sphere
%
%%%%%%%%%%%%%%%%%%%

extra_offset = false; %added by lsb 
dim =2; %added by lsb 
%
if N ==1
    % We have only one region, which must be the whole sphere.
    regions = zeros(dim,2,1);
    regions(:,:,1) = sphere_region(dim);
    return;
end
%
% Start the partition of the sphere into N regions by partitioning
% to caps defined in the current dimension.
[s_cap, n_regions] = eq_caps(dim ,N);
% s_cap is an increasing list of colatitudes of the caps.
% n_regions is the list of the number of regions in each zone.
%
% We have a number of zones: two polar caps and a number of collars.
n_collars = size(n_regions,2)-2;
%
% Start with the top cap.
regions = zeros(dim,2,N);
regions(:,:,1) = top_cap_region(dim,s_cap(1));
region_n = 1;
%
% Determine the dim-regions for each collar.
offset = 0;
%
for collar_n = 1:n_collars
    % c_top is the colatitude of the top of the current collar.
    c_top = s_cap(collar_n);
    % c_bot is the colatitude of the bottom of the current collar.
    c_bot = s_cap(1 +collar_n);
    % n_in_collar is the number of regions in the current collar.
    n_in_collar = n_regions(1 +collar_n);
    if n_in_collar ==1
        % We have only one region, which must be the whole sphere.
        s_cap_1 =pi;
    else
        sector_1 =1 :n_in_collar;
        s_cap_1 =sector_1 *2 *pi /n_in_collar;
    end
    regions_1 =zeros(dim -1 ,2 ,n_in_collar);
    regions_1(: ,1 ,2 :n_in_collar) =s_cap_1(1 :n_in_collar -1);
    regions_1(:,2,:) =s_cap_1;
    for region_1_n = 1:size(regions_1,3)
        % Top of 2-region;
        % The first angle is the longitude of the top of
        % the current sector of regions_1, and
        % the second angle is the top colatitude of the collar.
        r_top = [mod(regions_1(1,1,region_1_n)+2*pi*offset,2*pi); c_top];
        % Bottom of 2-region;
        % The first angle is the longitude of the bottom of
        % the current sector of regions_1, and
        % the second angle is the bottom colatitude of the collar.
        r_bot = [mod(regions_1(1,2,region_1_n)+2*pi*offset,2*pi); c_bot];
        if r_bot(1) < r_top(1)
           r_bot(1) = r_bot(1) + 2*pi;
        end
        region_n = region_n+1;
        regions(:,:,region_n) = [r_top,r_bot];
    end
    % Given the number of sectors in the current collar and
    % in the next collar, calculate the next offset.
    % Accumulate the offset, and force it to be a number between 0 and 1.
    offset = offset + circle_offset(n_in_collar,n_regions(2+collar_n),extra_offset);
    offset = offset - floor(offset);
end
% End with the bottom cap.
regions(:,:,N) = bot_cap_region(dim ,s_cap(1));
end
