close all; clc; clear all;

% Open image . . .
I = imread('envelopes/envelope3.jpg');

% Filter out unnecessary lighting . . .
Imed = medfilt2(I, [100 100]);
Ifinal = Imed - I;

% Make pure black or white image . . .
BW = Ifinal > 50;

% Get rid of small amounts of sand . . .
% Note: maybe don't need this
SE = strel('disk', 1, 8);
BW = imopen(BW, SE);
BW = imclose(BW, SE);

% Find angle image needs to rotate . . .
angle = FindAngleOfRotation(BW);

Irot = imrotate(BW, angle, 'crop');

% Crop image . . .
[row, col, ] = size(Irot);
Icrop = imcrop(Irot, [0, (2*row)/3, col/2, row/3]);

% Cut out all numbers . . .
strel_size = 1;
[labels, number, BW_2] = ImageCleanup(Icrop, strel_size);

% There should be 8 objects in image . . .
while number ~= 8
    strel_size = strel_size + 1;
    [labels, number, BW_2] = ImageCleanup(Icrop, strel_size);
end

% Gather stats on each object . . .
Istats = regionprops(labels, 'basic', 'Centroid');

% Plot image . . .
figure('name', 'Look at this Sexy Envelope . . .', 'NumberTitle', 'off');
imshow(BW_2, 'Border', 'tight');

for i = 3 : number
    Istats(i).BoundingBox(4) = Istats(i).BoundingBox(4) + 90;
    Istats(i).BoundingBox(2) = Istats(i).BoundingBox(2) + 30;
    
    text(Istats(i).Centroid(1), Istats(i).Centroid(2), int2str(i - 2))
    rectangle('Position', Istats(i).BoundingBox, 'EdgeColor', 'r');
end
