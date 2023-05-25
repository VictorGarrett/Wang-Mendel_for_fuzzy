fis = createSystem();
f_mea_best= [];
best = 0;
fis_best = fis;
for i=1:10
    i
    aux = 1;
    [trainInputs, validationInputs, trainValueOutputs, validationValueOutputs, trainClassOutputs, validationClassOutputs] = prepareData("treino_sinais_vitais_com_label.txt");

    fis = generateRules(fis, trainInputs, trainValueOutputs, trainClassOutputs);
    f_mea_best_aux = evaluate(fis, validationInputs , validationClassOutputs);
    f_mea_best_aux;
    for j=1:3
        aux = f_mea_best_aux(j)*aux;
    end
     aux
     best
    if  aux> best
        fis_best = fis;
        best = aux;
        f_mea_best = f_mea_best_aux;
    end
    
    f_mea_best;
end
 best
 f_mea_best
 writeFIS(fis_best, "fisbest");
