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

    %generate missing rules from a mean of surrounding rules
    paddedrulecube = padarray(rulecube, [1, 1, 1], "replicate", "both");
    for i = 2:6
        for j =2:6
            for k =2:6
                if paddedrulecube(i,j,k).Weight == 0 
                    mean_out = ( ...
                        paddedrulecube(i-1,j,k).Weight*(paddedrulecube(i-1,j,k).Consequent)+ ...
                        paddedrulecube(i+1,j,k).Weight*(paddedrulecube(i+1,j,k).Consequent)+ ...
                        paddedrulecube(i,j-1,k).Weight*(paddedrulecube(i,j-1,k).Consequent)+ ...
                        paddedrulecube(i,j+1,k).Weight*(paddedrulecube(i,j+1,k).Consequent)+ ...
                        paddedrulecube(i,j,k+1).Weight*(paddedrulecube(i,j,k+1).Consequent)+ ...
                        paddedrulecube(i,j,k-1).Weight*(paddedrulecube(i,j,k-1).Consequent)...
                        )/...
                        (paddedrulecube(i-1,j,k).Weight+ ...
                        paddedrulecube(i+1,j,k).Weight+ ...
                        paddedrulecube(i,j-1,k).Weight+ ...
                        paddedrulecube(i,j+1,k).Weight+ ...
                        paddedrulecube(i,j,k+1).Weight+ ...
                        paddedrulecube(i,j,k-1).Weight);
                    [activ, conseq] = max(evalmf(fis.Outputs(1).MembershipFunctions, mean_out));
                        paddedrulecube(i,j,k).Consequent = conseq;
                        paddedrulecube(i,j,k).Weight = activ;
                end
            end
        end
    end
    rulecube = paddedrulecube(2:6, 2:6, 2:6);

    %write all rules to the output system
    for i = 1:numel(rulecube)
        fisout = addRule(fisout, [rulecube(i).Antecedent rulecube(i).Consequent 1 1]);
    end
end