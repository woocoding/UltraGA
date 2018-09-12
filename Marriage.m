function [Husband,Wife,Bachelor] = Marriage(pop,w,pc,idx) 

    winnermale = pop(w(1:2:end),:);
    winnerfemale = pop(w(2:2:end),:);
    ndim = size(winnermale);
    wpop = winnermale;
    flagfemale = idx == 2;
    wpop(flagfemale,:) = winnerfemale(flagfemale,:);
    pc = rand(ndim(1),1) < pc;
    Bachelor = wpop(~pc,:);
    Husband = winnermale(pc,:);
    Wife = winnerfemale(pc,:);
    
