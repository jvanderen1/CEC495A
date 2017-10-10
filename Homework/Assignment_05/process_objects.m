%% Function: process_objects()

function [subImages, subImagesScaled] = process_objects(BW)

    % Gathering objects using regionprops . . .
    [labels, ~] = bwlabel(BW, 8);
    Istats = regionprops(labels, 'basic', 'Centroid');

    % Cutting out smaller objects . . .
    Istats( [Istats.Area] < 1000 ) = [];
    num = length( Istats );

    % Create bounding box around objects . . .
    Ibox = floor( [Istats.BoundingBox] );
    Ibox = reshape( Ibox, [4 num]);

    % Plot bounding boxes . . .
    for k = 1 : num
        col_1 = Ibox(1, k);
        col_2 = col_1 + Ibox(3, k);
        row_1 = Ibox(2, k);
        row_2 = row_1 + Ibox(4, k);

        subImages{k} = BW( row_1:row_2, col_1:col_2 );
        subImagesScaled{k} = imresize(subImages{k}, [24 12]);
    end
end