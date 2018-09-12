function Pm = SA_Mutation_INAGA1(Pm_min,Pm_max,t,TGen,F,F_max)

m_tmp = exp(-abs((F_max - F)./F_max))./(1 + t./TGen).*Pm_max;

Pm = m_tmp;
flag = m_tmp < Pm_min;
Pm(flag) = Pm_min;

end