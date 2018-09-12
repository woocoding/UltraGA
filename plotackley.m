function plotackley(cx)
ezmesh('-20*exp(-0.2*sqrt(0.5*(x^2+y^2)))-exp(0.5*(cos(2*pi*x)+cos(2*pi*y))) + exp(1) + 20',cx)
