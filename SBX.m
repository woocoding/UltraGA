%simulated binary crossover (SBX)
function children = SBX(husband,wife,couple,eta)

child1 = husband(1:2:end,:);
child2 = wife(1:2:end,:);
x2 = max(child1,child2);
x1 = min(child1,child2);
u = rand(size(x1));
betaq = zeros(size(x1));
flag1 = u <= 0.5; %u <= 0.5
flag2 = ~flag1;
betaq(flag1) = (2.*u(flag1)).^(1 / (eta + 1));
betaq(flag2) = (1./(2*(1 - u(flag2)))).^(1 / (eta + 1));
child1 = 0.5.*((1 + betaq).*x1 + (1 - betaq).*x2); 
child2 = 0.5.*((1 - betaq).*x1 + (1 + betaq).*x2); 
if mod(couple(1),2) == 1
    children = [child1;child2(1:end -1,:)];
else
    children = [child1;child2];
end

end