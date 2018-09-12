function [f,fmin,fmax,fave]  = ScalingSigma(ObjV,c)
Osigma = std( ObjV ) ;
Oave = mean( ObjV );
flag = (ObjV>Oave - c);
f = zeros(numel(ObjV),1);
f(flag) = ObjV(flag) - (Oave - c*Osigma);
fmin = min( f ) ;
fmax = max( f ) ;
fave = mean( f );
end
