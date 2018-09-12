clear
rand('state',sum(50*clock)*rand(1));
%%
% tf = 'eggholder';
% [CostFunction,VarMin,VarMax,Dir] = testfunc(tf,2);
%'griew'
%Parameters
MaxGen = 500;
eta = 2;
%% Self - Adaptive
%Strategy = 'IAGA1';
%Strategy = 'CAGA';
Strategy = 'SAGA';
PcMin = 0.7; PcMax = 0.9;
PmMin = 0.001; PmMax = 0.1;
%% Initial Population
VarMax = [1.5 2.5];
VarMin = [-1.5 -0.5];
Dir = 'min';
Type = 'rc';
ChaosFlag = 0;
N = 100;
G = size(VarMax,2);
pop = InitialPop(N,G,Type,VarMin,VarMax,ChaosFlag);

%compare with toolbox
%'PlotFcn',@gaplotbestf
disp('----GA toolbox----')
options = optimoptions('ga','ConstraintTolerance',1e-32,'MaxGenerations',MaxGen,'UseVectorized',true,'FunctionTolerance',1e-32,'MaxStallGenerations',Inf,'NonlinearConstraintAlgorithm','penalty');tic;[x,fval,EXITFLAG,OUTPUT,POPULATION,SCORES]= ga(@tf4c_RosenbrockObj,G,[],[],[],[],VarMin,VarMax,@tf4c_RosenbrockConstr,options);
toc;
disp('The best individual is:')
disp(num2str(x,'%.4e '))
disp('The optimal value is:')
disp(num2str(fval,'%.4e\n'))
% disp('----PSO toolbox----')
% %'ConstrBoundary','reflect',
% psooptions = psooptimset('Generations',MaxGen,'UseVectorized','on','TolFun',1e-32,'TolCon',1e-32,'StallGenLimit',Inf);tic;[x,fval] = pso(@tf4c_RosenbrockObj,G,[],[],[],[],VarMin,VarMax,@tf4c_RosenbrockConstr,psooptions);
% toc;
% disp('The best individual is:')
% disp(num2str(x,'%.4e '))
% disp('The optimal value is:')
% disp(num2str(fval,'%.4e\n'))
delta = 0.1;
% cost = CostFunction(pop);
if  strcmpi(Dir,'max')
    bestval = -Inf;
%    b = min(cost);
elseif  strcmpi(Dir,'min')
    bestval = Inf;
%    b = max(cost);
end

cx = [VarMin(1) VarMax(1) VarMin(2) VarMax(2)];
rand('state',sum(100*clock)*rand(1));
bestcost = zeros(1,MaxGen);
meancost = zeros(1,MaxGen);
elitism = zeros(1,G);
disp('----Wu Xiaoriu----')
tic;
for g = 1:MaxGen
    %% Evaluation
    cost = ConstraintHandling(pop,@tf4c_RosenbrockObj,@tf4c_RosenbrockConstr);
    %[f,fmin,fmax,fave] = FitnessScaling('linear',Dir,cost - 2,2);
    %[f,fmin,fmax,fave] = FitnessScaling('linear',Dir,cost - b,2);
    [f,fmin,fmax,fave] = FitnessScaling('rank',Dir,cost,2);
    %[f,fmin,fmax,fave] = FitnessScaling('exp',Dir,cost,0.05);
    %[f,fmin,fmax,fave] = FitnessScaling('sigma',Dir,cost,2);
    %% Selection
    w = Selection('rw',f);% Efficient: Roulette Wheel
    % w = Selection('tr',f);% Efficient: 50% Truncation
    %w = Selection('su',f);% Stochastic Universal
    %w = Selection('to',f);% Tournament Size S=2
    % w = Selection('to',f,4);% Tournament Size S=4
    
    %% Self - Adaptive - Pc
    winnermale = pop(w(1:2:end),:);
    winnerfemale = pop(w(2:2:end),:);
    [fc,idx]= max([f(w(1:2:end)),f(w(2:2:end))],[],2);
    pc = AdaptiveCrossoverMode(Strategy,PcMin,PcMax,fmax,fave,fc);
    [husband,wife,bachelor] = Marriage(winnermale,winnerfemale,pc,idx);
    
    %% Crossover
    %alpha = 0.5 suggested
    %children = Crossover('all','BLX',husband,wife,0.5);
    %children = Crossover('all','Boundary',husband,wife);
    %eta = 1 suggested 
    %children = Crossover('all','SBX',husband,wife,1);
    %children = Crossover('all','DIS',husband,wife);
    %children = Crossover('all','INT',husband,wife);
    %children = Crossover('all','LIN',husband,wife);
    children = Crossover('all','EIX',husband,wife);
    %children = Crossover('all','HEU',husband,wife,CostFunction);
    %children = Crossover('all','HEU',husband,wife,CostFunction,VarMin,VarMax);
    children = max(children,VarMin);
    children = min(children,VarMax);
    pop = [bachelor;children];
    
    %% Self - Adaptive - Pm
    costm = ConstraintHandling(pop,@tf4c_RosenbrockObj,@tf4c_RosenbrockConstr);
    %[fm,~,fm_max,fm_ave] = FitnessScaling('linear',Dir,costm,2);
    %cost = CostFunction(pop);
    %[fm,~,fm_max,fm_ave] = FitnessScaling('linear',Dir,cost - b,2);
    %[fm,~,fm_max,fm_ave] = FitnessScaling('linear',Dir,cost - 2,2);
    [fm,~,fm_max,fm_ave] = FitnessScaling('exp',Dir,cost,0.05);
    %[fm,~,fm_max,fm_ave] = FitnessScaling('sigma',Dir,cost,2);
    pm = AdaptiveMutationMode(Strategy,PmMin,PmMax,fm_max,fm_ave,fm);
    
    %% Mutation
    %pop= Mutation(Type,'uni',pop,pm,VarMin,VarMax);
    %pop= Mutation(Type,'bou',pop,pm,VarMin,VarMax);
    %pop= Mutation(Type,'non',pop,pm,VarMin,VarMax,3,g,MaxGen);
    pop= Mutation(Type,'nor',pop,pm,VarMin,VarMax,delta);
    %pop= Mutation(Type,'cau',pop,pm,VarMin,VarMax,delta);
    %pop= Mutation(Type,'pol',pop,pm,VarMin,VarMax,11);
    %pop= Mutation(Type,'pol1',pop,pm,VarMin,VarMax,11);
    %pop= Mutation(Type,'chaos',pop,pm,VarMin,VarMax);
    pop = max(pop,VarMin);
    pop = min(pop,VarMax);
    %cost = CostFunction(pop);
