function Pm = AdaptiveMutationMode(Strategy,Pm_min,Pm_max,varargin)

if strcmpi(Strategy,'IAGA1')
    F_max = varargin{1};
    F_ave = varargin{2};
    F_m = varargin{3};
    Pm = SA_Mutation_IAGA1(Pm_min,Pm_max,F_max,F_ave,F_m);
% elseif strcmpi(Strategy,'INAGA1')
%     t = varargin{1};
%     TGen = varargin{2};
%     F_max = varargin{3};
%     F_m = varargin{4};
%     Pm = SA_Mutation_INAGA1(Pm_min,Pm_max,t,TGen,F_m,F_max);
% elseif strcmpi(Strategy,'INAGA2')
%     t = varargin{1};
%     TGen = varargin{2};
%     F_max = varargin{3};
%     F_ave = varargin{4};
%     F_m = varargin{5};
%     Pm = SA_Mutation_INAGA2(Pm_min,Pm_max,t,TGen,F_m,F_max,F_ave);
elseif strcmpi(Strategy,'CAGA')
    F_max = varargin{1};
    F_ave = varargin{2};
    F_m = varargin{3};
    Pm = SA_Mutation_CAGA(Pm_min,Pm_max,F_max,F_ave,F_m);
elseif strcmpi(Strategy,'SAGA')
    F_max = varargin{1};
    F_ave = varargin{2};
    F_m = varargin{3};    
    Pm = SA_Mutation_SAGA(Pm_min,Pm_max,F_max,F_ave,F_m);
       
end
end