%PerMut Prob of Each Element Mutating
function pop= Mutation(Type,Method,pop,pm,varargin)

if strcmpi(Type,'bit')
    %     if strcmpi(Method,'flip')
    %Efficient: Boolean Mutation
    idx = rand(size(pop))<pm; % Index of Mutations
    pop(idx) = ~pop(idx);% Flip Bits
    %     end
elseif strcmpi(Type,'int')
    try
        MaxVal = varargin{1};
    catch
        disp('Integer Mutation, MaxVal was not set');
        disp('MaxVal will be 10');
        MaxVal = 10;
    end
    idx = rand(size(pop))<pm; % Index of Mutations
    pop(idx) = round(rand([1,sum(sum(idx))])*(MaxVal - 1)+1);% Mutated Value
elseif strcmpi(Type,'permutation')
    if strcmpi(Method,'swap')
        idx = rand(N,1)<pm; % Individuals to Mutate
        Loc1 = sub2ind(size(pop),1:N,round(rand(1,N)*(G - 1)+1));% Index Swap 1
        Loc2 = sub2ind(size(pop),1:N,round(rand(1,N)*(G - 1)+1));% Index Swap 2
        Loc2(idx == 0) = Loc1(idx==0); % Probabalistically Remove Swaps
        [pop(Loc1),pop(Loc2)] = deal(pop(Loc2), pop(Loc1)); % Perform Exchange
    elseif strcmpi(Method,'aswap')
        %���ڽ��� Adjacent Swap Mutation http://www.docin.com/p-545817013.html
        idx = rand(N,1)<pm; % Individuals to Mutate
        Loc1 = sub2ind(size(pop),1:N,round(rand(1,N)*(G - 2)+1));% Index Swap 1
        Loc2 = Loc1 + 1;
        Loc2(idx == 0) = Loc1(idx==0); % Probabalistically Remove Swaps
        [pop(Loc1),pop(Loc2)] = deal(pop(Loc2), pop(Loc1)); % Perform Exchange
    elseif strcmpi(Method,'re') || strcmpi(Method,'reversion')
        % ȡ�������� ����
        idx = rand(N,1)<pm; % Individuals to Mutate
        ndim = size(pop);
        idx1 = TwoPointSplit(ndim);
        idx1(~idx,:) = 0;
        for row = 1:ndim(1)
            pop(row,idx1(row,:)) = fliplr(pop(row,idx1(row,:)));
        end
    end
