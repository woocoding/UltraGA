% blend crossover -alpha
% BLX - alpha Mode 1£º alpha = rand; Mode2 alpha = 0.5 (better); Mode3 beta = rand alpha = rand (Uniform)
function Husband = Shuffle(Husband,Wife,idx,Couple)

[~,shuffle] = sort(rand(Couple),2);

for i =1:Couple(1)
    tmpH = Husband(i,:);
    tmpW = Wife(i,:);
    Husband(i,:) = tmpH(shuffle(i,:));
    Wife(i,:) = tmpW(shuffle(i,:));
end

Husband(idx) = Wife(idx);

end