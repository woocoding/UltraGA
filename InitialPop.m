% Initial Population
% N: the number of individuals
% G: Genome length
function Pop = InitialPop(N,G,Type,varargin)

if  nargin < 3
    Type = 'bit';
end

if strcmpi(Type,'bit') || strcmpi(Type,'Binary')
    %Random Boolean
    Pop = round(rand(N,G));
elseif strcmpi(Type,'sbit') || strcmpi(Type,'SB')
    %Skewed Boolean
    try
        if varargin{1} > 1 || varargin{1} < 0
            disp('PerOnes was out of range.It must be between 0 and 1');
        end
    catch
        warning('PerOnes was not set, PerOnes will be 0.5');
        warning('Now Skewed Boolean = Random Boolean');
        varargin{1} = 0.5;
    end
    PerOnes = varargin{1};
    Pop = round(rand(N,G)+(PerOnes - .5));
elseif strcmpi(Type,'int') || strcmpi(Type,'Integer')
    %Random Integers
    try
        MaxVal = varargin{1}; % Maximum Gene Value
    catch
        warning('MaxVal was not set, MaxVal will be 10');
        warning('Generate [1~MaxVal]');
        varargin{1} = 10;
        MaxVal = varargin{1}; % Maximum Gene Value
    end
    Pop = round(rand(N,G)*(MaxVal - 1)+1);
elseif strcmpi(Type,'intdd') || strcmpi(Type,'idd')
    %Random Integers - Defined Distibution
    CD = cumsum(arg); % CumSum
    if CD(end) ~= 1
        disp('Distibution Input is wrong');
    end
    MaxVal = size(CD,2); % Max Integer Value
    [~,Pop] = min(repmat(rand(N,G),[1,1,MaxVal])> ...
        repmat(reshape(CD,[1,1,MaxVal]),[N,G,1]),[],3); % Binning
elseif strcmpi(Type,'Permutations') || strcmpi(Type,'Permutation')
    % Random Permutations N*randperm(G)
    [~,Pop] = sort(rand(N,G),2);
elseif strcmpi(Type,'rc') || strcmpi(Type,'realcode')
    %column vector
    VarMin = varargin{1};
    VarMax = varargin{2};
    if nargin == 6
        chaos = varargin{3};
    else
        chaos = 0;
    end
    Pop = ((chaos*CatRand([N,G]) + (1-chaos)*rand(N,G)).*(VarMax - VarMin) + VarMin);
    
end

end

