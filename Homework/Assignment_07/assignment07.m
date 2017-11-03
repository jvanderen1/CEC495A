%% Lecture 9: Object Detection with SURF

close all; clc; clear all;

% Add directory to Matlab Search path
addpath('OpenSURF')

% Read in base image . . .
I1 = imread('imgs/base.jpg');
Ipts1 = OpenSurf(I1);

for k = 1:length(Ipts1)
    D1(:, k) = Ipts1(k).descriptor;
end

% Read in sub image . . .
I2 = imread('imgs/sub.jpg');
Ipts2 = OpenSurf(I2);

for k = 1:length(Ipts2)
    D2(:, k) = Ipts2(k).descriptor;
end
    
BaseLength = length(Ipts1);
SubLength = length(Ipts2);

for i = 1:BaseLength
    subtract = (repmat(D1(:,i), [1 SubLength]) - D2).^2;
    distance = sum(subtract);
    [SubValue(i), SubIndex(i)] = min(distance);
end

[value, index] = sort(SubValue);

BaseIndex = index();
SubIndex = SubIndex(index());

Pos1 = [ [Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]' ];
Pos2 = [ [Ipts2(SubIndex).y]',  [Ipts2(SubIndex).x]' + size(I1, 2) ];

diffX = Pos2(:, 2) - Pos1(:, 2);
diffY = Pos2(:, 1) - Pos1(:, 1);

% Filter out lines by length . . .
lengths = hypot(diffX(:), diffY(:));
lengths = round(lengths);
length = mode(lengths);

length_diff = 150;
%indexMode = find( (lengths >= length-length_diff) & (lengths <= length+length_diff) );

% Filter out lines by angle . . .
%angles = atan2d(diffY(indexMode), diffX(indexMode));
angles = atan2d(diffY(:), diffX(:));
angles = round(angles);
angle = mode(angles);

angle_diff = 1;
%indexMode = find( (angles >= angle-angle_diff) & (angles <= angle+angle_diff) );
indexMode = find( (angles >= angle-angle_diff) & (angles <= angle+angle_diff) & (lengths >= length-length_diff) & (lengths <= length+length_diff) );


% Concatenate 2 images together to see values . . .
I = cat(2, I1, I2);
figure, imshow(I); hold on;

plot([Pos1(indexMode, 2), Pos2(indexMode, 2)]', ...
         [Pos1(indexMode, 1), Pos2(indexMode, 1)]', ...
         's-', ...
         'linewidth', 2);
