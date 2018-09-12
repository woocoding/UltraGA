function Pc = SA_Crossover_INAGA1(Pc_max,Pc_min,t,TGen)

c_tmp = Pc_max*2^(-t/TGen);   

if c_tmp > Pc_min
    Pc = c_tmp;
else
    Pc = Pc_min;
end

end