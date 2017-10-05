%% FindAngleOfRotation

function [labels, number, BW] = ImageCleanup(I, strel_size)
    % Cleanup Sand . . .
    SE = strel('disk', strel_size, 8);
    BW = imopen(I, SE);
    BW = imclose(BW, SE);

    % Get number of objects and labels . . .
    [labels, number] = bwlabel(BW, 8);
end