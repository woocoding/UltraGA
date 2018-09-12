function [L,x1]= TentRand(size,dim,x1)

N = size(1);
G = size(2);
L = zeros(N,G);

if nargin == 1
    dim = 1;
    L(1,:) = rand(1,G);
elseif  nargin == 2 
    if dim == 1
        L(1,:) = rand(1,G);
    elseif dim == 2
        L(:,1) = rand(N,1);
    end
elseif nargin == 3
    if dim == 1
        L(1,:) = x1;
    elseif dim == 2
        L(:,1) = x1;
    end
else
    
end

if dim == 1
    
    for i = 1:N -1
        if L(i,:) <= 0.5
            L(i + 1,:) = 2*L(i,:);
        else
            L(i + 1,:) = 2*(1 - L(i,:));
        end
    end
    
    x1 = L(N,:); 
    
elseif dim == 2
    
    for i = 1:G -1
        if L(:,i) <= 0.5
            L(:,i + 1) = 2*L(:,i);
        else
            L(:,i + 1) = 2*(1 - L(:,i));
        end
    end
    
    x1 = L(:,G);
    
end

end
