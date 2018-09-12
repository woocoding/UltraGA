function Pc = AdaptiveCrossoverMode(Strategy,Pc_min,Pc_max,varargin)

if strcmpi(Strategy,'IAGA1')
    F_max = varargin{1};
    F_ave = varargin{2};
    F_c = varargin{3};
    Pc = SA_Crossover_IAGA1(Pc_min,Pc_max,F_max,F_ave,F_c);
    
% elseif strcmpi(Strategy,'INAGA1') || strcmpi(Strategy,'INAGA2') 
%     t = varargin{1};
%     TGen = varargin{2};
%     Pc = SA_Crossover_INAGA_1(Pc_min,Pc_max,t,TGen);
elseif strcmpi(Strategy,'CAGA') 
    F_max = varargin{1};
    F_ave = varargin{2};
    F_c = varargin{3};
    Pc = SA_Crossover_CAGA(Pc_min,Pc_max,F_max,F_ave,F_c); 
elseif strcmpi(Strategy,'SAGA') 
    F_max = varargin{1};
    F_ave = varargin{2};
    F_c = varargin{3};    
    Pc = SA_Crossover_SAGA(Pc_min,Pc_max,F_max,F_ave,F_c);
end
      
end