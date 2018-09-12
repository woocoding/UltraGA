function [Pc,Pm] = INAGA_1(Pc_max,Pc_min,Pm_max,Pm_min,F,F_max,t,TGen)

c_tmp = Pc_max*2^(-t/TGen);   
m_tmp = exp(-abs((F_max - F)./F_max))./(1 + t./TGen).*Pm_max;

if c_tmp > Pc_min
    Pc = c_tmp;
else
    Pc = Pc_min;
end

Pm = m_tmp;
flag = m_tmp < Pm_min;
Pm(flag) = Pm_min;

end