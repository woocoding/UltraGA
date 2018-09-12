function z=fun00(x)
z=0;
for i=1:size(x,2)
    z=z+x(:,i).*sin(abs(x(:,i)));
end

