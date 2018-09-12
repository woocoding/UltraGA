function Pc = SA_Crossover_CAGA(Pc_min,Pc_max,F_max,F_ave,F_c)

    Pc = ones(size(F_c))*Pc_max;
    flag = F_c >= F_ave;
    Pc(flag) = (Pc_max + Pc_min)/2 + ((Pc_max -Pc_min)/2).*cos((F_c(flag) - F_ave)./(F_max - F_ave).*pi);
    
end