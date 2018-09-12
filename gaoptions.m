function options = gaoptions(varargin)

% Default options
options.SelfAdaptive = {'SAGA' {0.7 0.9} {0.001 0.5}}; 
options.Selection = {'rw' 2}; 
options.Crossover = {'all' 'BLX' 0.7 {0.5}}; 
options.Mutation = {'nor' 0.01 0.1}; 
options.FitnessScaling = {'rank' 2};
options.ChaosFlag = 1;
options.Elites = 0;
options.DemoMode = 'off' ;
options.FitnessLimit = -inf ;
options.Generations = 200 ;
options.InitialPopulation = [] ;
options.KnownMin = [] ;
options.PopInitRange = [0;1] ;
options.PopulationSize = 50 ;
options.PopulationType = 'rc' ;
options.StallGenLimit = 50 ;
options.StallTimeLimit = Inf ;
options.TimeLimit = Inf ;
options.TolCon = 1e-6 ;
options.TolFun = 1e-6 ;

requiredfields = fieldnames(options) ;

% Find any input arguments that match valid field names. If they exist,
% replace the default values with them.
for i = 1:size(requiredfields,1)
    idx = find(cellfun(@(varargin)strcmpi(varargin,requiredfields{i,1}),...
        varargin)) ;
    if ~isempty(idx)
        options.(requiredfields{i,1}) = varargin(idx(end) + 1) ;
        options.(requiredfields{i,1}) = options.(requiredfields{i,1}){:} ;
    end % for i
end


