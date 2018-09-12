function idx = OnePointSplit(dims,varargin)

N = dims(1);
G = dims(2);
Ref = ones(N,1)*(1:G); % Reference Matrix
idx = (round(rand(N,1)*(G - 1)+1)*ones(1,G))>Ref;% Logical Index

end