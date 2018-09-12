function Pm = SA_Mutation_IAGA1(Pm_min,Pm_max,F_max,F_ave,F_m)
%pm1=0.1 and pm2=0.00
    Pm = ones(size(F_m))*Pm_max;
    flag = F_m >= F_ave;
    Pm(flag) = Pm_max - (Pm_max -Pm_min)./(F_max - F_ave).*(F_m(flag) - F_ave);
    
end