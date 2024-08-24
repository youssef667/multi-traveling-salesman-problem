
function [z, sol]=cost_function(q,model)

    sol=solution(q,model);
    
    eta=model.eta;
    
    z1=eta*sol.TotalD+(1-eta)*sol.MaxD;
    
    penalty=5;
    
    z=z1*(1+penalty*sol.MeanCV);

end