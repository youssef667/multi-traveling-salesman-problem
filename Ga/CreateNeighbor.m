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

function qnew=CreateNeighbor(q,I,J)

    m=randi([1 3]);
    %m = 1;
    switch m
        case 1
            % Do Swap
            qnew=Swap(q,I,J);
            
        case 2
            % Do Reversion
            qnew=Reversion(q);
            
        case 3
            % Do Insertion
            qnew=Insertion(q);
    end

end

function qnew=Swap(q,I,J)
%{
    r = round((I+J-1)/5);
    if rem(r,2)
        r = r + 1;
    end
%}
    n=numel(q);
    qnew=q;
    i=randsample(n,2);
    %for j=1:2:(r*2)
        i1=i(1);
        i2=i(2);
        qnew([i1 i2])=q([i2 i1]);
    %end
    
    
    
    
    
end

function qnew=Reversion(q)

    n=numel(q);
    
    i=randsample(n,2);
    i1=min(i(1),i(2));
    i2=max(i(1),i(2));
    
    qnew=q;
    qnew(i1:i2)=q(i2:-1:i1);

end

function qnew=Insertion(q)

    n=numel(q);
    
    i=randsample(n,2);
    i1=i(1);
    i2=i(2);
    
    if i1<i2
        qnew=[q(1:i1-1) q(i1+1:i2) q(i1) q(i2+1:end)];
    else
        qnew=[q(1:i2) q(i1) q(i2+1:i1-1) q(i1+1:end)];
    end

end

