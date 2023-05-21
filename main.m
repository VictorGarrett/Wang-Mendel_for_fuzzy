fis = createSystem();

[inputs, outputs] = prepareData("treino_sinais_vitais_com_label.txt");

fis = generateRules(fis, inputs, outputs);