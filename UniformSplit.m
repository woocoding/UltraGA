function idx = UniformSplit(dims,varargin)

if nargin == 1
    ChaosFlag = 0;
    Per = 0.5;    
elseif nargin == 2
    ChaosFlag = varargin{1};
    Per = 0.5;
else
    ChaosFlag = varargin{1};
    Per = varargin{2};
end
idx = logical(round((ChaosFlag*(CatRand(dims,2) + Per - 0.5) + (1-ChaosFlag)*(rand(dims) + Per - 0.5)))); % Index of Genome from Winner 2
end