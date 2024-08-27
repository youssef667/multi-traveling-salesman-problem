clc;
clear;
close all;

%% Problem Definition

model=select_model();        % Select Model of the Problem
model.eta=0.1;
Cost=@(q) cost_function(q,model);        % Cost Function
I=model.I;
J=model.J;

%% GA Parameters

Generations = 1000;  %maximum number of generations to be tested
Pop_size = 100;  %the population size
Elite_ratio = 0.1;  %percentage of elitism
Crossover_ratio = 0.75; %percentage of cross over processes
Mutation_ratio = 1 - Elite_ratio - Crossover_ratio; %the rest of mutation ratio
%[r,c] = crossover_point(I+J-1);
%% Initialization

% Create Initial Solution
x.Position = zeros(Pop_size,I+J-1);
xnew.Position = zeros(Pop_size,I+J-1);

for i = 1:Pop_size
   x.Position(i,:) = random_solution(model);
   [x.Cost(i,1), x.Sol(i,1)]=  Cost(x.Position(i,:));
   
   if ~(x.Sol(i).IsFeasible)
        while ~(x.Sol(i).IsFeasible)
            x.Position(i,:) = random_solution(model);
            [x.Cost(i), x.Sol(i)]=  Cost(x.Position(i,:));
        end
    end
end

x_initial = x.Position;
[~, member_index] = sort(x.Cost);

x_Cost_intial = x.Cost; 

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(Pop_size,Generations);

%Elite Cost
EliteCost = zeros(Generations,1);

%% GA Main Loop
for i= 1:Generations
    %Elite
    [~, member_index] = sort(x.Cost);
    Num_elite = round(Elite_ratio*Pop_size); 
    for ii = 1:Num_elite  
        xnew.Position(ii,:) = x.Position(member_index(ii),:);  %get the best members in prev generatio
        xnew.Cost(ii,1) = x.Cost(member_index(ii),1);  %save elites cost
        xnew.Sol(ii,1) = x.Sol(member_index(ii),1);
    end
    %% cross over

    Num_CO_children = round(Crossover_ratio*Pop_size);
for ii = Num_elite+1 : 2: Num_elite+Num_CO_children

    parent_1_num = randi([1,Num_elite]); %randomly select elite 
    parent_1 = x.Position(member_index(parent_1_num),:);  
        
    parent_2_num = randi([1,Pop_size]); %randomly select a member 
    parent_2 = x.Position(parent_2_num,:); 
    
    [child_1,child_2] = crossover(parent_1,parent_2);
    
    xnew.Position(ii,:) = child_1;  %save child 1 to the generation
    xnew.Position(ii+1,:) = child_2;  %save child 2 to the generation
end
%% mutation
Num_Mutants = Pop_size - Num_elite - Num_CO_children;  %rest of population are mutants
j = 0;
    for ii = Num_elite + Num_CO_children + 1 : Pop_size  
        xnew.Position(ii,:) = mutation(x.Position(member_index(end - j),:));  %select the least elements 
        j = j + 1;
    end
    
%% update cost

 for j = Num_elite+1:Pop_size
  [xnew.Cost(j,1),xnew.Sol(j,1)] = Cost(xnew.Position(j,:));
 end
 x = xnew;
 
 %% Plot
 BestSol = x;
 BestCost(:,i) = x.Cost;
 EliteCost(i) = x.Cost(1);

 clear child_1 child_2 member_index j
 clear Num_CO_children Num_elite Num_Mutants parent_1 parent_2;
 clear parent_1_num parent_2_num ;
 clear xnew.Position xnew.Cost
 
 disp(['Generation ' num2str(i) ': Best Cost = ' num2str(EliteCost(i)) ]);

%% Plot Solution
 figure(1);
 plot_solution(BestSol.Sol(1),model);
 pause(0.01);
 end
%% Results
figure;
plot(EliteCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;




