function Pm = SA_Mutation_SAGA(Pm_min,Pm_max,F_max,F_ave,F_m)

    Pm = ones(size(F_m))*Pm_max;
    flag = F_m >= F_ave;
    Pm(flag) = (Pm_max - Pm_min)./(1 + exp(9.903438.*(2.*(F_m(flag) - F_ave)./(F_max - F_ave) - 1))) + Pm_min;
    
end