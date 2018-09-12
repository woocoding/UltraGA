%g is a N x K matrix, h is a N x M matrix
%K is the quantity of inequality functions, M is is the quantity of 
%equality functions.
%c is a a N x (K + M) matrix
function f = ConstraintHandling(pop,ObjFcn,Constr)
cost = ObjFcn(pop);
[g,h] = Constr(pop);
n = size(pop,1);
fave = gamean(cost);
fmin = min(cost);
%fmax = max(cost);
fn = (cost - fmin) ./ (fave - fmin);

delta = 1e-4;
if isempty(h)
    c = max(0,g);
elseif isempty(g)
    c = max(0,abs(h) - delta);
else
    c = [max(0,g),max(0,abs(h) - delta)];
end
cmax = max(c,[],1);
cmax(cmax == 0) = 1;
v = gameandim(c./cmax,2);
flag_fes = sum(c,2) == 0;
Y = fn;
Y(flag_fes) = 0;
num_fes = sum(flag_fes); 
rf = num_fes/n;
if rf == 0
    d = v ;
    X = 0;
else
    d = sqrt(fn.^2 + v.^2);
    X = v;
end
p = (1 - rf)*X + rf*Y;
f = d + p;
end
