function GAC = GeneralAxisCoefficents(n,lambda,c,s,beta,Xideg, eta);

Gam = WhiteheadGamma(n,lambda,c,s,beta,Xideg);

%{
outputs from gam look like this:

Gam = [Cfq, Cfa, Cfw;
              Cmq, Cma, Cmw]
%}

Cfq = Gam(1,1);
Cfa = Gam(1,2);
Cfw = Gam(1,3);
Cmq = Gam(2,1);
Cma = Gam(2,2);
Cmw = Gam(2,3);

Cfq_eta = Cfq;
Cfa_eta = Cfa - (1i*lambda*eta*Cfq);
Cfw_eta = exp(1i*lambda*eta)*Cfw;
Cmq_eta = Cmq - eta*Cfq;
Cma_eta = Cma - eta* Cfa - (1i*lambda*eta*Cmq) + (1i*lambda*(eta^2)*Cfq);
Cmw_eta = exp(1i*lambda*eta)*Cmw - eta*exp(1i*lambda*eta)*Cfw;

GAC =  [Cfq_eta, Cfa_eta, Cfw_eta; Cmq_eta, Cma_eta, Cmw_eta];

end
