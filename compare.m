%clear
% N = 10;
% G = 4;
% MaxVal = 5;
% Encoding = 'Integer';
% %[Chrom, Lind, BaseV] = crtbp(N, G, 6)
% ObjV=[-1 2 3 4 5 100 9 8 7 -6]';
% FitnV = Ranking(ObjV,[1.9,1],1)
% %FitnV = scaling(ObjV,10)
% %NewChrIx = rws(FitnV,100)
% %NewChrIx = sus(FitnV,100)
% %SelCh = select('sus', Chrom, FitnV, 0.2);
% %NewChrom = recombin('recint', SelCh, 1);
%Strategy = 'IAGA1';
%Strategy = 'INAGA2';
Strategy = 'CAGA';
%Strategy = 'SAGA';
% PcMin = 0.5; PcMax = 0.9;
% PmMin = 0.005; PmMax = 0.1;
% fc = [1:100];
% fmax = max(fc);
% fave = mean(fc);
% Pc = AdaptiveMutationMode(Strategy,PcMin,PcMax,fmax,fave,fc);
% plot(Pc)
% ylim([0 1])
% hold on;
% pop = eye(10);
% repop = pop(:,end:-1:1);
% idx1 = TwoPointSplit(size(pop));
% idx1(1,:) = 0;
% pop(8,idx1(8,:)) = fliplr(pop(2,idx1(8,:)))
       ndim = size(pop);
        idx1 = TwoPointSplit(ndim);
        %idx1(~idx,:) = 0;
        for row = 1:ndim(1)
            pop(row,idx1(row,:)) = fliplr(pop(row,idx1(row,:)));
        end