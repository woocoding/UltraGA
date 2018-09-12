function y = PrG2c(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
n = 20;
% Constraints
y(1) = -prod(x)+0.75;
y(2) = sum(x)-7.5*n;
% Variable lower bounds
for j=1:n; y(j+2) = -x(j); end
% Variable upper bounds
for j=1:n; y(j+n+2) = x(j)-10; end
% *************************************************************************
y=y'; 