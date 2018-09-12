function y = PrG1f(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
x1 = x(:,1:4); x2 = x(:,5:13);
y = 5.*sum(x1,2)-5.*sum(x1.*x1,2)-sum(x2,2);