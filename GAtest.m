clear;
% CostFunction = @(x) 1./Sphere(x);
% VarMin = [-1 -1];
% VarMax = [1 1];
% CostFunction = @(x) x.^2;
% VarMin = [-1];
% VarMax = [1];
%%
%The global minima:
%x* =  (0.20169, 0.150011, 0.476874, 0.275332, 0.311652, 0.6573),
%f(x*) = - 3.32237.
% CostFunction = @(x) hart6(x);
% VarMin = [-1 -1 -1 -1 -1 -1];
% VarMax = [1 1 1 1 1 1];
%%
% Search domain: ?5 ≤ xi ≤ 10, i = 1, 2, . . . , n.
% Number of local minima: several local minima.
% The global minima: x* =  (1, …, 1), f(x*) = 0.
CostFunction = @(x) rosen(x);
VarMin = [-5 -5 ];
VarMax = [10 10];

%%
% CostFunction = @(x) griew(x);
% VarMin = [-600 -600 ];
% VarMax = [600 600];
%Number of local minima: several local minima.
%The global minima: x* =  (0, …, 0), f(x*) = 0.
%%
% CostFunction = @(x) 1./(hump(x) + 1);
% VarMin = [-5 -5];
% VarMax = [5 5];

%Parameters
rand('state',sum(100*clock)*rand(1));
Encoding = 'values';
ChaosFlag = 1;%概率密度服从两头多、中问少的切比雪夫分布
N = 40;
G = size(VarMax,2);
MaxGeneration = 2000;
PerMut = 0.1;
eta = 2;
T = 0.1;

x1 = rand(N,1);

%compare with toolbox
%options = optimoptions('ga','MaxGenerations',5000,'UseVectorized',true,'FunctionTolerance',1e-16,'PlotFcn',@gaplotbestf);[x,fval] = ga(CostFunction,6,[],[],[],[],VarMin,VarMax,[],options);

%Initial
Pop = InitialPop(N,G,Encoding,VarMin,VarMax,ChaosFlag);

sigma = 0.1*(VarMax - VarMin);
sigma1 = sigma;
FitnessFunc = @(x)  -0.1 *CostFunction(x) + 10000;
F = FitnessFunc(Pop);
[Fsorted,idx] = sort(F,'descend');
BestVal = Inf;
MaxFitness = -Inf;
Elitism = Pop(idx(1),:);

tic;
for t = 1:MaxGeneration
    
    F_ave = mean(F);
    %% Selection
    %W = GASelection(F(1:N));% Efficient: Roulette Wheel
    %W = GASelection(F(1:N),2);% Efficient: 50% Truncation
    W = GASelection(F(1:N),3);% Tournament Size S=2
    %W = GASelection(F(1:N),3,4);% Tournament Size S=4
    WinnerMale = Pop(W(1:2:end),:);
    WinnerFemale = Pop(W(2:2:end),:);
    F_c = max(FitnessFunc(WinnerMale),FitnessFunc(WinnerFemale),[],2);
    
    [Husband,Wife,Bachelor,Couple] = Marriage(Pop,W,Pc);
    
    %% Crossover
    %Pop2 = GACrossoverED(Pop,W,'uniform','swap');
    %Pop2 = GACrossoverED(Pop,W,'onepoint','swap');
    %Pop2 = GACrossoverED(Pop,W,'twopoint','swap');
    %[~,~,Bachelor,Children] = GACrossover(Pop,W,'all','BLX',0.8,0.5);
    %Pop2 = GACrossoverED(Pop,W,'all','BLX','rand');
    Children = GACrossover('all','SBX',Husband,Wife,Couple,0.9,0.5,eta);
    %Pop2 = GACrossoverED(Pop,W,'all','SBX1',0.5,VarMin,VarMax);
    Children = max(Children,VarMin);
    Children = min(Children,VarMax);
    %% Mutation
    %Children = GAMutation(Children,PerMut,4,sigma1,VarMin,VarMax);
    Children = GAMutation(Children,PerMut,7,VarMin,VarMax,0.1);
    %Pop3 = GAMutation(Pop2,PerMut,9,VarMin,VarMax);(worse)
    %Children = GAMutation(Children,PerMut,5,VarMin,VarMax,3,i,MaxGeneration);
    Pop = [Bachelor;Children];

        %         ElitismChildren = ones(5,1)*Elitism;
        %         ElitismChildren = GAMutation(ElitismChildren,1,4,sigma1,VarMin,VarMax);
        %         ElitismF = CostFunction(ElitismChildren);
        %         ElitismChildrenBest = ElitismChildren(ElitismF < BestVal,:);
        %         if size(ElitismChildrenBest,1) == 0
        %             ElitismChildrenBest = ElitismChildren(1:2,:);
        %         end
        %         num = size(ElitismChildrenBest,1);
        %         Pop(end - num + 1:end,:) = ElitismChildrenBest;
        %         ChaosSeed = (Elitism - VarMin)./(VarMax - VarMin);
        %         for j = 1:100
        %             ChaosSeed = LogisticRand(size(ChaosSeed),1,ChaosSeed);
        %             NewElitism = (VarMax - VarMin).*ChaosSeed + VarMin;
        %             NewElitismF = CostFunction(NewElitism);
        %             if NewElitismF < BestVal
        %                 BestVal = NewElitismF;
        %                 Elitism = NewElitism;
        %                 Pop(end,:) = Elitism;
        %                 disp('Chaos...');
        %                 break;
        %             end
        %         end
    end
    
    MaxFitnessALL(t) = MaxFitness;
    T=0.99*T;
    sigma = 0.99.*sigma;
    
end
toc;
fig1 = plot(MeanFitness);
set(fig1,'LineWidth',1.5);
hold on
fig2 = plot(MaxFitnessALL);
set(fig2,'LineWidth',1.5);
%plot(ElitismVal)
legend('平均适应度','最大适应度','Location','southeast');

