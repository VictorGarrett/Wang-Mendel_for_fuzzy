test_fis = readfis("fisbest.fis");

fileID = fopen("treino_sinais_vitais_com_label.txt");

data = fscanf(fileID, "%d, %f, %f, %f, %f, %f, %f, %d", [8 800]);

inputs = data(4:6, :); 
inputs = inputs.';

valueOutputs = data(7, :);
valueOutputs = valueOutputs.';

classOutputs = data(8, :);
classOutputs = classOutputs.';

evaluate(test_fis, inputs, classOutputs)