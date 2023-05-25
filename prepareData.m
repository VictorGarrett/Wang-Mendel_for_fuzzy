
%prepares data from a file to generate rules

%every row of the inputs and outputs matrix is a diferent training example

%the inputs matrix has 3 columns, one for each variable (qPa, pulso, resp)

%the outputs matrix has 1 column, it contains the index of the associated
%category (1 = critico, 2 = instavel, 3 = potencialmente estavel, 4 = estavel)
function [trainInputs, validationInputs, trainValueOutputs, validationValueOutputs, trainClassOutputs, validationClassOutputs] = prepareData(file)

    fileID = fopen(file);

    data = fscanf(fileID, "%d, %f, %f, %f, %f, %f, %f, %d", [8 800]);

    inputs = data(4:6, :); 
    inputs = inputs.';

    valueOutputs = data(7, :);
    valueOutputs = valueOutputs.';

    classOutputs = data(8, :);
    classOutputs = classOutputs.';

    fclose(fileID);

    perm = randperm(length(inputs)).';
    
    inputs = inputs(perm, :);
    valueOutputs = valueOutputs(perm);
    classOutputs = classOutputs(perm);


    trainInputs = inputs(1:length(inputs)*4/5, :);
    validationInputs = inputs(length(inputs)*4/5 + 1:length(inputs), :);
    
    trainValueOutputs = valueOutputs(1:length(valueOutputs)*4/5, :);
    validationValueOutputs = valueOutputs(length(valueOutputs)*4/5 + 1:length(valueOutputs), :);
    
    trainClassOutputs = classOutputs(1:length(classOutputs)*4/5, :);
    validationClassOutputs = classOutputs(length(classOutputs)*4/5 + 1:length(classOutputs), :);
end