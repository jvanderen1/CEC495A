% Joshua Van Deren

close all; clear all; clc;
addpath(genpath('ransac'));

Registered_1 = 'img/3.jpg';
Registered_2 = 'img/4.jpg';

% Reading in images.. if past the first frame, use the Jregistered
% image from the previous step as pos1, and load a new image into pos2
pos1 = imread(Registered_1);
pos2 = imread(Registered_2);

% Convert images to grayscale (necessary for Harris corner detection)
Im1 = rgb2gray(pos1);
Im2 = rgb2gray(pos2);  

[m1, m2] = Surf_func(Im1, Im2);

% RANSAC
[H, inliers] = ransacfithomography(m1, m2, 0.001);

% Moving = second frame, Fixed = first frame or Jregistered
fixedPoints = [m1(2,inliers)' m1(1,inliers)'];
movingPoints = [m2(2,inliers)' m2(1,inliers)'];

% Determining the transform based on the relationship matrices between
% the coordinates in the two images
tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');

% Image registration (alignment)
Jregistered = imwarp(pos2,tform,'OutputView',imref2d(size(pos1)));
falsecolorOverlay = imfuse(pos1,Jregistered);

% Displaying the four images
imshow(falsecolorOverlay,'Border','tight'); hold on;

% Display everything to the figure window
drawnow;