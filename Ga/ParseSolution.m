%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP108
% Project Title: Solving Vehicle Routing Problem using Simulated Annealing
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function sol=ParseSolution(q,model)

    I=model.I;
    J=model.J;
    d=model.d;
    d0=model.d0;
    r=model.r;
    c=model.c;
    
    DelPos=find(q>I);
    %q
    %I
    %q>I
    %find(q>I)
    %DelPos
    From=[0 DelPos]+1;
    %From
    To=[DelPos I+J]-1;
    %To
    
    %for i=1:J
        %abs(From(i) - To(i))
     %   if abs(From(i) - To(i))> 5
      %      From(i) + 1;
       % end
    %From(i)
    %end
    
    L=cell(J,1);
    D=zeros(1,J);
    UC=zeros(1,J);
    for j=1:J
        L{j}=q(From(j):To(j));
        %qq = q(From(j):To(j))
        %L
        if ~isempty(L{j})
            %L{j}(1);
            D(j)=d0(L{j}(1));
            %L{j}(1)
            %D
            %nn = numel(L{j})
            for k=1:numel(L{j})-1
                D(j)=D(j)+d(L{j}(k),L{j}(k+1));
            end
            
            D(j)=D(j)+d0(L{j}(end));
            
            
            UC(j)=sum(r(L{j}));
            %a = L{j}
            %r
            %b = r(L{j})
            %cc = UC
        end
    end
    
    CV=max(UC./c-1,0);
    %(UC./c-1)
    MeanCV=mean(CV);
    
    sol.L=L;
    sol.D=D;
    sol.MaxD=max(D);
    sol.TotalD=sum(D);
    sol.UC=UC;
    sol.CV=CV;
    sol.MeanCV=MeanCV;
    sol.IsFeasible=(MeanCV==0);
    %sol
end