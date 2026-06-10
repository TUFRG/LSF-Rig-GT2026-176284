function TSM = TunedSystemMode_TUFRG(r,N);

%N = 25;            % Number of blades
%r = 14;            % Mode number

s = 0;              % blade number
beta = 2*pi*r/N
a = 0;              % elastic axis location
eta = (a+1)/2;      % elastic axis location measured from leading edge
n = 30;             % Order of approximation (Whitehead Coefficients)
r_hub = 0.076;      % taken from geometry (m)
r_tip = 0.252;      % taken from geometry (m)
s_gap = (2*pi*(r_hub+r_tip)/2)/N;    % cascade spacing (m), currently set as spacing of blades at midspan
c = 0.08;           % Chord using taken from midspan (m)
b = c/2;            % Semichord (m)
m_b =  0.144; %       % blade mass (kg)
l_b = r_tip-r_hub;  % blade span (m)
m_s = m_b/l_b;       % mass per unit span (kgf/m)
Xideg = -28.5;%      % Stagger angle (deg)
rho = 2700;         % density of blade material (kg/m^3) currently aluminum 6061
mu_s = m_s/(pi*rho*b^2);       % Mass ratio of sth blade NONDIMENSIONAL
I_a = (m_s/12)*l_b^2; % (kgf*m) mass moment of inertia torsion axis, normalized to span, m_s normalizes
r_a_s = sqrt(I_a/(m_s*b^2) );      %radius of gyration of the sth blade (a = 0) ~ on eleastic axis NONDIMENSIONAL
U =  43*8; %43*20;             %Freestream velocity relative to the blade (m/s)

% Flat plate idealization calculating required torque
%cross section idealization
%{
a = c; %length of section (m)
b = 0.008; %width of section (m)
Jprime = (a*b^3)*[(16/3)-3.36*(b/a)*(1-((b^4)/12*(a^4)))]; % polor moment of inertia for a rectangular cross-section
G = 2.6e10; %shear modulus of aluminum 6061 in N/m2
T = theta*Jprime*G/l_b %torque (Nm)
%}

T = 0.048 * 0.102;        % torque Nm from ansys times 0.102 to get kgf*m
theta = deg2rad(0.05);    % angle of rotation from FEA (Rad)

K_a = T/theta;             % (Nm/rad)
omega_a = sqrt(K_a/I_a);   % NONDIMENSIONAL

t = 0.008;                 % thickness of plate (m)
E_y = 6.9e10;             % Young's modulus of aluminum6061 (N/m2)
nu = 0.33;                % Poisson's ratio al6061
e = 0.000074;             % deflection (m)
K_h = (E_y*t^3)/(12*(1-nu^2)) * 0.102; % times 0.102 to get kgf/m
omega_h = sqrt(K_h/m_s);   % NONDIMENSIONAL

disp(omega_h/omega_a)

%%PARAMETERS OF QUESTION%% Scale together from ratio
omega_a_s = omega_a;      %1 ; % taken from ratio of table 3 for NASA test rotor 12
omega_h_s = omega_h;      %0.357; %0.0001;  % taken from ratio of table 3 for NASA test rotor 12
omega_0 =  omega_a;       % reference freq. equal to the arithmetic mean of all blades torsional freqs
omega = (1775*2*pi/60);     % analysis freq.
lambda = omega*b/U;       %0.642;  % Frequency Parameter ~ to be calculated later

zeta_a_s = 0;             % damping ratio of sth blade in torsion
zeta_h_s = 0;             % damping ratio of sth blade in bending
x_a_s = 0;                % dimensionless static unbalance of sthblade x_a_s = S_a_s/(m_s*b)
S_a_s = 0;                % based on equation for x_a_s must be 0! static mass moment of sth blade per unit span about elastic axis, positive when center of gravity is aft of elastic axis

A = KazaATuned(r, n, N, lambda, c, s_gap, Xideg, beta, eta);

D = KazaDTuned(s, mu_s, r_a_s, omega_a_s, omega_h_s, zeta_a_s, zeta_h_s, x_a_s, S_a_s, omega_0);

G = KazaGTuned(s, mu_s, r_a_s, omega_a_s, omega_h_s, zeta_a_s, zeta_h_s, omega_0);

E = KazaETuned(s, r, N);

P = inv(E)*D*E + inv(E)*G*E*A;

Peig = eig(P);

realPart = real(Peig);
imagPart = imag(Peig);

% disp(1i./(Peig.^0.5))
eigenValues = (1i./(Peig.^0.5))

Palpha = ( (inv(E(2,2))) * (D(2,2)) * (E(2,2)) ) + ( (inv(E(2,2))) * (G(2,2)) * (E(2,2)) * (A(2,2)) );
TSMALPHAONLY = 1i*((sqrt(Palpha))^-1);

TSM =  eigenValues; % eigenValues(2,1);

end
