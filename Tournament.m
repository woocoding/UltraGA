% Tournament
% S: Tournament Size
function w = Tournament(f,N,S,Num)
% Selection (Tournament)
T = round(rand(Num,S)*(N - 1)+1);
% Tournaments
[~,idx] = max(f(T),[],2); % Index to Determine Winners
w = T(sub2ind(size(T),(1:Num)',idx)); % Winners
end