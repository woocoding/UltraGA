function F = ConstraintHandling1(pop,Obj,Constr)
f = Obj(pop);
[g,h] = Constr(pop);
fave = mean(f);
delta = 1e-4;
if isempty(h)
    c = max(0,g);
else
    c = [max(0,g),max(0,abs(h) - delta)];
end
flag_infes = sum(c,2) ~= 0;
flag_lave = f < fave;
flag = flag_infes & flag_lave;
F = f;
F(flag) = fave;
cave = mean(c,1);
k = abs(fave)*cave./sum(cave.^2);
F = F + sum(k.*c,2);
end

 