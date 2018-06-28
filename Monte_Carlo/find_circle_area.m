function area = find_circle_area(center, radius, num_points)


points_in = 0;

%create box around circle
min_x = center(1)-radius;
min_y = center(2)-radius;
max_x = center(1)+radius;
max_y = center(2) + radius;
max_z = center(3)+radius;
min_z = center(3)-radius;
%figure
%plot([min_x max_x max_x min_x min_x], [min_y min_y max_y max_y min_y],'k', 'LineWidth', 2)
%hold all

for i = 1:num_points
    %Generate random points
    x1 = rand();
    y1 = rand();
    z1 = rand();
    % x1 and y1 are both in the range of 0 to 1. We need to change them to
    % be on the range of the box around the circle
    
    %We do this by multiplying by the range and adding the minimum value
    x2 = (x1*(max_x-min_x))+min_x;
    y2 = (y1*(max_y-min_y))+min_y;
    z2 = (z1*(max_z-min_z))+min_z;
    %Now see if we are in the circle using the pythagorean theorem to find
    %the distance from the point to the center of the circle
    dist = sqrt((x2-center(1)).^2 + (y2-center(2)).^2);
    %if dist is < than the radii, we are in the circle
  
    if dist < radius
        points_in = points_in + 1;
      %  plot(x2, y2, '.r', 'MarkerSize', 15)
    else
      %  plot(x2, y2, '.b', 'MarkerSize', 15)
    end
   
end

%Now calculate the area
area_square = (max_x-min_x)*(max_y-min_y)*(max_z-min_z);
area  = (points_in/num_points)*area_square;

    



end