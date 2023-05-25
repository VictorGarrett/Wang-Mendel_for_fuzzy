


fis = createSystem();

[trainInputs, validationInputs, trainValueOutputs, validationValueOutputs, trainClassOutputs, validationClassOutputs] = prepareData("treino_sinais_vitais_com_label.txt");



fis = generateRules(fis, trainInputs, trainValueOutputs, trainClassOutputs);
evaluate(fis, validationInputs , validationClassOutputs);
