% Output Coeffiecents as matrix
function Gam = WhiteheadGamma(n,lambda,c,s,beta,Xideg);

  A = WhiteheadA_V2(n, lambda, c, s, beta, Xideg);
  B = WhiteheadB(n,lambda);

   Ainv = inv(A);

   GAMMA = Ainv*B;


% isolating gamma terms [yq, ya, yw]
GammaCoeff = zeros(n,3);

for l = 1:n

  s = (pi/(2*n)) * sin(pi*l/n);
  GAMMARow = GAMMA(l,:);
  GammaCoeff(l,:) = GAMMARow / s;

endfor


% calculationg Cfq from summation
finiteCfq = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,1);
  finiteCfq = finiteCfq + weight * gammaq_val * (0.5*sin(pi*l/n)*(pi/n));
  end
Cfq = -(1/pi)*finiteCfq;

% calculationg Cfa from summation
finiteCfa = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,2);
  finiteCfa = finiteCfa + weight * gammaq_val * (0.5*sin(pi*l/n)*(pi/n));
  end
Cfa = -(1/pi)*finiteCfa;

% calculationg Cfw from summation
finiteCfw = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,3);
  finiteCfw = finiteCfw + weight * gammaq_val * (0.5*sin(pi*l/n)*(pi/n));
  end
Cfw = -(1/pi)*finiteCfw;

% calculationg Cmq from summation
finiteCmq = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,1);
  finiteCmq = finiteCmq + weight * gammaq_val * (0.5*(1-cos(pi*l/n))*(0.5*sin(pi*l/n)*(pi/n)));
  end
Cmq = -(1/pi)*finiteCmq;

% calculationg Cma from summation
finiteCma = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,2);
  finiteCma = finiteCma + weight * gammaq_val * (0.5*(1-cos(pi*l/n))*(0.5*sin(pi*l/n)*(pi/n)));
  end
Cma = -(1/pi)*finiteCma;

% calculationg Cmw from summation
finiteCmw = 0;
  for l = 1:n
  weight = 1;
  if l == n, weight = 0.5; end % half-weight for the nth term
  gammaq_val = GammaCoeff(l,3); % index in small gamma matrix
  finiteCmw = finiteCmw + weight * gammaq_val * (0.5*(1-cos(pi*l/n))*(0.5*sin(pi*l/n)*(pi/n)));
  end
Cmw = -(1/pi)*finiteCmw;

Gam = [Cfq, Cfa, Cfw; Cmq, Cma, Cmw];

end
