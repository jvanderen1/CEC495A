%% Assignment 3

close all; clc; clear all;

STARTING_FRAME = 0;
ENDING_FRAME = 6;

for k = STARTING_FRAME : ENDING_FRAME
    
    % Gathers image . . .
    Irgb = imread(['impellers/rotor', sprintf('%2.2d', k), '.jpg']);
    
    % Converts to hsv . . .
    Ihsv = rgb2hsv(Irgb);
    
    % Uses only brightness component . . .
    I = Ihsv(:, :, 3);

    % Performs edge detection on image . . .
    BW = edge(I, 'canny', [0.1, 0.67]);     % hysteresis, gamma (blur)
    
    size = 1;
    Istats = FillImage(BW, size);
    while (length(Istats) ~= 1)
        size = size + 1;
        [Istats, BW_fill] = FillImage(BW, size);
    end

    % Calculate radius and center of object
    radius = max(Istats.BoundingBox(3) / 2, Istats.BoundingBox(4) / 2);
    Center.x = Istats.BoundingBox(1) + Istats.BoundingBox(3) / 2;
    Center.y = Istats.BoundingBox(2) + Istats.BoundingBox(4) / 2;

    % Create a circle inside of matrix . . .
    zeromatrix = zeros(length(BW_fill));
    img_circle = MidpointCircle(zeromatrix, radius, Center.x, Center.y, 1);
    img_circle = imfill(img_circle, 'holes');
    
    % Gathers empty space inside of circle . . .
    empty_space_px = img_circle - BW_fill;
    
    % Show image with box and circle . . .
%     imshow(BW_fill);
%     rectangle('Position', Istats.BoundingBox, 'EdgeColor', 'r');
%     rectangle('Position', Istats.BoundingBox, 'Curvature', [1, 1], 'EdgeColor', 'g');

    % Gather number of pixels for ratio . . .
    ratio = sum(empty_space_px(:) ~= 0) / bwarea(img_circle);
    fprintf('Ratio %2.2d: %1.4f\n', k, ratio);
end
