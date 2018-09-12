%求约束问题时，rank 和任何选择方法都可以 linear 只能和 to
%变异算子 non nor较好
%BlX 随代数增加效果增加 减少优秀个体的交配率
%和 SBX 发挥很差 
function [bestscore,pop,elites] = UltraGA(options,ObjFcn,NVARS,LB,UB,Constr)

%% Initial Paremeters
MaxGen = options.Generations;
N = options.PopulationSize;
Type = options.PopulationType;
ChaosFlag = options.ChaosFlag;

%% Initial Internal Variables
bestscore = Inf;

%% Initial Population
%为空的时候待处理
if isempty(LB)
    VarMin = -Inf;
else
    VarMin = LB;
end
if isempty(UB)
    VarMax = Inf;
else
    VarMax = UB;
end
pop = InitialPop(N,NVARS,Type,LB,UB,ChaosFlag);

%% Build FitnessFcn
if nargin < 6
    f = ObjFcn(pop);
    fmax = max(f);
    FitnessFcn = @(x) -ObjFcn(x) + fmax;
    ConstrState = 0; 
else
%    fmax = max(f);
    FitnessFcn = @(x) - ConstraintHandling(x,ObjFcn,Constr) + 2;
    ConstrState = 1; 
end

%% Scaling Fitness
ScaMethod = options.FitnessScaling{1,1};
ScaPAR = options.FitnessScaling{1,2};
% Default Parameters
if isempty(ScaPAR)
    if strcmpi(ScaMethod,'linear')
        ScaPAR = 2; %Smul = 2
    elseif strcmpi(ScaMethod,'rank')
        ScaPAR = 2; %SP = 2
    elseif strcmpi(ScaMethod,'exp')
        ScaPAR = 0.5;%alpha = 0.5;
    end
end

%% Selection Parameters
SelMethod = options.Selection{1,1};
Rate = options.Selection{1,2};
if numel(options.Selection) == 3
    S =  options.Selection{1,3};
else
    S = 2;
end

%% Crossover Parameters
Split = options.Crossover{1,1};
CroMethod = options.Crossover{1,2};
CovPAR = options.Crossover{1,4};
if strcmpi(CroMethod,'HEU')
    HEUPAR = FitnessFcn;
else
    HEUPAR = [];
end

%% Mutatation Parameters
MutMethod = options.Mutation{1,1};
if numel(options.Mutation) == 2
    if strcmpi(MutMethod,'nor') || strcmpi(MutMethod,'cau')
        MutPAR = 0.1; %delta
    elseif strcmpi(MutMethod,'pol') || strcmpi(MutMethod,'pol1')
        MutPAR = 1; %eta
    elseif strcmpi(MutMethod,'non') 
        MutPAR = 3; %beta 2~5    
    end
else
    MutPAR = options.Mutation{1,3};
end

%% Self - Adaptive
if strcmpi(options.SelfAdaptive{1,1},'off')
    SA_State = 0;
    pc = options.Crossover{1,3};
    pm = options.Mutation{1,2};
else
    SA_State = 1;
    SA_Strategy = options.SelfAdaptive{1,1};
    PcMin = options.SelfAdaptive{1,2}{1,1};
    PcMax = options.SelfAdaptive{1,2}{1,2};
    PmMin = options.SelfAdaptive{1,3}{1,1}; 
    PmMax = options.SelfAdaptive{1,3}{1,2};
    pc = PcMax;
    pm =PmMax;
end
%% Elites
NE = options.Elites; % The number of Elites
if NE ~= 0
    F = FitnessFcn(pop);
    [~,EI] = sort(F,'descend');
    if ConstrState
        [g,h] = Constr(pop);
        if isempty(h)
            c = max(0,g);
        else
            c = [max(0,g),max(0,abs(h) - 1e-4)];
        end
        flag_fes = sum(c,2) == 0;
        if any(flag_fes > 0)
            fespop = pop(flag_fes,:);
            Fe = F(flag_fes); %feasible individuals
            [~,FEI] = sort(Fe,'descend');
            Numfes = numel(FEI);
            if Numfes > NE
                elites = fespop(FEI(1:NE),:);
            else
                elites = fespop;
%                elites(Numfes + 1:NE) = pop(EI(1:NE - Numfes),:);
            end
            bestscore = ObjFcn(elites(1,:));
        else
            elites = [];
        end
        
    else
        elites = pop(EI(1:NE),:);
        bestscore = ObjFcn(elites(1,:));
    end
