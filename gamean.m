function y = gamean(x)
%MEAN   Average or mean value.
%Modified MEAN
%flag = 'default';

dim = find(size(x)~=1,1);
y = sum(x, dim)/size(x,dim);

