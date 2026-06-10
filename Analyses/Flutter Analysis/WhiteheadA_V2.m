function A = WhiteheadA_V2(n, lambda, c, s, beta, Xideg)

A = zeros(n,n);

a = (c/s)*cosd(Xideg);
b = (c/s)*sind(Xideg);

% Tolerance for infinite series
tol = 1e-8;
maxIterInner = 1e5; % safeguard against infinite loop

if beta == 0
    VinfFun = -0.5*(a + 1i*b);
elseif beta > 0 && beta < 2*pi
    VinfFun = 0;
else
    disp("Beta is out of range!");
    return;   % stops the script or function here
end

 for l = (0:n-1)
        for m = (0:n-1)


          phi = pi*(2*m+1)/(2*n);
          theta = pi*l/n;
          z = 0.5*(cos(phi)-cos(theta));


          % Define V(z)
          Vfun = @(zz) ( (0.25*(a+1i*b)) .* (exp(-1*(pi-beta)*(a+1i*b)*zz) ./ (sinh(pi*(a+1i*b)*zz))) ) ...
                 + ( (0.25*(a-1i*b)) .* (exp((pi-beta)*(a-1i*b)*zz) ./ (sinh(pi*(a-1i*b)*zz))) );


          term1 = Vfun(-z);

          % Second Term (integral)
          integrand = @(z1) exp(-1i*lambda*z1).*Vfun(-z1) + 1./(2*pi*z1);
          integral_term = integral(integrand, z, 1);



          % Third Term (series1 with tolerance)
          series1 = 0;
          r = 0;
          while true
              numerator1   = exp(-(2*pi*r + beta)*(a+1i*b) - 1i*lambda);
              denominator1 = (2*pi*r + beta) + 1i*lambda/(a+1i*b);
              termSeries1 = numerator1/denominator1;
              series1 = series1 + termSeries1;
              if abs(termSeries1) < tol || r > maxIterInner, break; end
              r = r + 1;
          end
          series1 = 0.5*series1;

          % Fourth Term (series2 with tolerance)
          series2 = 0;
          r = 1;
          while true
              numerator2   = exp(-(2*pi*r - beta)*(a-1i*b) - 1i*lambda);
              denominator2 = (2*pi*r - beta) + 1i*lambda/(a-1i*b);
              termSeries2 = numerator2/denominator2;
              series2 = series2 + termSeries2;
              if abs(termSeries2) < tol || r > maxIterInner, break; end
              r = r + 1;
          end
          series2 = 0.5*series2;

          % Final result for this element
          kz_prime = term1 + 1i*lambda*exp(1i*lambda*z) * ...
                   ( -integral_term + series1 + series2 ); % + log_term + finite_sum  %%% removed

          kz_final = kz_prime - ((1i*lambda/(2*pi))*exp(1i*lambda*z)*log(abs(z)));% added approximation adjustment Whitehead (A8)

          % Assign to matrix
          A(m+1, l+1) = kz_final;

        endfor
 endfor

 end
