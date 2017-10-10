%% Function: threshold_image()

function BW = threshold_image(name)

    % Open image and turn to black & white. . .
    Igray = imread(name);
    Ithresh = Igray > 175;
    BW = imcomplement(Ithresh);

    % Get rid of small amounts of sand . . .
    % Note: maybe don't need this
    SE = strel('disk', 2, 8);
    BW = imdilate(BW, SE);
    
end