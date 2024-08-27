
function [cost, sol]=cost_function(q,model)

    sol=solution(q,model);
    
    eta=model.eta;
    
    cost1=eta*sol.TotalD+(1-eta)*sol.MaxD;
    
    penalty=5;
    
    cost=cost1*(1+penalty*sol.MeanCV);

end