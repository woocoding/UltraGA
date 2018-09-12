function y = hump(x)
% 
% Hump function 
% Matlab Code by A. Hedar (Sep. 29, 2005).
% The number of variables n = 2.
% 
y=1.0316285+4.*x(:,1).^2-2.1.*x(:,1).^4+x(:,1).^6./3+x(:,1).*x(:,2)-4.*x(:,2).^2+4.*x(:,2).^4;