end

%% Main Loop
cx = [VarMin(1) VarMax(1) VarMin(2) VarMax(2)];
for t = 1:MaxGen
    F = FitnessFcn(pop);
    Fs = FitnessScaling(ScaMethod,F,ScaPAR,t,MaxGen);
    w = Selection(SelMethod,Fs,Rate,S);
    [Fc,idx]= max([F(w(1:2:end)),F(w(2:2:end))],[],2);
    % Self - Adaptive - Pc
    if SA_State
        Fmax = max(F);
        Fave = gamean(F);
        pc = AdaptiveCrossoverMode(SA_Strategy,PcMin,PcMax,Fmax,Fave,Fc);
    end
    [husband,wife,bachelor] = Marriage(pop,w,pc,idx);
    children = Crossover(Split,CroMethod,husband,wife,CovPAR,HEUPAR);
    children = max(children,VarMin);
    children = min(children,VarMax);
    pop = [bachelor;children];
    % Self - Adaptive - Pc
    if SA_State
        Fm = FitnessFcn(pop);
        Fm_max = max(F);
        Fm_ave = gamean(F);
        pm = AdaptiveMutationMode(SA_Strategy,PmMin,PmMax,Fm_max,Fm_ave,Fm);
    end
    pop= Mutation(Type,MutMethod,pop,pm,VarMin,VarMax,MutPAR,t,MaxGen);
    pop = max(pop,VarMin);
    pop = min(pop,VarMax);
    
    F = FitnessFcn(pop);
    if NE == 0
        [~,EI] = max(F);
        gbestscore = ObjFcn(pop(EI,:));
        if gbestscore <= bestscore
            bestscore = gbestscore;
        end
    else
        if ConstrState
            [g,h] = Constr(pop);
            if isempty(h)
                c = max(0,g);
            else
                c = [max(0,g),max(0,abs(h) - 1e-4)];
            end
            flag_fes = sum(c,2) == 0;
            if any(flag_fes > 0)
                fespop = pop(flag_fes,:);
                Fe = F(flag_fes); %feasible individuals
                [~,EI] = sort(Fe,'descend');
                gbestscore = ObjFcn(fespop(EI(1),:));
                if gbestscore < bestscore
                    bestscore = gbestscore;
                    num_elites = size(elites,1);
                    if num_elites < NE
                        elites(num_elites + 1,:) = fespop(EI(1),:);
                    else
                        elites(2:end,:) = elites(1:end -1,:);
                        elites(1,:) = fespop(EI(1),:);
                    end
                elseif gbestscore > bestscore
                    [~,EI] = sort(F,'descend');
                    pop = pop(EI,:);
                    num_elites = size(elites,1);
                    pop(end - num_elites + 1:end,:) = elites;
                end
            end
        else
            [~,EI] = sort(F,'descend');
            gbestscore = ObjFcn(pop(EI(1),:));
            if gbestscore < bestscore
                bestscore = gbestscore;
                elites(2:end,:) = elites(1:end -1,:);
                elites(1,:) = pop(EI(1),:);
            elseif gbestscore > bestscore
                pop = pop(EI,:);
                pop(end - NE + 1:end,:) = elites;
            end
        end
    end
    if strcmpi(MutMethod,'nor') || strcmpi(MutMethod,'cau')
        %MutPAR = MutPAR/1.05;
        MutPAR = 0.1;
        shrink = 1 - 1e-16;
        MutPAR = MutPAR - shrink * MutPAR * t/MaxGen;
    end

%     %% Plot Section
%     
%     figure(1)
%     set (gcf,'Position',[50,250,1000,380], 'color','w')    
%     z = ObjFcn(pop);
%     hold off
%     plottestfunc('griew',cx)
%     hold on
%     e = ObjFcn(elites);
%     plot3(elites(:,1),elites(:,2),e,'rh')
%     plot3(pop(:,1),pop(:,2),z,'bo')
%     title({' Genetic Algorithm '...
%         ,'Performance of GA ( o : each individual)'},'color','b')
%     pause(0.01)
end

disp('The best individual is:')
%disp(num2str(elites(1,:),'%.4e '))
disp(elites(1,:))
disp('The optimal value is:')
%disp(num2str(bestscore,'%.4e\n'))
disp(bestscore)