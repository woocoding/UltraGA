% Syntax:  w = Selection(Method,Fs,varargin)
%
% Input parameters:
%    Method     - The method used for selection.
%    f          - the fitness values of the  individuals in the population.              
%    S          - (optional) % Tournament Size. default:S = 2
%    Rate       - Rate of individuals to be selected. default Rate = 2
% Output parameters:
%    w     - Vector containing the winners. default£ºw = [2*N,1]
%
% Author:     Xiaorui Wu

function w = Selection(Method,Fs,varargin)

N = size(Fs,1);
Rate = varargin{1};
Num = N*Rate;
if strcmpi(Method,'rw')
    w = RouletteWheel(Fs,N,Num);
elseif strcmpi(Method,'tr')
    w = Truncation(Fs,N,Num);
elseif strcmpi(Method,'to')
    S = varargin{2};
    w = Tournament(Fs,N,S,Num);
elseif strcmpi(Method,'su')
    w = StochasticUniversal(Fs,N,Num);
end

end
