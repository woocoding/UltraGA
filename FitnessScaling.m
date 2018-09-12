%linear:nonegative value fintnees 越大就越大
%rank:正负皆可 值越小越大
%exp:可以为正好数也可以为负数 越小适应度越大 
%MGA:越小越大 可以用于约束问题
function f = FitnessScaling(SMethod,F,varargin)

if strcmpi(SMethod,'linear')  
    Smul = varargin{1};
    f = ScalingLinear(F,Smul);
elseif strcmpi(SMethod,'rank')
    SP = varargin{1};
    F = - F;
    f = ScalingRank(F,SP);
elseif strcmpi(SMethod,'exp')
    alpha = varargin{1};
    F = - F;
    f = ScalingExp(F,alpha);
elseif strcmpi(SMethod,'MGA')
    g = varargin{2};
    MaxGen = varargin{3};
    f = ScalingNew(F,g,MaxGen);
end