%     costave = mean(cost);
%     if  strcmpi(Dir,'max')
%         [popbest,I] = max(cost);
%         if popbest >= bestval
%             bestval = popbest(1);
%             elitism = pop(I,:);
%         else
%             pop(end,:) = elitism;
%         end
%     elseif  strcmpi(Dir,'min')
%         [popbest,I] = min(cost);
%         if popbest <= bestval
%             bestval = popbest(1);
%             elitism = pop(I,:);
%         else
%             pop(end,:) = elitism;
%         end
%     end
        cost = ConstraintHandling(pop,@tf4c_RosenbrockObj,@tf4c_RosenbrockConstr);
        [~,I] = min(cost);
        y = tf4c_RosenbrockObj(pop);
        popbest = tf4c_RosenbrockObj(pop(I,:));
        if popbest <= bestval
            bestval = popbest;
            elitism = pop(I,:);
        else
            pop(end,:) = elitism;
        end    
%     bestcost(g) = popbest;
%     meancost(g) = costave;
    delta = delta./(1.049);% reducing the standard devation value
    %delta = 1 - 0.9^((1 - g/MaxGen).^5);
    %delta = 0.1 - 0.1*g/MaxGen;
    %% Plot Section
%         figure(1)
%         set (gcf,'Position',[50,250,1000,380], 'color','w')
% %       subplot(1,2,1)
% 
% %        cost = tf4c_RosenbrockObj(pop);
%         hold off
%         plottestfunc('rosen',cx)
%         hold on
%         plot3(elitism(1,1),elitism(1,2),bestval,'rh')
%         plot3(pop(:,1),pop(:,2),y,'bo')
%         xlim([-1.5 1.5])
%         ylim([-0.5 2.5])
%         zlim([0 500])
%         title({' Genetic Algorithm '...
%             ,'Performance of GA ( o : each individual)'},'color','b')
% % %     
%         subplot(1,2,2)
%         fig1 = plot(meancost);
%         set(fig1,'LineWidth',1.5);
%         hold on
%         fig2 = plot(bestcost);
%         set(fig2,'LineWidth',1);
%         set(fig2,'Marker','o');
%         xlabel('Gen');
%         ylabel('Cost');
%         legend('MeanCost','BestCost','Location','best');
        pause(0.00001)
    
    
end
toc;

% figure(2)
% % set (gcf,'Position',[50,250,800,300], 'color','w')
% % subplot(1,2,1)
% % plottestfunc(tf,cx)
% % hold on
% % plot3(pop(:,1),pop(:,2),cost,'ro')
% % plot3(elitism(1,1),elitism(1,2),bestval,'b*')
% % title({' Genetic Algorithm '...
% %     ,'Performance of GA ( o : each individual)'},'color','b')
% % 
% % subplot(1,2,2)
% fig1 = plot(meancost);
% set(fig1,'LineWidth',1.5);
% hold on
% fig2 = plot(bestcost);
% set(fig2,'LineWidth',1);
% set(fig2,'Marker','o');
% xlabel('Gen');
% ylabel('Cost');
% legend('MeanCost','BestCost','Location','best');
% 
% disp('The best individual is:')
% disp(num2str(elitism,'%.4e '))
% disp('The optimal value is:')
% disp(num2str(bestval,'%.4e\n'))


