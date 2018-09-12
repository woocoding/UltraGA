function [g,h]= tf4c_RosenbrockConstr(x)
g(:,1) = (x(:,1) - 1).^3 - x(:,2) + 1;
g(:,2) = x(:,1) + x(:,2) - 2;
h = [];
end