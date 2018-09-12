tf = 'drop';
NVARS = 20;
MaxGen = 1000;
% [ObjFcn,LB,UB,~] = testfunc(tf,NVARS);
% Constr = [];
% ObjFcn = @tf4c_RosenbrockObj;
% Constr = @tf4c_RosenbrockConstr;
% VarMax = [1.5 2.5];
% VarMin = [-1.5 -0.5];
%ObjFcn = @tf4f_PrG1Obj;
%Constr = @tf4c_PrG1Constr;
%VarMax = [ones(1,9),100,100,100,1];
%VarMin = zeros(1,13);
% ObjFcn = @tf4f_PrG2Obj;
% Constr = @tf4c_PrG2Constr;
% VarMax = ones(1,20)*10;
% VarMin = zeros(1,20);
ObjFcn = @tf4f_PrG3Obj;
Constr = @tf4c_PrG3Constr;
VarMax = ones(1,NVARS);
VarMin = zeros(1,NVARS);
UB = VarMax;
LB = VarMin;
disp('----GA toolbox----')
options = optimoptions('ga','MaxGenerations',MaxGen,'UseVectorized',true ...
    ,'FunctionTolerance',1e-32,'FunctionTolerance',1e-32,'MaxStallGenerations' ...
    ,Inf,'NonlinearConstraintAlgorithm','penalty');
tic;
[x,fval,EXITFLAG,OUTPUT,POPULATION,SCORES]= ga(ObjFcn,NVARS,[],[],[],[] ...
    ,VarMin,VarMax,Constr,options);
toc;
disp('The best individual is:')
disp(num2str(x,'%.4e '))
disp('The optimal value is:')
disp(num2str(fval,'%.4e\n'))
rand('state',sum(100*clock)*rand(1));
disp('----WXR----')
UGAoptions = gaoptions('Generations',MaxGen,'FitnessScaling',{'rank' 2},'elites',10 ...
,'Mutation',{'nor' 0.0001 30},'SelfAdaptive',{'SAGA' {0.4 1} {0.001 0.1}} ...
,'Selection',{'rw' 2},'PopulationSize',200,'Crossover',{'ALL' 'EIX' 0.9 {0.5}});
tic;
[bestscore,pop,elites] = UltraGA(UGAoptions,ObjFcn,NVARS,LB,UB,Constr);
toc;

