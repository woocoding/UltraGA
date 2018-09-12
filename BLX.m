% blend crossover -alpha
% BLX - alpha Mode 1£º alpha = rand; Mode2 alpha = 0.5 (better); Mode3 beta = rand alpha = rand (Uniform) 
function children = BLX(husband,wife,couple,alpha)

if alpha == 'rand'
    alpha = rand(couple);
end

u = rand(couple);
gamma = (1 + 2*alpha).*u - alpha;
children = (1 - gamma).*min(husband,wife) + gamma.*max(husband,wife);
