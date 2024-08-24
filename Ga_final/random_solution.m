
function q=random_solution(model)

    I=model.I;
    J=model.J;
    
    q=randperm(I+J-1);
end