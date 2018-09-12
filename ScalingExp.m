%ObjV为目标函数值 可以为正好数也可以为负数 越小适应度越大 
function [f,fmin,fmax,fave] = ScalingExp(ObjV,alpha)
f = exp(-alpha.*ObjV);
fmin = min( f ) ;
fmax = max( f ) ;
fave = mean( f );
end
