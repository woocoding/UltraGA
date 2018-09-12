function y = rosen(x)
% 
% Rosenbrock function
% Matlab Code by A. Hedar (Nov. 23, 2005).
% The number of variables n should be adjusted below.
% The default value of n = 2.
% 
n = 2;
sum = 0;
for j = 1:n-1
    sum = sum+100.*(x(:,1) - x(:,2).^2).^2 + (x(:,2) -1).^2;
end
y = sum;
