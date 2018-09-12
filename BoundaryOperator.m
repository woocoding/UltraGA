function children = BoundaryOperator(husband,wife,couple)

alpha = rand(couple);
children = sqrt(alpha.*husband.^2 + (1 - alpha).*wife.^2);% Recombine Winners

end