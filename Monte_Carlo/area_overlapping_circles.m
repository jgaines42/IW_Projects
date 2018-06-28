function area = area_overlapping_circles(centers, radii, num_points)


points_in_circle1= 0;
points_in_circle2 = 0;

%create box around the circles
%First find the min and max points of each circle
all_x = [centers(:,1)+radii; centers(:,1)-radii];
all_y = [centers(:,2)+radii; centers(:,2)-radii];
min_x = min(all_x);
max_x = max(all_x);
min_y = min(all_y);
max_y = max(all_y);

figure
hold all

for i = 1:num_points
    %Generate random points
    x1 = rand();
    y1 = rand();
    % x1 and y1 are both in the range of 0 to 1. We need to change them to
    % be on the range of the box around the circles
    
    %We do this by multiplying by the range and adding the minimum value
    x2 = (x1*(max_x-min_x))+min_x;
    y2 = (y1*(max_y-min_y))+min_y;
    
    %Now see if we are in either circle using the pythagorean theorem to find
    %the distance from the point to the center of the circle
    dist1 = sqrt((x2-centers(1,1)).^2 + (y2-centers(1,2)).^2);
    dist2 = sqrt((x2-centers(2,1)).^2 + (y2-centers(2,2)).^2);
    
    %Now 4 things could happen. We could be in circle1, circle2, both, or
    %none. If we are in an individual circle, 
  
    if dist1 < radii(1) && dist2 > radii(2) % We are in circle 1
        points_in_circle1 = points_in_circle1 + 1;
                    plot(x2, y2, '.b')

    elseif dist1 > radii(1) && dist2 < radii(2) % We are in circle 1
        points_in_circle2 = points_in_circle2 + 1;
                            plot(x2,y2,'.r')

    elseif dist1 < radii(1) && dist2 < radii(2) % We are in both circles
        %If we are in both circles, we want draw a dividing plane between
        %the two circles and see which side we are drawn. This plane/line
        %is drawn between the intersection points of the circles. 
        
        %The following line tells us what side of the dividing line we are
        % on.Do out the math on paper to see why this works
        if (dist1^2-radii(1)^2) < (dist2^2-radii(2)^2)
            points_in_circle1 = points_in_circle1 + 1;
            plot(x2, y2, '.b')
        else
            points_in_circle2 = points_in_circle2 + 1;
            plot(x2,y2,'.r')
       
        end
    end
   
end

%Now use the number of points in each circle to calculate the area
area_square = (max_x-min_x)*(max_y-min_y);
area1  = (points_in_circle1/num_points)*area_square;
area2 = (points_in_circle2/num_points)*area_square;
area = [area1;area2];


    



end