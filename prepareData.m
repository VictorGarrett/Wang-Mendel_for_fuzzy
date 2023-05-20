
%prepares data from a file to generate rules

%every row of the inputs and outputs matrix is a diferent training example

%the inputs matrix has 3 columns, one for each variable (qPa, pulso, resp)

%the outputs matrix has 1 column, it contains the index of the associated
%category (1 = critico, 2 = instavel, 3 = potencialmente estavel, 4 = estavel)
function [inputs, outputs] = prepareData(file)

    %TODO

    inputs = zeros(800, 3);%TEST ONLY
    outputs = ones(800, 1);%TEST ONLY
end