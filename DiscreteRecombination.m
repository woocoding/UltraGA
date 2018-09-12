%ÀëÉ¢ÖØ×é
function husband = DiscreteRecombination(husband,wife,couple)

idx = logical(round(rand(couple)));

husband(idx) = wife(idx);

end