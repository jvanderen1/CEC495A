close all; clc; clear all;

field1 = 'x';  value1 = [];
field2 = 'y';  value2 = [];

centroid_coordinates = struct(field1,value1,field2,value2);

STARTING_FRAME  =   1;
ENDING_FRAME    =   936;

Ball(3) = centroid_coordinates;

figure('name', 'Look at These Balls Go . . .', 'NumberTitle', 'off');

se = strel('disk',15);

for f = STARTING_FRAME : ENDING_FRAME
    
    rgb = imread(['juggle/img', ...
        sprintf('%2.3d', f), '.jpg']);
    
    [BW, masked] = ball_mask(rgb);
    BW = imdilate(BW, se);
    
    [labels, number] = bwlabel(BW, 8);
    
    Istats = regionprops(labels, 'basic', 'Centroid');
    [values, index] = sort([Istats.Area], 'descend');   % Gathers largest objects
    
    if f == 1
        for b = 1 : 1 : 3
            Ball(b).x = [Ball(b).x Istats(index(b)).Centroid(1)];
            Ball(b).y = [Ball(b).y Istats(index(b)).Centroid(2)];
            
            imshow(rgb);
            hold on;
        end
    
    elseif number >= 3
        
        dist = [];
        for b = 1 : 1 : 3
            for d = 1 : 1 : 3
                dist(b,d) = (hypot(abs(Ball(b).x(end) - Istats(index(d)).Centroid(1)), ...
                                   abs(Ball(b).y(end) - Istats(index(d)).Centroid(2))));
            end
        end
       
        [minvalue, minindex] = min(dist);
        
        for b = 1 : 1 : 3
            Ball(b).x = [Ball(b).x Istats(minindex(b)).Centroid(1)];
            Ball(b).y = [Ball(b).y Istats(minindex(b)).Centroid(2)];
        end
    end
end

plot(Ball(1).x, Ball(1).y, 'g*');
plot(Ball(2).x, Ball(2).y, 'ro');
plot(Ball(3).x, Ball(3).y, 'b.');

