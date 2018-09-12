function y = PrG2f(x)
% Matlab Code by A. Hedar (Nov. 23, 2005).
n = 20; 
sum_jx = 0;
%for j=1:n; sum_jx = sum_jx+j.*x(:,j).^2; end
sum_jx = sum([1:n].*x.^2,2);
y = -abs((sum(cos(x).^4,2)-2.*prod(cos(x).^2,2))./sqrt(sum_jx));