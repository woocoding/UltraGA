function Pm = SA_Mutation_INAGA2(Pm_min,Pm_max,t,TGen,F,F_max,F_ave)

if F_max > 0
    m_tmp = exp(-abs((F_max - F)./F_max))./(1 + t./TGen).*Pm_max;
else
    m_tmp = exp(-abs((F_max - F)./F_ave))./(1 + t./TGen).*Pm_max;
end

Pm = m_tmp;
flag = m_tmp < Pm_min;
Pm(flag) = Pm_min;

end