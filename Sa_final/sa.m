clc,clear,close all;

%% Problem Definition

model=select_model();        % Select The Model 

model.eta=0.1;          %Model eta (for cost function)

Cost=@(q) cost_function(q,model);       % Cost Function
I=model.I;
J=model.J;

%% SA Parameters

MaxIt=1000;     % Maximum Number of Iterations

MaxIt2=100;      % Maximum Number of Inner Iterations

T0=1000;         % Initial Temperature

alpha=0.98;     % Temperature Damping Rate


%% Initialization

% Create Initial Solution
x.Position=random_solution(model);
[x.Cost, x.Sol]=Cost(x.Position);

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Set Initial Temperature
T=T0;

%% SA Main Loop

for it=1:MaxIt
    for it2=1:MaxIt2
        
        % Create Neighbor
        xnew.Position=mutation(x.Position);
        [xnew.Cost, xnew.Sol]=Cost(xnew.Position);
        
        if xnew.Cost<=x.Cost
            % xnew is better, so it is accepted
            x=xnew;
            
        else
            % xnew is not better, so it is accepted conditionally
            delta=xnew.Cost-x.Cost;
            p=exp(-delta/T);
            
            if rand<=p
                x=xnew;
            end
            
        end
        
        % Update Best Solution
        if (x.Cost<=BestSol.Cost && x.Sol.IsFeasible)
            BestSol=x;
        end
        
    end
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;

    
    % Feasible Solution
    if BestSol.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG='';
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    
    % Update Temperature
    T=(alpha^(it))*T0;

    % Plot Solution
    figure(1);
    plot_solution(BestSol.Sol,model);
    pause(0.01);
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

