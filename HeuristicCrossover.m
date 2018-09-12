%Wright¡¯s heuristic crossover (Wright, 1990)
function children = HeuristicCrossover(husband,wife,couple,CostFunc)

cost= CostFunc(husband);
f = FitnessScaling('rank',cost,2);
[~,I] = max(f);
BestFather = husband(I,:);
r = rand(couple);
children = r.*(BestFather - wife) + wife;

end