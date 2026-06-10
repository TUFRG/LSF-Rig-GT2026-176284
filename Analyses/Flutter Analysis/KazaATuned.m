function ArTuned = KazaATuned(r, n, N, lambda, c, s, Xideg, beta, eta);

  %%% Force and Moment coeffiecnt array setup (scripts) %%%

  GAC = GeneralAxisCoefficents(n,lambda,c,s,beta,Xideg, eta);


  %%% ---- Defining force and moment coefficents ---- %%%
  % Each variable defined from Matrix in Whitehead, 1960

  Cfq_eta = GAC(1,1);
  Cfa_eta = GAC(1,2);
  Cfw_eta = GAC(1,3);
  Cmq_eta = GAC(2,1);
  Cma_eta = GAC(2,2);
  Cmw_eta = GAC(2,3);

  %%% ---- Coefficient calculation ---- %%%
  Chh = (2i/lambda)*Cfq_eta;
  Caa = (4/lambda^2)*Cma_eta;
  Cha = (2/lambda^2)*Cfa_eta;
  Cah = (4i/lambda)*Cmq_eta;

  A11 = Chh;
  A12 = Cha;
  A21 = Cah;
  A22 = Caa;

ArTuned =  [A11, A12; A21, A22];

end
