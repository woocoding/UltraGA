%ObjV为目标函数值 要求为正数 越小适应度越大 
function f = ScalingNew(ObjV,g,MaxGen)

m = 1 + log(MaxGen);
f = floor(g^(1/m))./ObjV;
% fmin = min( f ) ;
% fmax = max( f ) ;
% fave = mean( f );
