function w = RouletteWheel(f,N,Num)
    [~,w] = min(ones(N,1)*(rand(1,Num))>((cumsum(f)*ones(1,Num)/sum(f))),[],1);
