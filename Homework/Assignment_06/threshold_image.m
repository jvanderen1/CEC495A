%% Function: threshold_image()

function BW = threshold_image(name)

    % Open image and turn to black & white. . .
    Igray = imread(name);
    Ithresh = Igray > 175;
    BW = imcomplement(Ithresh);

    % Get rid of small amounts of sand . . .
    SE = strel('disk', 4, 8);
    BW = imdilate(BW, SE);
    BW = imerode(BW, SE);
    
end