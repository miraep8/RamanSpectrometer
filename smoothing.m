function smoothing = smoothing (data)

d = fdesign.lowpass('Fp,Fst,Ap,Ast',0.15,0.25,.5,1);
Hd = design(d,'butter');
smoothing = filter(Hd,data);

end
