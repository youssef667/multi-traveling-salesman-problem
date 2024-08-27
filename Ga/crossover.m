
function [y1,y2] = crossover(x1,x2)
nvar = numel(x1);
r = round(nvar/5);
if ~(rem(r,2)) == 0
    r = r + 1;
end

d = randperm(nvar-1, r);
[cc,~] = sort(d);
for j = 1:r
    c(j) = cc(j);
end

y1 = zeros(1, length(x1));
y2 = zeros(1, length(x2));

for j = 1:2:r
    y1(c(j):c(j+1)) = x1(c(j):c(j+1));
    y2(c(j):c(j+1)) = x2(c(j):c(j+1));
end

y1_indices = find(~(y1>0));
y2_indices = find(~(y2>0));

j1 = 1;
j2 = 1;

for j = 1:size(x1,2)  %for all the elements in the child array
    if ~ismember(x2(j), y1) 
        y1(y1_indices(j1)) = x2(j);
        j1 = j1 + 1;
    end

    if ~ismember(x1(j), y2)
        y2(y2_indices(j2)) = x1(j);
        j2 = j2 + 1;
    end
end
end

