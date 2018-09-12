%% Genetic Algorithm: Permutation Example
%
% Solves optimization problem where fitness is equal to the
% variance of genome differences. The optimal genome contains
%
% Optimal Genome : [5,7,3,9,1,10,2,8,4,6] OR [6,4,8,2,10,1,9,3,7,5]

%% Parameters
N = 1000; % Population Size
G = 10; % Genome Size
PerMut = .5; % Probability of Mutation
S = 2; % Tournament Size
[a,Pop] = sort(rand(N,G),2); % Create Initial Population
for Gen = 1:100 % Number of Generations
    
    %% Fitness
    F = var(diff(Pop,[],2),[],2); % Measure Fitness
    
    %% Print Stats
    fprintf('Gen: %d Mean Fitness: %d Best Fitness: %d\n', Gen, ...
        round(mean(F)), round(max(F)))
    
    %% Selection (Tournament)
    T = round(rand(2*N,S)*(N - 1)+1);
    % Tournaments
    [b,idx] = max(F(T),[],2); % Index to Determine Winners
    W = T(sub2ind(size(T),(1:2*N)',idx)); % Winners
    
    %% Crossover (SinglePoint Preservation)
    Pop2 = Pop(W(1:2:end),:); % Assemble Pop2 Winners 1
    P2A = Pop(W(2:2:end),:); % Assemble Pop2 Winners 2
    Lidx = sub2ind(size(Pop),[1:N]',round(rand(N,1)*(G-1)+1));
    % ...Select Point
    vLidx = P2A(Lidx)*ones(1,G); % Value of Point in Winners 2
    [x,c] = find(Pop2 == vLidx); % Location of Values in ...Winners 1
    [d,Ord] = sort(r); % Sort Linear Indices
    r = r(Ord); c = c(Ord); % Reorder Linear Indices
    Lidx2 = sub2ind(size(Pop),r,c); % Convert to Single Index
    Pop2(Lidx2) = Pop2(Lidx); % Crossover Part 1
    Pop2(Lidx) = P2A(Lidx); % Validate Genomes
    %% Mutation (Permutation)
    idx = rand(N,1)<PerMut; % Individuals to Mutate
    Loc1 = sub2ind(size(Pop2),1:N,round(rand(1,N)*(G-1)+1));
    % Index ...Swap 1
    Loc2 = sub2ind(size(Pop2),1:N,round(rand(1,N)*(G-1)+1));
    % Index ...Swap 2
    Loc2(idx == 0) = Loc1(idx==0); % Probabalistically Remove ...Swaps
    [Pop2(Loc1),Pop2(Loc2)] = deal(Pop2(Loc2), Pop2(Loc1)); % Perform ...Exchange
    %% Reset Population
    Pop = Pop2;
end
[d,BN] = max(F); % Find Best Genome
disp('Best Genome: ') % Write Text to Console
disp(Pop(BN,:)) % Display Best Genome