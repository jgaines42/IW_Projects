function volumes = calc_protein_volume(file_name)
%load the structure of the protein of interest
load(file_name) %Removed all residues more than 6A from ST

%Assign the first column to be the row number
tempModel2(:,1) = num2cell(1:size(tempModel2,1));

%Add sizes
tempModel2 = add_atom_sizes(tempModel2);

%Extract the coordinates and radii
coordinates = cell2mat(tempModel2(:,8:10));
radii = cell2mat(tempModel2(:,7));

%Presquare the radii so we don't need to do it in the loop
radii_squared = radii.^2;

points_in_each = zeros(size(tempModel2,1),1); %The total number of points in each atom

%find the minimum and maximum of the protein in each direction
all_x = [coordinates(:,1)+radii; coordinates(:,1)-radii];
all_y = [coordinates(:,2)+radii; coordinates(:,2)-radii];
all_z = [coordinates(:,3) + radii; coordinates(:,3)-radii];

min_x = min(all_x);
max_x = max(all_x);
min_y = min(all_y);
max_y = max(all_y);
min_z = min(all_z);
max_z = max(all_z);

num_points = 100000000;

for i = 1:num_points
    x1 = rand();
    y1 = rand();
    z1 = rand();
    % x1 and y1 are both in the range of 0 to 1. We need to change them to
    % be on the range of the box around the circles
    
    %We do this by multiplying by the range and adding the minimum value
    x2 = (x1*(max_x-min_x))+min_x;
    y2 = (y1*(max_y-min_y))+min_y;
    z2 = (z1*(max_z-min_z))+min_z;
    
    %Calculate the distance from this point to the center of each atom
    this_coord = [x2 y2 z2];
    dist1 = coordinates - repmat(this_coord,size(coordinates,1),1);
    dist2 = dist1.^2;
    dist3 = sum(dist2,2);
    
    %To speed up the calculations we don't do the square root of dist3.
    %If dist3 -radii_squared is less than 0, then an overlap occurs
    dist4 = dist3-radii_squared;
    if min(dist4) < 0 %If there is an overlap
        
        %The smallest value of dist4 is the atom we want to assign this
        %point to. This is the same as checking all the pairwise
        %overlaps as in area_overlapping_circles
        [val, ind] = min(dist4);
        points_in_each(ind) = points_in_each(ind)+1;
    end
    
end

%We now have the number of points in each atom. Add a few lines of code
%that calculates the volume of each atom using this data
volumes = 0;
end
