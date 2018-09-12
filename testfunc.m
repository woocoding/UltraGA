function [CostFunction,VarMin,VarMax,Dir] = testfunc(tf,var)
Dir = 'min';
disp('Global minimum:')
if strcmpi(tf,'ackley')
    CostFunction = @(x) ackley(x);
    VarMin = -5*ones(1,var);
    VarMax = 5*ones(1,var);
    disp('f(0,0) = 0')
elseif strcmpi(tf,'fun00')
    Dir = 'max';
    CostFunction = @(x) fun00(x);
    VarMin = -5*pi*ones(1,var);
    VarMax = 5*pi*ones(1,var);
elseif strcmpi(tf,'sphere')
    CostFunction = @(x) Sphere(x);
    VarMin = -5*ones(1,var);
    VarMax = 5*ones(1,var);
    disp('f(0,0) = 0')
elseif strcmpi(tf,'hart6')
    var = 6;
    CostFunction = @(x) hart6(x);
    VarMin = -1*ones(1,var);
    VarMax = 1*ones(1,var);
    disp('The global minima:')
    disp(' x* =  (0.20169, 0.150011, 0.476874, 0.275332, 0.311652, 0.6573)')
    disp('f(x*) = - 3.32237')
elseif strcmpi(tf,'rosen')
    CostFunction = @(x) rosen(x);
    VarMin = -5*ones(1,var);
    VarMax = 10*ones(1,var);
    disp('f(1,1) = 0')
elseif strcmpi(tf,'griew')
    CostFunction = @(x) griew(x);
    VarMin = -50*ones(1,var);
    VarMax = 50*ones(1,var);
    disp('f(0,0) = 0')
elseif strcmpi(tf,'camel3')
    CostFunction = @(x) camel3(x);
    VarMin = -5*ones(1,var);
    VarMax = 5*ones(1,var);
    disp('f(0,0) = 0')
elseif strcmpi(tf,'holder')
    CostFunction = @(x) holder(x);
    VarMin = -10*ones(1,var);
    VarMax = 10*ones(1,var);
    disp('f(8.05502,9.66459) = -19.2085')
    disp('f(-8.05502,9.66459) = -19.2085')
    disp('f(8.05502,-9.66459) = -19.2085')
    disp('f(-8.05502,-9.66459) = -19.2085')
elseif strcmpi(tf,'drop')
    CostFunction = @(x) drop(x);
    VarMin = -2*ones(1,var);
    VarMax = 2*ones(1,var);
    disp('f(0,0) = -1')
elseif strcmpi(tf,'eggholder')
    CostFunction = @(x) eggholder(x);
    VarMin = -512*ones(1,var);
    VarMax = 512*ones(1,var);
    disp('f(512,404.2319) = -959.6407')
end
end