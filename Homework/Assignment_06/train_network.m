%% Script: train_network

close all; clc; clear all;

% [ Repeat with training ]
BW = threshold_image('training/training.jpg');
[~, ~, TPattern] = process_objects(BW);

% Fill TTarget with pattern of 1's . . .
TTarget = zeros(10, 100);
for row = 1:10
    TTarget( row, (10*row-9):(10*row) ) = 1;
end

% Train neural network to detect specific objects . . .
net = newff([zeros(288, 1), ones(288, 1)], ...
    [24, 10], ...
    {'logsig', 'logsig'}, ...
    'traingdx');

net.trainParam.epochs = 500;
net = train(net, TPattern, TTarget);
delete('neural_network.mat');
save('neural_network.mat', 'net');

%{
% Note %
TPattern
    row: holds object data
    column: specifies which object
TTarget
    row: holds where objects belong
    column: specifies which object
%}