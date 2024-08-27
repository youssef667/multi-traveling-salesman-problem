clc;
clear;
close all;

%% Problem Definition

model=SelectModel();        % Select Model of the Problem
model.eta=0.1;
CostFunction=@(q) MyCost(q,model);       % Cost Function
I=model.I;
J=model.J;

%% GA Parameters
%some parameters in omer code
GA.Num_Generations = 1000;  %maximum number of generations to be tested
GA.Pop_size = 600;  %the population size
GA.Elite_ratio = 0.1;  %percentage of elitism
GA.CrossOver_ratio = 0.75; %percentage of cross over processes
GA.Mutation_ratio = 1 - GA.Elite_ratio - GA.CrossOver_ratio; %the rest of mutation ratio
%[r,c] = crossover_point(I+J-1);
%crossover_point = round((I+J-1)/5);
%% Initialization
% Create Initial Solution
x.Position = zeros(GA.Pop_size,I+J-1);
xnew.Position = zeros(GA.Pop_size,I+J-1);

%x.Position = Initialization(GA.Pop_size,model,I,J);

for i = 1:GA.Pop_size
   x.Position(i,:) = CreateRandomSolution(model);
   [x.Cost(i,1), x.Sol(i,1)]=  CostFunction(x.Position(i,:));
   
   if ~(x.Sol(i).IsFeasible)
        while ~(x.Sol(i).IsFeasible)
            x.Position(i,:) = CreateRandomSolution(model);
            [x.Cost(i), x.Sol(i)]=  CostFunction(x.Position(i,:));
        end
    end
end

x_initial = x.Position;
%{
%calculate cost for intial population
for i = 1:GA.Pop_size
   [x.Cost(i,1), x.Sol(i,1)]=  CostFunction(x.Position(i,:));
end
%}
[~, member_index] = sort(x.Cost);

x_Cost_intial = x.Cost; 

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(GA.Pop_size,GA.Num_Generations);

%Elite Cost
EliteCost = zeros(GA.Num_Generations,1);

%% GA Main Loop
for i= 1:GA.Num_Generations
    %Elite
    [~, member_index] = sort(x.Cost);
    Num_elite = round(GA.Elite_ratio*GA.Pop_size); 
    for ii = 1:Num_elite  %for the required number of elites
        xnew.Position(ii,:) = x.Position(member_index(ii),:);  %get the best members in prev generatio
        xnew.Cost(ii,1) = x.Cost(member_index(ii),1);  %save elites cost
        xnew.Sol(ii,1) = x.Sol(member_index(ii),1);
    end
    %% cross over

    Num_CO_children = round(GA.CrossOver_ratio*GA.Pop_size);
    %y = 1;
for ii = Num_elite+1 : 2: Num_elite+Num_CO_children
    %if y == 1
        parent_1_num = randi([1,Num_elite]); %select a random integer within range of elite members count
     %   y = 2;
    %elseif y == 2
      %  parent_1_num = randi([1,GA.Pop_size]);
       % y = 1;
    %end
    parent_1 = x.Position(member_index(parent_1_num),:);  %read the info of this parent
        
    parent_2_num = randi([1,GA.Pop_size]); %randomly select a member from the generation
    parent_2 = x.Position(parent_2_num,:);  %read the info of this parent
    
    [child_1,child_2] = multi_crossover(parent_1,parent_2);
    
    %[child_1_Cost,child_1_Sol] = CostFunction(child_1);
    %[child_2_Cost,child_2_Sol] = CostFunction(child_2);
    %{
    if ~(child_1_Sol.IsFeasible && child_2_Sol.IsFeasible)
        while ~(child_1_Sol.IsFeasible && child_2_Sol.IsFeasible)
            [child_1,child_2] = Crossover_Ordered_Operator(parent_1,parent_2);
            [child_1_Cost,child_1_Sol] = CostFunction(child_1);
            [child_2_Cost,child_2_Sol] = CostFunction(child_2);
        end
    end
    %}
%{
    child_1 = [];
    child_2 = [];
    child_1 = [child_1 parent_1(1:crossover_point)];
    child_2 = [child_2 parent_2(1:crossover_point)];
    for j = 1:size(parent_1,2)  %for all the elements in the child array
        if ~ismember(parent_2(j), child_1) 
            child_1 = [child_1 parent_2(j)];
        end
        
        if ~ismember(parent_1(j), child_2)
            child_2 = [child_2 parent_1(j)];
        end
    end
    %}
    xnew.Position(ii,:) = child_1;  %save child 1 to the generation
    xnew.Position(ii+1,:) = child_2;  %save child 2 to the generation
end
%% mutation
Num_Mutants = GA.Pop_size - Num_elite - Num_CO_children;  %the rest of population are mutants
j = 0;
    for ii = Num_elite + Num_CO_children + 1 : GA.Pop_size  %for the rest of population size members
        xnew.Position(ii,:) = CreateNeighbor(x.Position(member_index(end - j),:),I,J);  %select the elements from the end of list
        j = j + 1;
    end
    
%% update cost

 for j = Num_elite+1:GA.Pop_size
  [xnew.Cost(j,1),xnew.Sol(j,1)] = CostFunction(xnew.Position(j,:));
 end
 x = xnew;
 %x.Position = xnew.Position;
 %x.Sol = xnew.Sol;
 %x.Cost = xnew.Cost;
 
 %% Plot
 BestSol = x;
 BestCost(:,i) = x.Cost;
 EliteCost(i) = x.Cost(1);

 clear child_1 child_2 member_index j
 %clear child_1_Sol child_1_Cost child_2_Sol child_2_Cost
 clear Num_CO_children Num_elite Num_Mutants parent_1 parent_2;
 clear parent_1_num parent_2_num ;
 clear xnew.Position xnew.Cost
 
 disp(['Generation ' num2str(i) ': Best Cost = ' num2str(EliteCost(i)) ]);



% Plot Solution
 figure(1);
 PlotSolution(BestSol.Sol(1),model);
 pause(0.01);
 end
%% Results
figure;
plot(EliteCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;




