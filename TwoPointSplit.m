function idx = TwoPointSplit(dims,varargin)

N = dims(1);
G = dims(2);
Ref = ones(N,1)*(1:G); % Reference Matrix
CP = sort(round(rand(N,2)*(G - 1)+1),2);%Cossover Points
idx = CP(:,1)*ones(1,G)<Ref & CP(:,2)*ones(1,G)>Ref; % Logical Index

end