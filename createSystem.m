function fis = createSystem()
    %setup the system
    fis = mamfis(NumInputs = 3, NumInputMFs = 5, NumOutputs = 1, NumOutputMFs = 4, AddRules = "none");
    fis.AndMethod = "prod";
    
    %setup the input variables
    fis.Inputs(1).name = "qPA";
    fis.Inputs(1).range = [-10 10];
    
    fis.Inputs(2).name = "pulso";
    fis.Inputs(2).range = [0 200];
    
    fis.Inputs(3).name = "resp";
    fis.Inputs(3).range = [0 22];
    
    %setup the input membership functions
    mfNames = ["baixissimo" "muito baixo" "baixo" "medio" "alto" "muito alto" "altissimo"];
    
    for i = 1:3 %for all input variables
        
        r = fis.Inputs(i).range(2) - fis.Inputs(i).range(1); %domain of the input variable
        base = 2*(r/(length(mfNames)+1)); %base of each triangular mf
        x = fis.Inputs(i).range(1) + base/2 : base/2 : fis.Inputs(i).range(2)- base/2; %centers of the triangular mfs
    
        for j = 1:length(mfNames) %for all membership functions
            fis.Inputs(i).MembershipFunctions(j).Type = "trimf";
            fis.Inputs(i).MembershipFunctions(j).Parameters = [x(j)-base/2 x(j) x(j)+base/2];
            fis.Inputs(i).MembershipFunctions(j).Name = mfNames(j);
        end
    end
    
    %setup the output
    outputNames = ["critico" "instavel" "potencialmente estavel" "estavel"];
    fis.Outputs(1).name = "estado";
    fis.Outputs(1).range = [0 100];
    
    r = fis.Outputs(1).range(2) - fis.Outputs(1).range(1); %domain of the output variable
    base = 2*(r/(4+1)); %base of each triangular mf
    x = fis.Outputs(1).range(1) + base/2 : base/2 : fis.Outputs(1).range(2)- base/2; %centers of the triangular mfs
    
    for j = 1:4 %for all membership functions
        fis.Outputs(1).MembershipFunctions(j).Type = "trimf";
        fis.Outputs(1).MembershipFunctions(j).Parameters = [x(j)-base/2 x(j) x(j)+base/2];
        fis.Outputs(1).MembershipFunctions(j).Name = outputNames(j);
    end
end