function children = ArithmeticCrossover(husband,wife,alpha)
% if strcmpi(Method,'int')
%     alpha = 0.5;
% elseif strcmpi(Method,'lin')
%     alpha = (rand(couple(1),1)*1.5 - 0.25)*ones(1,couple(2));
% elseif strcmpi(Method,'ari')
%     alpha = rand(couple)*1.5 - 0.25;
% end
    
children = alpha.*husband + (1 - alpha).*wife;