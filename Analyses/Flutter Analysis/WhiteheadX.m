% Equation for script build:
% "Force and Moment Coefficient for Vibrating Airfoils in Cascade" (Whitehead, 1960) - Appendix IV
% Note: Building Matrix "X"

function X = WhiteheadX(n)

  X = zeros(2,n);

  for l = 0:(n-1)

    X(1,l+1) = 1;
    X(2,l+1) = 0.5*(1-cos(pi()*l/n));

    lel = l;

  endfor
end
