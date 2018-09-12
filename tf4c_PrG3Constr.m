function [g,h] = PrG3c(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
n = 20;
% Constraints
h(:,1) = sum(x.^2,2)-1;
g= [];
