function [g,h]= PrG2c(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
n = 20;
% Constraints
g(:,1) = -prod(x,2)+0.75;
g(:,2) = sum(x,2)-7.5*n;
h = [];
