function f_mea_best_aux = evaluate(fis, inputs, outputs) 
    f_mea_best_aux = [];
    [output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis, inputs);
    [output_v output_i] = max(evalmf(fis.Outputs(1).MembershipFunction, output));

    conf = zeros(4,4);
    for i = 1:numel(output_i)
        conf(outputs(i), output_i(i)) = conf(outputs(i), output_i(i)) + 1;
    end
    conf;
    acertos = 0;
    for i=1:4
    
        p(i) = conf(i,i)/sum(conf(:,i));
        r(i) = conf(i,i)/sum(conf(i,:));
        fpr(i) = (sum(conf(:,i))-conf(i,i))/sum(conf(i,:));
        acertos =  acertos + conf(i,i);
        f_mea(i) = (2*p(i)*r(i))/(p(i)+r(i));
    end
    
    p;
    r;
    fpr;
    ac = acertos/sum(sum(conf));
    f_mea_best_aux =    f_mea;

end