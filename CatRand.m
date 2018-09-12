function [L,x1]= CatRand(size,dim,x1)

N = size(1);
G = size(2);
L = zeros(N,G);
chaos = [1 1;1 2];

if nargin == 1
    dim = 1;
    InitalCat = rand(2,G);
    L(1,:) = InitalCat(1,:);
elseif  nargin == 2
    if dim == 1
        InitalCat = rand(2,G);
        L(1,:) = InitalCat(1,:);
    elseif dim == 2
        InitalCat = rand(N,2);
        L(:,1) = InitalCat(:,1);
    end
elseif nargin == 3
    if dim == 1
        L(1,:) = x1(1,:);
    elseif dim == 2
        L(:,1) = x1(:,1);
    end
else
    
end

if dim == 1
    
    for i = 1:N -1
        InitalCat = mod(chaos*InitalCat,1);
        L(i + 1,:) = InitalCat(1,:);
    end
    
    x1 = L(N,:);
    
elseif dim == 2
    
    for i = 1:G -1
        InitalCat = mod(InitalCat*chaos,1);
        L(:,i + 1) = InitalCat(:,1);
    end
    
    x1 = L(:,G);
    
end

end
