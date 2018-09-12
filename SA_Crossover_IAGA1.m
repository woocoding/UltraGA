function Pc = SA_Crossover_IAGA1(Pc_min,Pc_max,F_max,F_ave,F_p)
%pc1= 0.9, pc2=0.6
    Pc = ones(size(F_p))*Pc_max;
    flag = F_p >= F_ave;
    Pc(flag) = Pc_max - (Pc_max -Pc_min)./(F_max - F_ave).*(F_p(flag) - F_ave);
    
end