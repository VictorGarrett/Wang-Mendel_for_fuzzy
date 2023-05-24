function evaluate(fis, inputs, outputs)

    [output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis, inputs)
    [output_v output_i] = max(evalmf(fis.Outputs(1).MembershipFunction, output))

    conf = zeros(4,4)
    for i = 1:numel(output_i)
        conf(outputs(i), output_i(i)) = conf(outputs(i), output_i(i)) + 1;
    end
    conf
end
