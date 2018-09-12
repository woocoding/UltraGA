clear; 
%% Step 1: Roulette Wheel
F = [1:5,100]';
N = 6;
[~,V] = sort(F); % Sort Fitness in Ascending Order
V = V(N/2+1:end); % Winner Pool
W = V(round(rand(2*N,1)*(N/2-1)+1))';