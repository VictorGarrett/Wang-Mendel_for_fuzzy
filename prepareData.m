
%prepares data from a file to generate rules

%every row of the inputs and outputs matrix is a diferent training example

%the inputs matrix has 3 columns, one for each variable (qPa, pulso, resp)

%the outputs matrix has 1 column, it contains the index of the associated
%category (1 = critico, 2 = instavel, 3 = potencialmente estavel, 4 = estavel)
function [inputs, outputs] = prepareData(file)

    fileID = fopen(file);

    data = fscanf(fileID, "%d, %f, %f, %f, %f, %f, %f, %d", [8 800]);

    inputs = data(4:6, :); 
    inputs = inputs.'

    outputs = data(8, :);
    outputs = outputs.'
    fclose(fileID);
end