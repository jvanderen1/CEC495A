%% FillImage Function

function [ Istats, BW ] = FillImage( BW, size )

% Dialate image to connect edges . . .
        SE(1) = strel('line', size, 90);
        SE(2) = strel('line', size, 0);

        BW = imdilate(BW, SE);
        BW = imfill(BW, 'holes');
        BW = imclearborder(BW, 4);

        % Finds objects in image . . .
        label = bwlabel(BW, 8);
        Istats = regionprops(logical(label), 'basic', 'Centroid');
end

