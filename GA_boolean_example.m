% Genetic Algorithm: Boolean Example

%  Solves optimization problem where fitness is equal to the
%  summed absolute value of genome differences. The optimal genome contains
%  alternating values.

%  Optimal Genome : [0,1,0,1,.....,1,0] OR [1,0,1,0,.....,0,1]

% Parameters
N = 1000; % Population Size
G = 30; % Genome Size
PerMut = .01; % Probability of Mutation
S = 2; % Tournament Size
Pop = round(rand(N,G)); % Create Initial Population

for Gen = 1:100 % Number of Generations
    %% Fitness
    F = sum(abs(diff(Pop,[],2)),2); % Measure Fitness
    
    %% Print Stats
    fprintf('Gen: %d Mean Fitness: %d Best Fitness: %d\n', Gen, ...
        round(mean(F)), max(F))
    
    %% Selection (Tournament)
    T = round(rand(2*N,S)*(N - 1)+1);%Tournament
    [a,idx] = max(F(T),[],2); % Index to Determine Winners
    W = T(sub2ind(size(T),(1:2*N)',idx)); % Winners
    
    %% Crossover (2Point)
    Pop2 = Pop(W(1:2:end),:); % Set Pop2 = Pop Winners 1
    P2A = Pop(W(2:2:end),:); % Assemble Pop2 Winners 2
    Ref = ones(N,1)*(1:G); % Reference Matrix
    CP = sort(round(rand(N,2)*(G-1)+1),2);%crossover Points
    idx = CP(:,1)*ones(1,G)<Ref & CP(:,2)*ones(1,G)>Ref; % Logical Index
    Pop2(idx) = P2A(idx); % Recombine Winners
    
    %% Mutation (Boolean)
    idx = rand(size(Pop2))<PerMut; % Index of Mutations
    Pop2(idx) = Pop2(idx)*(-1)+1; %flip Bits
    
    %% Reset
    Pop = Pop2;
end
[b,BN] = max(F);
disp('Best Genome: ')
disp(Pop(BN,:))