elseif strcmpi(Type,'rc') || strcmpi(Type,'realcode')
    if strcmpi(Method,'uni') || strcmpi(Method,'uniform')
        %uniform mutation
        % not good for convergence in the late stage
        ndim = size(pop);
        VarMin = ones(ndim(1),1)*varargin{1};
        VarMax = ones(ndim(1),1)*varargin{2};
        idx = rand(ndim)<pm; % Index of Mutations
        r = rand(ndim);
        pop(idx) =r(idx).*(VarMax(idx) - VarMin(idx)) + VarMin(idx);
    elseif strcmpi(Method,'bou') || strcmpi(Method,'boundary')
        %boundary_mutation �߽����� �ʺ����������ŵ�λ�ڻ��ӽ��ڿ��н��ı߽�ʱ��һ������
        VarMin = ones(size(pop,1),1)*varargin{1};
        VarMax = ones(size(pop,1),1)*varargin{2};
        idx = rand(size(pop))<pm; % Index of Mutations
        flag = round(rand(size(pop)));
        pop(idx) = flag(idx).*VarMax(idx) + (1 - flag(idx)).*VarMin(idx);
    elseif strcmpi(Method,'non') || strcmpi(Method,'nonuniform')
        %nonuniform_mutation ģ��ģ���˻�
        %�Ǿ��ȱ������� Ref.ʵ�������Ŵ��㷨�г��ñ������ӵ� Matlabʵ�ּ�Ӧ��
        VarMin = ones(size(pop,1),1)*varargin{1};
        VarMax = ones(size(pop,1),1)*varargin{2};
        b = varargin{3};%2~5
        g = varargin{4};
        MaxGen = varargin{5};
        ndim = size(pop);
        idx = rand(ndim)<pm; % Index of Mutations
        r = round(rand(ndim));
        g = 1 - rand(ndim).^((1 - g/MaxGen).^b);
        pop(idx) = pop(idx) + (1 - r(idx)).*(VarMax(idx) - pop(idx)).*g(idx) - r(idx).*( pop(idx) - VarMin(idx)).*g(idx);
    elseif strcmpi(Method,'nor') ||strcmpi(Method,'normal')
        %normal mutation
        VarMin = varargin{1};
        VarMax = varargin{2};   
        delta = varargin{3};%scalar one standard deviation for all variables or vector
        ndim = size(pop);
        sigma = ones(ndim(1),1)*((VarMax - VarMin).*delta);
        idx = randn(ndim)<pm; % Index of Mutations
        r = randn(ndim);
        pop(idx) = pop(idx) + sigma(idx).*r(idx);
    elseif strcmpi(Method,'cau') || strcmpi(Method,'cauchy')
        %normal mutation
        VarMin = varargin{1};
        VarMax = varargin{2};
        delta = varargin{3};%scalar (one standard deviation for all variables) or vector(�����ر���)
        ndim = size(pop);
        sigma = ones(ndim(1),1)*((VarMax - VarMin).*delta);
        idx = randn(ndim)<pm; % Index of Mutations
        %r = cauchyrnd(0,1,ndim);
        %r = tan(pi*(rand(ndim) - 0.5));
        r = cauchyinv(rand(ndim));
        pop(idx) = pop(idx) + sigma(idx).*r(idx);
    elseif strcmpi(Method,'pol') ||strcmpi(Method,'polynomial')
        %polynomial mutation http://www.cnblogs.com/devilmaycry812839668/p/6369991.html
        ndim = size(pop);
        VarMin = ones(ndim(1),1)*varargin{1};
        VarMax = ones(ndim(1),1)*varargin{2};
        eta = varargin{3};
        idx = rand(ndim)<pm; % Index of Mutations
        deltaVar = VarMax - VarMin;
        u = rand(ndim);%
        beta = zeros(ndim);
        flag1 = u <= 0.5; %u <= 0.5
        flag2 = ~flag1;
        beta(flag1) = (2*u(flag1)).^(1 / (eta + 1)) - 1;
        beta(flag2) = 1 - (2*(1 - u(flag2))).^(1 / (eta + 1));
        pop(idx) = pop(idx) + beta(idx).*deltaVar(idx);
    elseif strcmpi(Method,'pol1') ||strcmpi(Method,'polynomial1')
        %polynomial mutation http://www.cnblogs.com/devilmaycry812839668/p/6369991.html
        ndim = size(pop);
        VarMin = ones(ndim(1),1)*varargin{1};
        VarMax = ones(ndim(1),1)*varargin{2};
        eta = varargin{3};
        idx = rand(ndim)<pm; % Index of Mutations
        deltaVar = VarMax - VarMin;
        delta1 = 1*(pop - VarMin)./deltaVar;
        delta2 = 1*(VarMax - pop)./deltaVar;
        u = rand(ndim);%
        beta = zeros(ndim);
        flag1 = u <= 0.5; %u <= 0.5
        flag2 = ~flag1;
        beta(flag1) = (2*u(flag1) + (1 - 2*u(flag1)).*(1 - delta1(flag1)).^(eta + 1)).^(1 / (eta + 1)) - 1;
        beta(flag2) = 1 - (2*(1 - u(flag2)) + 2*(u(flag2) - 0.5).*(1 - delta2(flag2)).^(eta + 1)).^(1 / (eta + 1));
        pop(idx) = pop(idx) + beta(idx).*deltaVar(idx);
    elseif strcmpi(Method,'chaos')
        ndim = size(pop);
        VarMin = ones(ndim(1),1)*varargin{1};
        VarMax = ones(ndim(1),1)*varargin{2};
        idx = rand(ndim)<pm; % Index of Mutations
        A = (pop - VarMin) ./ (VarMax - VarMin);
        A = 4.*A.*(1 - A);
        pop(idx) = A(idx).*(VarMax(idx) - VarMin(idx)) + VarMin(idx);
    end
end


