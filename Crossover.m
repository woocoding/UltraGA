% Syntax:  Children = Crossover(Split,Method,Husband,Wife,Couple,varargin)
%
% Input parameters:
%    Split      - Crossover points
%    Method     - The method for crossover
%    Husband    - The individuals for crossover
%    Wife       - The individuals for crossover
%    Couple     - ndim of parents
% Output parameters:
%    Children
% Recommended Configuration:
% For binary crossover:
% 'Uniform'  \    / 'Swap'
% 'OnePoint'  | - \'Shuffle'
% 'TwoPoint' /
% For real code crossover:https://engineering.purdue.edu/~sudhoff/ee630/Lecture04.pdf
% 'Uniform'  \    
% 'OnePoint'  | - 'Swap'
% 'TwoPoint' /
% Tips:
% 1. For binary crossover, uniform crossover is more effective than one- or
% two point crossover. Two point is better than one point.
% 2. Binary crossover mentioned above can be used for real code crossover,
% but encouraged.(The methods have been deleted)
% Author:     Xiaorui Wu
function children = Crossover(Split,Method,husband,wife,CroPAR,varargin)

couple = size(husband);

if strcmpi(Split,'Uniform')
    %±≥∞¸Œ Ã‚
    if isempty(CroPAR)
        ChaosFlag = 0;
        Per = 0.5;
    else
        ChaosFlag = CroPAR{1};
        Per = CroPAR{2};
    end
    
    idx = UniformSplit(couple,ChaosFlag,Per);
    
    if strcmpi(Method,'Swap')
        children = Swap(husband,wife,idx);
    elseif strcmpi(Method,'Shuffle')
        children = Shuffle(husband,wife,idx,couple);
    end
    
elseif strcmpi(Split,'OnePoint')
    
    if strcmpi(Method,'Swap')
        idx = OnePointSplit(couple);
        children = Swap(husband,wife,idx);
    elseif strcmpi(Method,'sh') || strcmpi(Method,'Shuffle')
        idx = OnePointSplit(couple);
        children = Shuffle(husband,wife,idx,couple);
    elseif strcmpi(Method,'rs')
        % Reduced surrogate
        children = xovmp(husband,couple, 1, 1);
    end
    
elseif strcmpi(Split,'TwoPoint')
    
    if strcmpi(Method,'Swap')
        idx = TwoPointSplit(couple);
        children = Swap(husband,wife,idx);
    elseif strcmpi(Method,'sh') || strcmpi(Method,'Shuffle')
        idx = TwoPointSplit(couple);
        children = Shuffle(husband,wife,idx,couple);
    elseif strcmpi(Method,'rs')
        % Reduced surrogate
        children = xovmp(husband,couple, 2, 1);
    end
    
elseif strcmpi(Split,'ALL')
    
    if strcmpi(Method,'BLX')
        children = BLX(husband,wife,couple,CroPAR{1});
    elseif strcmpi(Method,'Boundary')
        children = BoundaryOperator(husband,wife,couple);
    elseif strcmpi(Method,'SBX')
        % This version need updating
        children = SBX(husband,wife,couple,CroPAR{1});
    elseif strcmpi(Method,'DIS')
        %discrete 
        children = DiscreteRecombination(husband,wife,couple);
    elseif strcmpi(Method,'INT')
        %Intermediate
        alpha = 0.5;
        children = ArithmeticCrossover(husband,wife,alpha);
    elseif strcmpi(Method,'LIN')
        %Extended line crossover
        alpha = (rand(couple(1),1)*1.5 - 0.25)*ones(1,couple(2));
        children = ArithmeticCrossover(husband,wife,alpha);
    elseif strcmpi(Method,'EIX')
        %Extended intermediate crossover (Muhlenbein et al., 1993)
        %This operator is equal to the BLX-0.25.
        alpha = rand(couple)*1.5 - 0.25;
        children = ArithmeticCrossover(husband,wife,alpha);
     elseif strcmpi(Method,'HEU')
        children = HeuristicCrossover(husband,wife,couple,varargin{1});
    end

elseif strcmpi(Split,'SPP') || strcmpi(Split,'SinglePoint Preservation')
    
    % Efficient SinglePoint Preservation
    Lidx = sub2ind(size(husband),[1:couple(1)]',round(rand(couple(1),1)...
        *(couple(2) - 1)+1));% Select Point
    vLidx = wife(Lidx)*ones(1,couple(1)); % Value of Point in Winners 2
    [r,c] = find(husband == vLidx); % Location of Values in Winners 1
    [~,Ord] = sort(r); % Sort Linear Indices
    r = r(Ord); c = c(Ord); % Reorder Linear Indices
    Lidx2 = sub2ind(size(husband),r,c); % Convert to Single Index
    husband(Lidx2) = husband(Lidx); % Crossover Part 1
    husband(Lidx) = wife(Lidx); % Validate Genomes
    children = husband;
    
end
end
