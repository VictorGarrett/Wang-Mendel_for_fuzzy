fis = createSystem();
f_mea_best= [];
best = 0;
fis_best = fis;
for i=1:10
    i
    aux = 1;
    [trainInputs, validationInputs, trainValueOutputs, validationValueOutputs, trainClassOutputs, validationClassOutputs] = prepareData("treino_sinais_vitais_com_label.txt");

    fis = generateRules(fis, trainInputs, trainValueOutputs, trainClassOutputs);

    models(i) = fis;
    model_scores(1:4, i) = evaluate(fis, validationInputs , validationClassOutputs);
end

model_scores_total(1:10) = model_scores(1, 1:10).*model_scores(2, 1:10).*model_scores(3, 1:10);
[sorted_model_scores_total, score_indices] = sort(model_scores_total);

best_model_index = score_indices(6);

writeFIS(models(best_model_index), "fisbest");
