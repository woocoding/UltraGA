function Pm = SA_Mutation_CAGA(Pm_min,Pm_max,F_max,F_ave,F_m)

    Pm = ones(size(F_m))*Pm_max;
    flag = F_m >= F_ave;
    Pm(flag) = (Pm_max + Pm_min)/2 + (Pm_max -Pm_min)/2.*cos((F_m(flag) - F_ave)./(F_max - F_ave).*pi);
    
end