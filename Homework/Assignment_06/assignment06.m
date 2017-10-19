%% Assignment 6: ANN Handwriting Recognition

close all; clc; clear all;

TOTAL_RUNS = 10;

% Load neural network to use . . .
load('neural_network')

% Sets up what images to process . . .
files = dir(fullfile('ann', '*.jpg'));

% Go through each file in directory . . .
for i = 1:length(files)
    
    % Gathers BW image from location . . .
    BW = threshold_image(fullfile('ann', files(i).name));

    % Provides a set of objects from BW image . . .
    [~, ~, UPattern] = process_objects(BW);
    
    % Gather string of filename (or in our case, correct answer) . . .
    [~, known_digits{i}, ~] = fileparts(files(i).name);

    % Structure to hold each test result . . .
    test(i).total_runs = TOTAL_RUNS;
    test(i).correct = 0;
    test(i).incorrect = 0;
    
    % Tests each image a total of TOTAL_RUNS times . . .
    for k = 1:TOTAL_RUNS
        % Uses newly trained neural network . . .
        weights = net(UPattern);

        % Find postcode through weights . . .
        [~, numbers{k, i}] = max(weights);
        numbers{k, i} = numbers{k, i} - 1;
        
        unknown_digits = num2str(numbers{k, i}, '%d');
        diff = known_digits{i} - unknown_digits;
        
        test(i).correct = test(i).correct + sum(diff == 0);
        test(i).incorrect = test(i).incorrect + sum(diff ~= 0);
    end
    
    test(i).percentage = 100 * test(i).correct / (test(i).correct + test(i).incorrect);
end

% Create table with all data . . .
T = table([known_digits]', ...
    [test.total_runs]', ...
    [test.correct]', ...
    [test.incorrect]', ...
    [test.percentage]', ...
    'VariableNames', {'UnknownImage' 'TotalRuns' 'CorrectDigits' 'IncorrectDigits' 'CorrectPercentage'});

disp(T);