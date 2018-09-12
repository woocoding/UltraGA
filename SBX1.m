%simulated binary crossover (SBX)
function Husband = SBX1(Husband,Wife,idx,Couple,eta,VarMin,VarMax)

VarMin = ones(Couple(1),1)*VarMin;
VarMax = ones(Couple(1),1)*VarMax;
x2 = max(Husband,Wife);
x1 = min(Husband,Wife);
u = rand(Couple);
betaq = zeros(Couple);

deltax = x2 - x1;
for i = 1:2
    
    if i == 1
        beta = 1  + 2.* (x1 - VarMin)./deltax;
    else
        beta = 1  + 2.* (VarMax - x2)./deltax;
    end
    alpha = 2 - beta.^-(eta + 1);
    flag1 = u <= (1./alpha); %u <= 0.5
    flag2 = ~flag1;
    betaq(flag1) = (alpha(flag1).*u(flag1)).^(1 / (eta + 1));
    betaq(flag2) = (1./(2-alpha(flag2).*u(flag2))).^(1 / (eta + 1));
    if i == 1
        Husband(idx) = 0.5.*((x1(idx) + x2(idx)) + betaq(idx).*(x2(idx) - x1(idx)) );
        Husband=max(Husband,VarMin);
        Husband=min(Husband,VarMax);
    else
        Wife(idx) = 0.5.*((x1(idx) + x2(idx)) + betaq(idx).*(x2(idx) - x1(idx)) );
        Wife=max(Wife,VarMin);
        Wife=min(Wife,VarMax);
    end
    
end
Husband = [Husband;Wife];

end