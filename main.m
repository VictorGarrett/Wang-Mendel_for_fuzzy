fis = createSystem();

[inputs, outputs] = prepareData("aa");

fis = generateRules(fis, inputs, outputs);