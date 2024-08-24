function [r,c] = crossover_point(x)
    %nvar = numel(x);
    r = round(x/5);
    if ~(rem(r,2)) == 0
        r = r + 1;
    end

    d = randperm(x-1, r);
    [cc,~] = sort(d);
    for j = 1:r
        c(j) = cc(j);
    end
end