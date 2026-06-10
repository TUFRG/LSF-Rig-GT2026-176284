% Equation for script build:
% "Force and Moment Coefficient for Vibrating Airfoils in Cascade" (Whitehead, 1960) - Appendix IV
% Note: Building Matrix "B"

function B = WhiteheadB(n,lambda)

 B = zeros(n,3); %Create nx3 matrix

  for m = (0:n-1)

    kappa = 1 - cos(pi*(2*m+1)/(2*n));

    B(m+1,1) = 1;
    B(m+1,2) = 1 + 0.5*1i*lambda*kappa;
    B(m+1,3) = exp(-0.5*1i*lambda*kappa);

    mem = m;
   endfor
 end
