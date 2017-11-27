%% Object Detection with SURF

function [Pos1, Pos2] = Surf_func(I1, I2)

% I1 = imread(img1);
Ipts1 = OpenSurf(I1);

for k = 1:length(Ipts1)
    D1(:, k) = Ipts1(k).descriptor;
end

% I2 = imread(img2);
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

NumberOfPoints = 20;
BaseIndex = index(1:NumberOfPoints);
SubIndex = SubIndex(index(1:NumberOfPoints));

Pos1 = [ [Ipts1(BaseIndex).y]', ...
    [Ipts1(BaseIndex).x]' ]';
Pos2 = [ [Ipts2(SubIndex).y]', ...
    [Ipts2(SubIndex).x]' ]';
