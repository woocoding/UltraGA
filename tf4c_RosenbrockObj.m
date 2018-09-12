function y = tf4c_RosenbrockObj(x)
y = (1 - x(:,1)).^2 + 100*(x(:,2) - x(:,1)).^2;
end