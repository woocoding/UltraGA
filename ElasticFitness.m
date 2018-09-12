function Fe= ElasticFitness(F,F_max,F_ave,c)
    a = F_ave*(c - 1)/(F_max - F_ave);
    b = F_ave*(F_max - c*F_ave)/(F_max - F_ave);
    Fe = a.*F + b;
end