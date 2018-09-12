function Pc = SA_Crossover_SAGA(Pc_min,Pc_max,F_max,F_ave,F_c)

    Pc = ones(size(F_c))*Pc_max;
    flag = F_c >= F_ave;
    Pc(flag) = (Pc_max - Pc_min)./(1 + exp(9.903438.*(2.*(F_c(flag) - F_ave)./(F_max - F_ave) - 1))) + Pc_min;
    
end