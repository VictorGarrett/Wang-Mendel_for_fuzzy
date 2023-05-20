function fisout = generateRules(fis, inputData, outputData)

    fisout = fis;
    %initialize with default rules (weight = 0)
    for i = 1:5
        for j = 1:5
            for k = 1:5
                rulecube(i, j, k) = fisrule([i j k 1 0 1], 3);
            end
        end
    end
    
    %   Generate rules from data, if a generated rule is in conflict with a
    %previous rule, overwrite if its weight is larger.
    %   Every pair [activations ruleinputs] has which mf has been most
    %activated, together with its activation value.
    for i = 1:length(inputData)
        for j = 1:3 %for every input variable
            %fuzzify inputs, get which mf returns the largest value
            [activations(j), ruleinputs(j)] = max(evalmf(fis.Inputs(j).MembershipFunctions, inputData(i, j)));
        end
        %Generate the rule. The rule is created from the mfs which the
        %input value most activates and the given output. The weight of the
        %rule is the product of every mf activation.
        newrule = fisrule([ruleinputs outputData(i) prod(activations) 1], 3);

        %overwrite only if weight is larger
        if rulecube(ruleinputs(1), ruleinputs(2), ruleinputs(3)).Weight < newrule.Weight
           rulecube(ruleinputs(1), ruleinputs(2), ruleinputs(3)) = newrule;
        end

    end

    %write all rules to the output system
    for i = 1:numel(rulecube)
        fisout = addRule(fisout, [rulecube(i).Antecedent rulecube(i).Consequent rulecube(i).Weight 1]);
    end
end