%Efficient: 50% Truncation
function w = Truncation(f,N,Num)
[~,V] = sort(f); % Sort Fitness in Ascending Order
V = V(N/2+1:end); % Winner Pool
w = V(round(rand(Num,1)*(N/2 - 1)+1))';%Winners
end