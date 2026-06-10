% Equation for script build:
% "Force and Moment Coefficient for Vibrating Airfoils in Cascade" (Whitehead, 1960) - Appendix IV
% Note: Building Matrix "A"

function A = WhiteheadA(n, lambda, c, s, beta, Xideg)

    A = zeros(n,n);

    % Geometry ratios
    csRat = c/s;
    a = csRat*cosd(Xideg);
    brat = csRat*sind(Xideg); % rename to avoid clash with b=semichord

    % Tolerance for infinite series
    tol = 1e-8;
    maxIterInner = 1e5; % safeguard against infinite loop

    for l = 0:(n-1)
        for m = 0:(n-1)

            % Define phi, theta, z
            phi   = (pi*(2*m+1))/(2*n);
            theta = (pi*l)/n;
            z =  0.5*(cos(phi) - cos(theta));

            % Define V(z)
            Vfun = @(zz) (1/4)*((a+1i*brat) .* exp(-(pi-beta)*(a+1i*brat)*zz) ./ sinh(pi*(a+1i*brat)*zz) ...
                              + (a-1i*brat) .* exp((pi-beta)*(a-1i*brat)*zz) ./ sinh(pi*(a-1i*brat)*zz));

            % First Term
            term1 = Vfun(-z);

            % Second Term (integral)
            integrand = @(z1) exp(-1i*lambda*z1).*Vfun(-z1) + 1./(2*pi*z1);
            integral_term = integral(integrand, z, 1);

             % Third Term (series1 with tolerance)
            series1 = 0;
            r = 0;
            while true
                numerator   = exp(-(2*pi*r + beta)*(a+1i*brat) - 1i*lambda);
                denominator = (2*pi*r + beta) + 1i*lambda/(a+1i*brat);
                term = numerator/denominator;
                series1 = series1 + term;
                if abs(term) < tol || r > maxIterInner, break; end
                r = r + 1;
            end
            series1 = 0.5*series1;

            % Fourth Term (series2 with tolerance)
            series2 = 0;
            r = 1;
            while true
                numerator   = exp(-(2*pi*r - beta)*(a-1i*brat) - 1i*lambda);
                denominator = (2*pi*r - beta) + 1i*lambda/(a-1i*brat);
                term = numerator/denominator;
                series2 = series2 + term;
                if abs(term) < tol || r > maxIterInner, break; end
                r = r + 1;
            end
            series2 = 0.5*series2;

            % Fifth Term (log term)
            log_term = (1/pi) * log(2);

            % Sixth Term (finite sum)
            finite_sum = 0;
            for r = 1:n
                weight = 1;
                if r == n, weight = 0.5; end % half-weight for the nth term
                finite_sum = finite_sum + weight * (1/r) * cos(pi*r*(2*m+1)/(2*n)) * cos(pi*r*l/n);
            end
            finite_sum = (1/pi)*finite_sum;

            % Final result for this element
            result = term1 + 1i*lambda*exp(1i*lambda*z) * ...
                     ( -integral_term + series1 + series2 + log_term + finite_sum );

            % Assign to matrix
            A(m+1, l+1) = result;
        end
    end
end
