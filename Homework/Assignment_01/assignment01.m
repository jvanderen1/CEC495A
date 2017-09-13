close all; clc; clear all;

STARTING_FRAME  =   1;
ENDING_FRAME    =   448;

X_centroid      =   [];
Y_centroid      =   [];

SE = strel('disk', 2, 0);

for k = STARTING_FRAME : ENDING_FRAME - 1
    
    rgb1 = imread(['ant/img', ...
        sprintf('%2.3d', k), '.jpg']);
    
    rgb2 = imread(['ant/img', ...
        sprintf('%2.3d', k + 1), '.jpg']);
    
    diff = abs(rgb1 - rgb2);

    hsv = rgb2hsv(diff);
    Isub = hsv(:, :, 3);
    % imhist(Isub)

    Ithresh = Isub > 0.06667;
    
    Iopen = imopen(Ithresh, SE);
    Iclose = imclose(Iopen, SE);

    [labels, number] = bwlabel(Iclose, 8);
    if number ~= 0
        Istats = regionprops(labels, 'basic', 'Centroid');
        [maxVal, maxIndex] = max([Istats.Area]);

        X_centroid = [X_centroid Istats(maxIndex).Centroid(1)];
        Y_centroid = [Y_centroid Istats(maxIndex).Centroid(2)];
    end
end

figure('name', 'Look at this Freaking Ant Go . . .', 'NumberTitle', 'off');
hold on;
imshow(rgb2);
hold on;
plot(X_centroid, Y_centroid, 'g');
