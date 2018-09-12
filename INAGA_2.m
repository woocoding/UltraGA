function [Pc,Pm] = INAGA_2(Pc_max,Pc_min,Pm_max,Pm_min,F,F_max,F_ave,t,TGen)

c_tmp = Pc_max*2^(-t/TGen);
if F_max > 0
    m_tmp = exp(-abs((F_max - F)./F_max))./(1 + t./TGen).*Pm_max;
else
    m_tmp = exp(-abs((F_max - F)./F_ave))./(1 + t./TGen).*Pm_max;
end

if c_tmp > Pc_min
    Pc = c_tmp;
else
    Pc = Pc_min;
end

Pm = m_tmp;
flag = m_tmp < Pm_min;
Pm(flag) = Pm_min;

end