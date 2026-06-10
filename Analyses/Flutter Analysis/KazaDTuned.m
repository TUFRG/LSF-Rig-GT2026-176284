function Ds = KazaDTuned(s, mu_s, r_a_s, omega_a_s, omega_h_s, zeta_a_s, zeta_h_s, x_a_s, S_a_s, omega_0);

  gamma_h_s = omega_h_s/omega_0;
  gamma_a_s = omega_a_s/omega_0;

  G_Kh_s = mu_s*(gamma_h_s^2)*(1+2i*zeta_h_s);
  G_Ka_s = mu_s*(r_a_s^2)*(gamma_a_s^2)*(1+2i*zeta_a_s);

  D11 = 1/G_Kh_s;
  D12 = x_a_s/G_Kh_s;
  D21 = x_a_s/G_Ka_s;
  D22 = (r_a_s^2)/G_Ka_s;

  Ds= mu_s*[D11, D12; D21, D22];

 end
