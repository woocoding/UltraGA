% SUS.M          (Stochastic Universal Sampling)
%
% This function performs selection with STOCHASTIC UNIVERSAL SAMPLING.
%
% Syntax:  NewChrIx = sus(FitnV, Nsel)
%
% Input parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the population.
%    Nsel      - number of individuals to be selected
%
% Output parameters:
%    NewChrIx  - column vector containing the indexes of the selected
%                individuals relative to the original population, shuffled.
%                The new population, ready for mating, can be obtained
%                by calculating OldChrom(NewChrIx,:).
%
% Author:     Hartmut Pohlheim (Carlos Fonseca)
% History:    12.12.93     file created
%             22.02.94     clean up, comments
%             22.01.03     tested under MATLAB v6 by Alex Shenfield

function w = StochasticUniversal(f,N,Num)

% Identify the population size (Nind)
%   [N,~] = size(f);

% Perform stochastic universal sampling
   cumfit = cumsum(f);
   trials = cumfit(N) / Num * (rand + (0:Num-1)');
   Mf = cumfit(:, ones(1, Num));
   Mt = trials(:, ones(1, N))';
   [w, ~] = find(Mt < Mf & [ zeros(1, Num); Mf(1:N-1, :) ] <= Mt);

% Shuffle new population
   [~, shuf] = sort(rand(Num, 1));
   w = w(shuf);
end


% End of function