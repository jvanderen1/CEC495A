%% Assignment 5: Normalized Cross Correlation

close all; clc; clear all;

% Gathers BW image from location . . .
BW = threshold_image('xcorr/unknown.jpg');

% Provides a set of objects from BW image . . .
[~, UnknownImagesScaled] = process_objects(BW);

% [ Repeat with template ]
BW = threshold_image('xcorr/template.jpg');
[~, TemplateImagesScaled] = process_objects(BW);

% Create empty arrays for storing max correlation and index . . .
maxCorr = [];
maxIndex = [];

% Goes through all images and templates to compare . . .
for i = UnknownImagesScaled
    corr = [];
    for j = TemplateImagesScaled
        % Finds how much the object correlates with the templates . . .
        value = normxcorr2(i{1}, j{1});
        corr(end + 1) = max(value(:));
    end
    
    % Stores maximum correlation and index . . .
    [maxCorr(end+1), maxIndex(end+1)] = max( corr(:) );
end

%%
% <include>process_objects.m</include>
%
% <include>threshold_image.m</include>

%%

% The post code (in our case) is the index - 1 . . .
postCode = maxIndex - 1