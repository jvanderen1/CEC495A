close all; clc; clear all;

field1 = 'x';  value1 = [];
field2 = 'y';  value2 = [];

centroid_coordinates = struct(field1,value1,field2,value2);

STARTING_FRAME  =   1;
ENDING_FRAME    =   489;

Ball_1 = centroid_coordinates;
Ball_2 = centroid_coordinates;

for k = STARTING_FRAME : ENDING_FRAME - 1
    
    rgb = imread(['balls/img', ...
        sprintf('%2.3d', k), '.jpg']);
    
    [BW_1, masked_1] = blue_ball_mask(rgb);
    [BW_2, masked_2] = red_ball_mask(rgb);
    
    [labels_1, number_1] = bwlabel(BW_1, 8);
    
    if number_1 ~= 0
        Istats = regionprops(labels_1, 'basic', 'Centroid');
        [maxVal, maxIndex] = max([Istats.Area]);
        
        Ball_1.x = [Ball_1.x Istats(maxIndex).Centroid(1)];
        Ball_1.y = [Ball_1.y Istats(maxIndex).Centroid(2)];
    end
    
    [labels_2, number_2] = bwlabel(BW_2, 8);
    
    if number_2 ~= 0
        Istats = regionprops(labels_2, 'basic', 'Centroid');
        [maxVal, maxIndex] = max([Istats.Area]);
        
        Ball_2.x = [Ball_2.x Istats(maxIndex).Centroid(1)];
        Ball_2.y = [Ball_2.y Istats(maxIndex).Centroid(2)];
    end
end

figure('name', 'Look at These Balls Go . . .', 'NumberTitle', 'off');
hold on;
imshow(rgb);
hold on;
plot(Ball_1.x, Ball_1.y, 'b*');
hold on;
plot(Ball_2.x, Ball_2.y, 'ro');
