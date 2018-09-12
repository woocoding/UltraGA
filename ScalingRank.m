% RANKING.M      (RANK-based fitness assignment)
%SP selective pressure

function f  = ScalingRank(ObjV, SP)

% Identify the vector size (Nind)
Nind = numel(ObjV);
f = zeros(Nind,1);
[~,Pos] = sort(ObjV,'descend');
num = [1:Nind]';
f(Pos) = 2 -SP + 2.*(SP - 1).*(num - 1)./(Nind - 1);
% fmin = min( f ) ;
% fmax = max( f ) ;
% fave = mean( f );
end
